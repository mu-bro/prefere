<?php
class ControllerPaymentGoPay extends Controller {
	public function index() {
		$this->load->language('payment/gopay');

		$data['text_title'] = $this->language->get('text_title');
		$data['text_info'] = $this->language->get('text_info');

		$data['button_confirm'] = $this->language->get('button_confirm');

		$data['action'] = $this->url->link('payment/gopay/confirm', '', 'SSL');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/gopay.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/payment/gopay.tpl', $data);
		} else {
			return $this->load->view('default/template/payment/gopay.tpl', $data);
		}
	}

	public function confirm() {
		if ($this->config->get('gopay_status') && isset($this->session->data['order_id'])) {
			$this->load->model('checkout/order');

			$order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);

			if ($order_info) {
				$gopay = $this->config->get('gopay');

				require_once(DIR_SYSTEM . 'library/gopay/gopay_config.php');
				require_once(DIR_SYSTEM . 'library/gopay/gopay_helper.php');
				require_once(DIR_SYSTEM . 'library/gopay/gopay_soap.php');
				require_once(DIR_SYSTEM . 'library/gopay/country_code.php');

				$store_id = $order_info['store_id'];

				if (empty($gopay[$store_id]) || !empty($gopay[$store_id]['default']['credential'])) {
					$goid = $gopay['default']['goid'];
					$secret = $gopay['default']['secret'];
					$test = (empty($gopay['default']['test']) ? false : true);
				} else {
					$goid = $gopay[$store_id]['goid'];
					$secret = $gopay[$store_id]['secret'];
					$test = (empty($gopay[$store_id]['test']) ? false : true);
				}

				if (empty($gopay[$store_id]) || !empty($gopay[$store_id]['default']['restriction'])) {
					$display = (empty($gopay['default']['display']) ? false : true);
				} else {
					$display = (empty($gopay[$store_id]['display']) ? false : true);
				}

				GopayConfig::init($test ? GopayConfig::TEST : GopayConfig::PROD);

				$product_query = $this->db->query("SELECT name FROM " . DB_PREFIX . "order_product WHERE order_id = " . (int)$this->session->data['order_id'] . " LIMIT 1");

				if (!$product_query->row) {
					$product_query->row = array(
						'name' => 'Voucher',
					);
				}

				$method_codes = array();
				$default_method = null;

				if ($display) {
					$parts = explode('.', $this->session->data['payment_method']['code']);

					$method = end($parts);

					if ($method != 'gopay') {
						$method_codes = array($method);
						$default_method = $method;
					}
				}

				if (!$method_codes) {
					$methods = GopaySoap::paymentMethodList();

					$method_codes = array();

					foreach ($methods as $method) {
						$method_codes[$method->code] = true;
					}

					if (empty($gopay[$store_id]) || !empty($gopay[$store_id]['default']['method'])) {
						$method_settings = $gopay['default']['method'];
					} else {
						$method_settings = $gopay[$store_id]['method'];
					}

					foreach ($method_settings as $method_code => $method_data) {
						if (!isset($method_codes[$method_code])) continue;

						if (!empty($method_data['disabled']) ||
							(!empty($method_data['min']) && $order_info['total'] < $method_data['min']) ||
							(!empty($method_data['max']) && $order_info['total'] > $method_data['max'])) {

							unset($method_codes[$method_code]);
						}
					}

					$method_codes = array_keys($method_codes);
					$default_method = reset($method_codes);
				}

				$currency = $this->db->query("SELECT decimal_place FROM " . DB_PREFIX . "currency WHERE currency_id = " . (int)$order_info['currency_id']);

				$decimal_place = ($currency->row ? $currency->row['decimal_place'] : 2);

				try {
					$paymentSessionId = GopaySoap::createPayment(
						$goid,
						$product_query->row['name'],
						(int)(number_format(round($order_info['total'] * $order_info['currency_value'], (int)$decimal_place), (int)$decimal_place, '.', '') * 100),
						$order_info['currency_code'],
						$order_info['order_id'],
						HTTPS_SERVER . 'gopay/callback.php',
						HTTPS_SERVER . 'gopay/callback.php',
						$method_codes,
						$default_method,
						$secret,
						$order_info['payment_firstname'],
						$order_info['payment_lastname'],
						$order_info['payment_city'],
						$order_info['payment_address_1'],
						$order_info['payment_postcode'],
						(defined('CountryCode::' . $order_info['payment_iso_code_3']) ? constant('CountryCode::' . $order_info['payment_iso_code_3']) : CountryCode::CZE),
						$order_info['email'],
						$order_info['telephone'],
						null,
						null,
						null,
						null,
						$this->config->get('config_language')
					);
				} catch (Exception $e) {
					$this->load->language('payment/gopay');

					$this->session->data['error'] = $this->language->get('text_error');

					$this->response->redirect($this->url->link('error/gopay', '', 'SSL'));
				}

				if ($this->config->get('gopay_order_confirm')) {
					if (empty($gopay[$store_id]) || !empty($gopay[$store_id]['default']['order_status'])) {
						$order_status_id_confirmed = $gopay['default']['order_status_id'];
					} else {
						$order_status_id_confirmed = $gopay[$store_id]['order_status_id'];
					}

					$this->model_checkout_order->addOrderHistory($order_info['order_id'], $order_status_id_confirmed, '', TRUE);
				}

				$this->db->query("UPDATE `" . DB_PREFIX . "order` SET gopay_id = '" . $this->db->escape($paymentSessionId) . "' WHERE order_id = " . (int)$this->session->data['order_id']);

				$encryptedSignature = GopayHelper::encrypt(
					GopayHelper::hash(
						GopayHelper::concatPaymentSession(
							$goid,
							$paymentSessionId,
							$secret
					)), $secret);			

				$this->response->redirect(GopayConfig::fullIntegrationURL() . '?sessionInfo.targetGoId=' . $goid . '&sessionInfo.paymentSessionId=' . $paymentSessionId . '&sessionInfo.encryptedSignature=' . $encryptedSignature);
			}
		}

		$this->response->redirect($this->url->link('common/home'));
	}

	public function callback() {
		$gopay = $this->config->get('gopay');

		$this->load->language('payment/gopay');

		$data = array();

		if (isset($this->request->get['data'])) {
			$data = unserialize($this->encryption->decrypt($this->request->get['data']));
		}

		if ($this->config->get('gopay_status') && isset($this->request->get['hash']) && isset($data['hash']) && $this->request->get['hash'] == $data['hash']) {
			$this->load->model('checkout/order');

			$order_info = $this->model_checkout_order->getOrder($data['order_id']);

			if (!$order_info) {
				$this->response->redirect($this->url->link('error/gopay', '', 'SSL'));
			}

			if (empty($gopay[$order_info['store_id']]) || !empty($gopay[$order_info['store_id']]['default']['order_status'])) {
				$order_status_id_success = $gopay['default']['order_status_id_success'];
				$order_status_id_failed = $gopay['default']['order_status_id_failed'];
				$order_status_id_confirmed = $gopay['default']['order_status_id'];
			} else {
				$order_status_id_success = $gopay[$order_info['store_id']]['order_status_id_success'];
				$order_status_id_failed = $gopay[$order_info['store_id']]['order_status_id_failed'];
				$order_status_id_confirmed = $gopay[$order_info['store_id']]['order_status_id'];
			}

			if (in_array($data['code'], array(1, 2))) {
				if ($data['code'] == 1 && $order_status_id_success != $order_info['order_status_id']) {
					$this->model_checkout_order->addOrderHistory($data['order_id'], $order_status_id_success, '', TRUE);
				} elseif ($data['code'] == 2 && !$order_info['order_status_id']) {
					$this->model_checkout_order->addOrderHistory($data['order_id'], $order_status_id_confirmed, '', TRUE);
				}

				if ($data['redirect']) {
					$this->response->redirect($this->url->link('checkout/success', '', 'SSL'));
				}
			} else {
				if ($order_info['order_status_id'] && $order_status_id_failed != $order_info['order_status_id']) {
					$this->model_checkout_order->addOrderHistory($data['order_id'], $order_status_id_failed, '', TRUE);
				}

				if ($data['redirect']) {
					$this->response->redirect($this->url->link('error/gopay', '', 'SSL'));
				}
			}
		} else {
			$this->response->redirect($this->url->link('error/gopay', '', 'SSL'));
		}
	}
}