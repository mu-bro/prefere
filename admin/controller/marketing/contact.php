<?php
class ControllerMarketingContact extends Controller {
	private $error = array();

	public function index() {
		$data = $this->load->language('marketing/contact');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['token'] = $this->session->data['token'];

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('marketing/contact', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['cancel'] = $this->url->link('marketing/contact', 'token=' . $this->session->data['token'], 'SSL');

		$this->load->model('setting/store');

		$data['stores'] = $this->model_setting_store->getStores();

		$this->load->model('customer/customer_group');

		$data['customer_groups'] = $this->model_customer_customer_group->getCustomerGroups();

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('marketing/contact.tpl', $data));
	}

	public function send() {
		$this->load->language('marketing/contact');

		$json = array();

		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			if (!$this->user->hasPermission('modify', 'marketing/contact')) {
				$json['error']['warning'] = $this->language->get('error_permission');
			}

			if (!$this->request->post['subject']) {
				$json['error']['subject'] = $this->language->get('error_subject');
			}

			if (!$this->request->post['message']) {
				$json['error']['message'] = $this->language->get('error_message');
			}

			if (!$json) {
				$this->load->model('setting/store');

				$store_info = $this->model_setting_store->getStore($this->request->post['store_id']);

				if ($store_info) {
					$store_name = $store_info['name'];
				} else {
					$store_name = $this->config->get('config_name');
				}

				$this->load->model('customer/customer');

				$this->load->model('customer/customer_group');

				$this->load->model('marketing/affiliate');

				$this->load->model('sale/order');

				$this->load->model('common/newsletter');

				if (isset($this->request->get['page'])) {
					$page = $this->request->get['page'];
				} else {
					$page = 1;
				}

				$email_total = 0;

				$emails = array();

				switch ($this->request->post['to']) {
					case 'newsletter':
						$customer_data = array(
							'start'             => ($page - 1) * 10,
							'limit'             => 10
						);

						$results = $this->model_common_newsletter->getNewsLetter($customer_data);

						$email_total = $this->model_common_newsletter->getNewsLetterTotal();

						foreach ($results as $result) {
							$emails[] = $result['news_email'];
						}
						break;
					case 'customer_all':
						$customer_data = array(
							'start' => ($page - 1) * 10,
							'limit' => 10
						);

						$email_total = $this->model_customer_customer->getTotalCustomers($customer_data);

						$results = $this->model_customer_customer->getCustomers($customer_data);

						foreach ($results as $result) {
							$emails[] = $result['email'];
						}
						break;
					case 'customer_group':
						$customer_data = array(
							'filter_customer_group_id' => $this->request->post['customer_group_id'],
							'start'                    => ($page - 1) * 10,
							'limit'                    => 10
						);

						$email_total = $this->model_customer_customer->getTotalCustomers($customer_data);

						$results = $this->model_customer_customer->getCustomers($customer_data);

						foreach ($results as $result) {
							$emails[$result['customer_id']] = $result['email'];
						}
						break;
					case 'customer':
						if (!empty($this->request->post['customer'])) {
							foreach ($this->request->post['customer'] as $customer_id) {
								$customer_info = $this->model_customer_customer->getCustomer($customer_id);

								if ($customer_info) {
									$emails[] = $customer_info['email'];
								}
							}
						}
						break;
					case 'affiliate_all':
						$affiliate_data = array(
							'start' => ($page - 1) * 10,
							'limit' => 10
						);

						$email_total = $this->model_marketing_affiliate->getTotalAffiliates($affiliate_data);

						$results = $this->model_marketing_affiliate->getAffiliates($affiliate_data);

						foreach ($results as $result) {
							$emails[] = $result['email'];
						}
						break;
					case 'affiliate':
						if (!empty($this->request->post['affiliate'])) {
							foreach ($this->request->post['affiliate'] as $affiliate_id) {
								$affiliate_info = $this->model_marketing_affiliate->getAffiliate($affiliate_id);

								if ($affiliate_info) {
									$emails[] = $affiliate_info['email'];
								}
							}
						}
						break;
					case 'product':
						if (isset($this->request->post['product'])) {
							$email_total = $this->model_sale_order->getTotalEmailsByProductsOrdered($this->request->post['product']);

							$results = $this->model_sale_order->getEmailsByProductsOrdered($this->request->post['product'], ($page - 1) * 10, 10);

							foreach ($results as $result) {
								$emails[] = $result['email'];
							}
						}
						break;
				}

				if ($emails) {
					$start = ($page - 1) * 10;
					$end = $start + 10;

					if ($end < $email_total) {
						$json['success'] = sprintf($this->language->get('text_sent'), $start, $email_total);
					} else {
						$json['success'] = $this->language->get('text_success');
					}

					if ($end < $email_total) {
						$json['next'] = str_replace('&amp;', '&', $this->url->link('marketing/contact/send', 'token=' . $this->session->data['token'] . '&page=' . ($page + 1), 'SSL'));
					} else {
						$json['next'] = '';
					}

					$message  = '<html dir="ltr" lang="en">' . "\n";
					$message .= '  <head>' . "\n";
					$message .= '    <title>' . $this->request->post['subject'] . '</title>' . "\n";
					$message .= '    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">' . "\n";
					$message .= '  </head>' . "\n";
					$message .= '  <body>' . html_entity_decode($this->request->post['message'], ENT_QUOTES, 'UTF-8') . '</body>' . "\n";
					$message .= '</html>' . "\n";

					foreach ($emails as $email) {
						if (preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $email)) {
							$mail = new Mail();
							$mail->protocol = $this->config->get('config_mail_protocol');
							$mail->parameter = $this->config->get('config_mail_parameter');
							$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
							$mail->smtp_username = $this->config->get('config_mail_smtp_username');
							$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
							$mail->smtp_port = $this->config->get('config_mail_smtp_port');
							$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

							$mail->setTo($email);
							$mail->setFrom($this->config->get('config_email'));
							$mail->setSender(html_entity_decode($store_name, ENT_QUOTES, 'UTF-8'));
							$mail->setSubject(html_entity_decode($this->request->post['subject'], ENT_QUOTES, 'UTF-8'));
							$mail->setHtml($message);
							$mail->send();
						}
					}
				}
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}