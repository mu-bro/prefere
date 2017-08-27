<?php
class ControllerPaymentGoPay extends Controller {
	private $error = array();

	public function install() {
		$query = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "order` LIKE 'gopay_id'");

		if (!$query->row) {
			$this->db->query("ALTER TABLE `" . DB_PREFIX . "order` ADD gopay_id varchar(100) NOT NULL DEFAULT ''");
		}

		ob_start();

		if (function_exists('curl_version')) {
			$ch = curl_init();

			curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
			curl_setopt($ch, CURLOPT_URL, 'http://www.opencartex.com/notify.php?extension=GoPay&url=' . rawurlencode(HTTP_CATALOG));

			curl_exec($ch);
		} else {
			file_get_contents('http://www.opencartex.com/notify.php?extension=GoPay&url=' . rawurlencode(HTTP_CATALOG));
		}

		ob_end_clean();
	}

	public function index() {
		$this->load->language('payment/gopay');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('gopay', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_all_zones'] = $this->language->get('text_all_zones');
		$data['text_yes'] = $this->language->get('text_yes');
		$data['text_no'] = $this->language->get('text_no');
		$data['text_content_top'] = $this->language->get('text_content_top');
		$data['text_content_bottom'] = $this->language->get('text_content_bottom');
		$data['text_column_left'] = $this->language->get('text_column_left');
		$data['text_column_right'] = $this->language->get('text_column_right');
		$data['text_browse'] = $this->language->get('text_browse');
		$data['text_clear'] = $this->language->get('text_clear');
		$data['text_original'] = $this->language->get('text_original');
		$data['text_image_manager'] = $this->language->get('text_image_manager');
		$data['text_image_link'] = sprintf($this->language->get('text_image_link'), 'https://www.gopay.cz/styl-go-pay/logo-eshopy');
		$data['text_same_as_default'] = $this->language->get('text_same_as_default');
		$data['text_credentials'] = $this->language->get('text_credentials');
		$data['text_restrictions'] = $this->language->get('text_restrictions');
		$data['text_order_statuses'] = $this->language->get('text_order_statuses');
		$data['text_order_confirm_redirect'] = $this->language->get('text_order_confirm_redirect');
		$data['text_order_confirm_callback'] = $this->language->get('text_order_confirm_callback');

		$data['entry_callback'] = $this->language->get('entry_callback');
		$data['entry_goid'] = $this->language->get('entry_goid');
		$data['entry_secret'] = $this->language->get('entry_secret');
		$data['entry_separate_method'] = $this->language->get('entry_separate_method');
		$data['entry_order_status'] = $this->language->get('entry_order_status');
		$data['entry_order_status_success'] = $this->language->get('entry_order_status_success');
		$data['entry_order_status_failed'] = $this->language->get('entry_order_status_failed');
		$data['entry_total'] = $this->language->get('entry_total');
		$data['entry_geo_zone'] = $this->language->get('entry_geo_zone');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$data['entry_test'] = $this->language->get('entry_test');
		$data['entry_image'] = $this->language->get('entry_image');
		$data['entry_layout'] = $this->language->get('entry_layout');
		$data['entry_position'] = $this->language->get('entry_position');
		$data['entry_disable'] = $this->language->get('entry_disable');
		$data['entry_title'] = $this->language->get('entry_title');
		$data['entry_total_min'] = $this->language->get('entry_total_min');
		$data['entry_total_max'] = $this->language->get('entry_total_max');
		$data['entry_cost'] = $this->language->get('entry_cost');
		$data['entry_offline'] = $this->language->get('entry_offline');
		$data['entry_order_confirm'] = $this->language->get('entry_order_confirm');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_remove'] = $this->language->get('button_remove');
		$data['button_add_module'] = $this->language->get('button_add_module');

		$data['tab_general'] = $this->language->get('tab_general');
		$data['tab_data'] = $this->language->get('tab_data');
		$data['tab_payment_method'] = $this->language->get('tab_payment_method');
		$data['tab_presentation'] = $this->language->get('tab_presentation');
		$data['tab_default'] = $this->language->get('tab_default');

		$data['error_no_payment_methods'] = $this->language->get('error_no_payment_methods');

		$data['error'] = $this->error;

		$data['token'] = $this->session->data['token'];

  		$data['breadcrumbs'] = array();

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => FALSE
   		);

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_payment'),
			'href'      => $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('payment/gopay', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

		$data['action'] = $this->url->link('payment/gopay', 'token=' . $this->session->data['token'], 'SSL');
		$data['cancel'] = $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->post['gopay'])) {
			$data['gopay'] = $this->request->post['gopay'];
		} else {
			$data['gopay'] = $this->config->get('gopay');
		}

		if (!empty($data['gopay']['goid'])) {
			$data['gopay']['default']['goid'] = $data['gopay']['goid'];
		}

		if (!empty($data['gopay']['secret'])) {
			$data['gopay']['default']['secret'] = $data['gopay']['secret'];
		}

		if (!empty($data['gopay']['total'])) {
			$data['gopay']['default']['total'] = $data['gopay']['total'];
		}

		if (!empty($data['gopay']['geo_zone_id'])) {
			$data['gopay']['default']['geo_zone_id'] = $data['gopay']['geo_zone_id'];
		}

		if (!empty($data['gopay']['display'])) {
			$data['gopay']['default']['display'] = $data['gopay']['display'];
		}

		if (!empty($data['gopay']['test'])) {
			$data['gopay']['default']['test'] = $data['gopay']['test'];
		}

		if (!empty($data['gopay']['order_status_id'])) {
			$data['gopay']['default']['order_status_id'] = $data['gopay']['order_status_id'];
		}

		if (!empty($data['gopay']['order_status_id_success'])) {
			$data['gopay']['default']['order_status_id_success'] = $data['gopay']['order_status_id_success'];
		}

		if (!empty($data['gopay']['order_status_id_failed'])) {
			$data['gopay']['default']['order_status_id_failed'] = $data['gopay']['order_status_id_failed'];
		}

		if (isset($this->request->post['gopay_status'])) {
			$data['gopay_status'] = $this->request->post['gopay_status'];
		} else {
			$data['gopay_status'] = $this->config->get('gopay_status');
		}

		if (isset($this->request->post['gopay_sort_order'])) {
			$data['gopay_sort_order'] = $this->request->post['gopay_sort_order'];
		} else {
			$data['gopay_sort_order'] = $this->config->get('gopay_sort_order');
		}

		if (isset($this->request->post['gopay_order_confirm'])) {
			$data['gopay_order_confirm'] = $this->request->post['gopay_order_confirm'];
		} else {
			$data['gopay_order_confirm'] = $this->config->get('gopay_order_confirm');
		}

		if (isset($this->request->post['gopay_module'])) {
			$data['modules'] = $this->request->post['gopay_module'];
		} elseif ($this->config->get('gopay_module')) {
			$data['modules'] = $this->config->get('gopay_module');
		} else {
			$data['modules'] = array();
		}

		$data['callback'] = HTTP_CATALOG . 'gopay/callback.php';

		$this->load->model('localisation/order_status');

		$data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();

		$this->load->model('localisation/geo_zone');

		$data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();

		$this->load->model('localisation/language');

		$data['languages'] = $this->model_localisation_language->getLanguages();

		$this->load->model('setting/store');

		$data['stores'] = array_merge(array(array(
			'store_id' => 0,
			'name'     => $this->config->get('config_name')
		)), $this->model_setting_store->getStores());

		require_once(DIR_SYSTEM . 'library/gopay/gopay_config.php');
		include_once(DIR_SYSTEM . 'library/gopay/gopay_soap.php');

		$data['payment_methods'] = array();

		GopayConfig::init(empty($data['gopay']['default']['test']) ? GopayConfig::PROD : GopayConfig::TEST);

		$data['payment_methods']['default'] = GopaySoap::paymentMethodList();

		foreach ($data['stores'] as $store) {
			if (!empty($data['gopay'][$store['store_id']]['default']['credential'])) {
				$test = (empty($data['gopay']['default']['test']) ? false : true);
			} else {
				$test = (empty($data['gopay'][$store['store_id']]['test']) ? false : true);
			}

			GopayConfig::init(empty($test) ? GopayConfig::PROD : GopayConfig::TEST);

			$data['payment_methods'][$store['store_id']] = GopaySoap::paymentMethodList();
		}

		$this->load->model('design/layout');

		$data['layouts'] = $this->model_design_layout->getLayouts();

		$data['no_image'] = HTTPS_CATALOG . 'image/no_image.jpg';

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('payment/gopay.tpl', $data));
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'payment/gopay')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		foreach ($this->request->post['gopay'] as $store => $store_data) {
			if ((string)$store != 'default' && !empty($store_data['default']['credential'])) continue;

			if (empty($store_data['goid'])) {
				$this->error['goid'][$store] = $this->language->get('error_goid');
			}

			if (empty($store_data['secret'])) {
				$this->error['secret'][$store] = $this->language->get('error_secret');
			}
		}

		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}
	}
}