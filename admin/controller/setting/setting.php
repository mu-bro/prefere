<?php
class ControllerSettingSetting extends Controller {
	private $error = array();

	public function index() {

		$this->document->addScript('view/javascript/jquery/datetimepicker/ru.js');

		$this->load->language('setting/setting');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('config', $this->request->post);

			if ($this->config->get('config_currency_auto')) {
				$this->load->model('localisation/currency');

				$this->model_localisation_currency->refresh();
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('setting/store', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$data = array_merge(isset($data) ? $data : array(), $this->load->language('setting/setting'));

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['name'])) {
			$data['error_name'] = $this->error['name'];
		} else {
			$data['error_name'] = '';
		}

		if (isset($this->error['owner'])) {
			$data['error_owner'] = $this->error['owner'];
		} else {
			$data['error_owner'] = '';
		}

		if (isset($this->error['address'])) {
			$data['error_address'] = $this->error['address'];
		} else {
			$data['error_address'] = '';
		}

		if (isset($this->error['email'])) {
			$data['error_email'] = $this->error['email'];
		} else {
			$data['error_email'] = '';
		}

		if (isset($this->error['telephone'])) {
			$data['error_telephone'] = $this->error['telephone'];
		} else {
			$data['error_telephone'] = '';
		}

		if (isset($this->error['meta_title'])) {
			$data['error_meta_title'] = $this->error['meta_title'];
		} else {
			$data['error_meta_title'] = '';
		}

		if (isset($this->error['country'])) {
			$data['error_country'] = $this->error['country'];
		} else {
			$data['error_country'] = '';
		}

		if (isset($this->error['zone'])) {
			$data['error_zone'] = $this->error['zone'];
		} else {
			$data['error_zone'] = '';
		}

		if (isset($this->error['customer_group_display'])) {
			$data['error_customer_group_display'] = $this->error['customer_group_display'];
		} else {
			$data['error_customer_group_display'] = '';
		}

		if (isset($this->error['login_attempts'])) {
			$data['error_login_attempts'] = $this->error['login_attempts'];
		} else {
			$data['error_login_attempts'] = '';
		}

		if (isset($this->error['voucher_min'])) {
			$data['error_voucher_min'] = $this->error['voucher_min'];
		} else {
			$data['error_voucher_min'] = '';
		}

		if (isset($this->error['voucher_max'])) {
			$data['error_voucher_max'] = $this->error['voucher_max'];
		} else {
			$data['error_voucher_max'] = '';
		}

		if (isset($this->error['processing_status'])) {
			$data['error_processing_status'] = $this->error['processing_status'];
		} else {
			$data['error_processing_status'] = '';
		}

		if (isset($this->error['complete_status'])) {
			$data['error_complete_status'] = $this->error['complete_status'];
		} else {
			$data['error_complete_status'] = '';
		}

		if (isset($this->error['ftp_hostname'])) {
			$data['error_ftp_hostname'] = $this->error['ftp_hostname'];
		} else {
			$data['error_ftp_hostname'] = '';
		}

		if (isset($this->error['ftp_port'])) {
			$data['error_ftp_port'] = $this->error['ftp_port'];
		} else {
			$data['error_ftp_port'] = '';
		}

		if (isset($this->error['ftp_username'])) {
			$data['error_ftp_username'] = $this->error['ftp_username'];
		} else {
			$data['error_ftp_username'] = '';
		}

		if (isset($this->error['ftp_password'])) {
			$data['error_ftp_password'] = $this->error['ftp_password'];
		} else {
			$data['error_ftp_password'] = '';
		}

		if (isset($this->error['image_category'])) {
			$data['error_image_category'] = $this->error['image_category'];
		} else {
			$data['error_image_category'] = '';
		}

		if (isset($this->error['image_thumb'])) {
			$data['error_image_thumb'] = $this->error['image_thumb'];
		} else {
			$data['error_image_thumb'] = '';
		}

		if (isset($this->error['image_popup'])) {
			$data['error_image_popup'] = $this->error['image_popup'];
		} else {
			$data['error_image_popup'] = '';
		}

		if (isset($this->error['image_product'])) {
			$data['error_image_product'] = $this->error['image_product'];
		} else {
			$data['error_image_product'] = '';
		}

		if (isset($this->error['image_additional'])) {
			$data['error_image_additional'] = $this->error['image_additional'];
		} else {
			$data['error_image_additional'] = '';
		}

		if (isset($this->error['image_related'])) {
			$data['error_image_related'] = $this->error['image_related'];
		} else {
			$data['error_image_related'] = '';
		}

		if (isset($this->error['image_compare'])) {
			$data['error_image_compare'] = $this->error['image_compare'];
		} else {
			$data['error_image_compare'] = '';
		}

		if (isset($this->error['image_wishlist'])) {
			$data['error_image_wishlist'] = $this->error['image_wishlist'];
		} else {
			$data['error_image_wishlist'] = '';
		}

		if (isset($this->error['image_cart'])) {
			$data['error_image_cart'] = $this->error['image_cart'];
		} else {
			$data['error_image_cart'] = '';
		}

		if (isset($this->error['image_location'])) {
			$data['error_image_location'] = $this->error['image_location'];
		} else {
			$data['error_image_location'] = '';
		}

		if (isset($this->error['error_filename'])) {
			$data['error_error_filename'] = $this->error['error_filename'];
		} else {
			$data['error_error_filename'] = '';
		}

		if (isset($this->error['product_limit'])) {
			$data['error_product_limit'] = $this->error['product_limit'];
		} else {
			$data['error_product_limit'] = '';
		}

		if (isset($this->error['product_description_length'])) {
			$data['error_product_description_length'] = $this->error['product_description_length'];
		} else {
			$data['error_product_description_length'] = '';
		}

		if (isset($this->error['limit_admin'])) {
			$data['error_limit_admin'] = $this->error['limit_admin'];
		} else {
			$data['error_limit_admin'] = '';
		}

		if (isset($this->error['encryption'])) {
			$data['error_encryption'] = $this->error['encryption'];
		} else {
			$data['error_encryption'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_stores'),
			'href' => $this->url->link('setting/store', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('setting/setting', 'token=' . $this->session->data['token'], 'SSL')
		);

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		$data['action'] = $this->url->link('setting/setting', 'token=' . $this->session->data['token'], 'SSL');

		$data['cancel'] = $this->url->link('setting/store', 'token=' . $this->session->data['token'], 'SSL');

		$data['token'] = $this->session->data['token'];

		if (isset($this->request->post['config_name'])) {
			$data['config_name'] = $this->request->post['config_name'];
		} else {
			$data['config_name'] = $this->config->get('config_name');
		}

		if (isset($this->request->post['config_owner'])) {
			$data['config_owner'] = $this->request->post['config_owner'];
		} else {
			$data['config_owner'] = $this->config->get('config_owner');
		}

		if (isset($this->request->post['config_address'])) {
			$data['config_address'] = $this->request->post['config_address'];
		} else {
			$data['config_address'] = $this->config->get('config_address');
		}

		if (isset($this->request->post['config_geocode'])) {
			$data['config_geocode'] = $this->request->post['config_geocode'];
		} else {
			$data['config_geocode'] = $this->config->get('config_geocode');
		}

		if (isset($this->request->post['config_email'])) {
			$data['config_email'] = $this->request->post['config_email'];
		} else {
			$data['config_email'] = $this->config->get('config_email');
		}

		if (isset($this->request->post['config_telephone'])) {
			$data['config_telephone'] = $this->request->post['config_telephone'];
		} else {
			$data['config_telephone'] = $this->config->get('config_telephone');
		}

		if (isset($this->request->post['config_fax'])) {
			$data['config_fax'] = $this->request->post['config_fax'];
		} else {
			$data['config_fax'] = $this->config->get('config_fax');
		}

		if (isset($this->request->post['config_image'])) {
			$data['config_image'] = $this->request->post['config_image'];
		} else {
			$data['config_image'] = $this->config->get('config_image');
		}

		$this->load->model('tool/image');

		if (isset($this->request->post['config_image']) && is_file(DIR_IMAGE . $this->request->post['config_image'])) {
			$data['thumb'] = $this->model_tool_image->resize($this->request->post['config_image'], 100, 100);
		} elseif ($this->config->get('config_image') && is_file(DIR_IMAGE . $this->config->get('config_image'))) {
			$data['thumb'] = $this->model_tool_image->resize($this->config->get('config_image'), 100, 100);
		} else {
			$data['thumb'] = $this->model_tool_image->resize('no_image.png', 100, 100);
		}

		$data['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);

		if (isset($this->request->post['config_open'])) {
			$data['config_open'] = $this->request->post['config_open'];
		} else {
			$data['config_open'] = $this->config->get('config_open');
		}

		if (isset($this->request->post['config_comment'])) {
			$data['config_comment'] = $this->request->post['config_comment'];
		} else {
			$data['config_comment'] = $this->config->get('config_comment');
		}

		$this->load->model('localisation/location');

		$data['locations'] = $this->model_localisation_location->getLocations();

		if (isset($this->request->post['config_location'])) {
			$data['config_location'] = $this->request->post['config_location'];
		} elseif ($this->config->get('config_location')) {
			$data['config_location'] = $this->config->get('config_location');
		} else {
			$data['config_location'] = array();
		}

		if (isset($this->request->post['config_meta_title'])) {
			$data['config_meta_title'] = $this->request->post['config_meta_title'];
		} else {
			$data['config_meta_title'] = $this->config->get('config_meta_title');
		}

		if (isset($this->request->post['config_meta_description'])) {
			$data['config_meta_description'] = $this->request->post['config_meta_description'];
		} else {
			$data['config_meta_description'] = $this->config->get('config_meta_description');
		}

		if (isset($this->request->post['config_meta_keyword'])) {
			$data['config_meta_keyword'] = $this->request->post['config_meta_keyword'];
		} else {
			$data['config_meta_keyword'] = $this->config->get('config_meta_keyword');
		}

		if (isset($this->request->post['config_layout_id'])) {
			$data['config_layout_id'] = $this->request->post['config_layout_id'];
		} else {
			$data['config_layout_id'] = $this->config->get('config_layout_id');
		}

		$this->load->model('design/layout');

		$data['layouts'] = $this->model_design_layout->getLayouts();

		if (isset($this->request->post['config_template'])) {
			$data['config_template'] = $this->request->post['config_template'];
		} else {
			$data['config_template'] = $this->config->get('config_template');
		}

		$data['templates'] = array();

		$directories = glob(DIR_CATALOG . 'view/theme/*', GLOB_ONLYDIR);

		foreach ($directories as $directory) {
			$data['templates'][] = basename($directory);
		}

		if (isset($this->request->post['config_country_id'])) {
			$data['config_country_id'] = $this->request->post['config_country_id'];
		} else {
			$data['config_country_id'] = $this->config->get('config_country_id');
		}

		$this->load->model('localisation/country');

		$data['countries'] = $this->model_localisation_country->getCountries();

		if (isset($this->request->post['config_zone_id'])) {
			$data['config_zone_id'] = $this->request->post['config_zone_id'];
		} else {
			$data['config_zone_id'] = $this->config->get('config_zone_id');
		}

		if (isset($this->request->post['config_language'])) {
			$data['config_language'] = $this->request->post['config_language'];
		} else {
			$data['config_language'] = $this->config->get('config_language');
		}

		$this->load->model('localisation/language');

		$data['languages'] = $this->model_localisation_language->getLanguages();

		if (isset($this->request->post['config_admin_language'])) {
			$data['config_admin_language'] = $this->request->post['config_admin_language'];
		} else {
			$data['config_admin_language'] = $this->config->get('config_admin_language');
		}

		if (isset($this->request->post['config_currency'])) {
			$data['config_currency'] = $this->request->post['config_currency'];
		} else {
			$data['config_currency'] = $this->config->get('config_currency');
		}

		if (isset($this->request->post['config_currency_auto'])) {
			$data['config_currency_auto'] = $this->request->post['config_currency_auto'];
		} else {
			$data['config_currency_auto'] = $this->config->get('config_currency_auto');
		}

		$this->load->model('localisation/currency');

		$data['currencies'] = $this->model_localisation_currency->getCurrencies();

		if (isset($this->request->post['config_length_class_id'])) {
			$data['config_length_class_id'] = $this->request->post['config_length_class_id'];
		} else {
			$data['config_length_class_id'] = $this->config->get('config_length_class_id');
		}

		$this->load->model('localisation/length_class');

		$data['length_classes'] = $this->model_localisation_length_class->getLengthClasses();

		if (isset($this->request->post['config_weight_class_id'])) {
			$data['config_weight_class_id'] = $this->request->post['config_weight_class_id'];
		} else {
			$data['config_weight_class_id'] = $this->config->get('config_weight_class_id');
		}

		$this->load->model('localisation/weight_class');

		$data['weight_classes'] = $this->model_localisation_weight_class->getWeightClasses();

		if (isset($this->request->post['config_product_limit'])) {
			$data['config_product_limit'] = $this->request->post['config_product_limit'];
		} else {
			$data['config_product_limit'] = $this->config->get('config_product_limit');
		}

		if (isset($this->request->post['config_product_description_length'])) {
			$data['config_product_description_length'] = $this->request->post['config_product_description_length'];
		} else {
			$data['config_product_description_length'] = $this->config->get('config_product_description_length');
		}

		if (isset($this->request->post['config_limit_admin'])) {
			$data['config_limit_admin'] = $this->request->post['config_limit_admin'];
		} else {
			$data['config_limit_admin'] = $this->config->get('config_limit_admin');
		}

		if (isset($this->request->post['config_product_count'])) {
			$data['config_product_count'] = $this->request->post['config_product_count'];
		} else {
			$data['config_product_count'] = $this->config->get('config_product_count');
		}

		if (isset($this->request->post['config_review_status'])) {
			$data['config_review_status'] = $this->request->post['config_review_status'];
		} else {
			$data['config_review_status'] = $this->config->get('config_review_status');
		}

		if (isset($this->request->post['config_review_guest'])) {
			$data['config_review_guest'] = $this->request->post['config_review_guest'];
		} else {
			$data['config_review_guest'] = $this->config->get('config_review_guest');
		}

		if (isset($this->request->post['config_review_mail'])) {
			$data['config_review_mail'] = $this->request->post['config_review_mail'];
		} else {
			$data['config_review_mail'] = $this->config->get('config_review_mail');
		}

		if (isset($this->request->post['config_voucher_min'])) {
			$data['config_voucher_min'] = $this->request->post['config_voucher_min'];
		} else {
			$data['config_voucher_min'] = $this->config->get('config_voucher_min');
		}

		if (isset($this->request->post['config_voucher_max'])) {
			$data['config_voucher_max'] = $this->request->post['config_voucher_max'];
		} else {
			$data['config_voucher_max'] = $this->config->get('config_voucher_max');
		}

		if (isset($this->request->post['config_tax'])) {
			$data['config_tax'] = $this->request->post['config_tax'];
		} else {
			$data['config_tax'] = $this->config->get('config_tax');
		}

		if (isset($this->request->post['config_tax_default'])) {
			$data['config_tax_default'] = $this->request->post['config_tax_default'];
		} else {
			$data['config_tax_default'] = $this->config->get('config_tax_default');
		}

		if (isset($this->request->post['config_tax_customer'])) {
			$data['config_tax_customer'] = $this->request->post['config_tax_customer'];
		} else {
			$data['config_tax_customer'] = $this->config->get('config_tax_customer');
		}

		if (isset($this->request->post['config_customer_online'])) {
			$data['config_customer_online'] = $this->request->post['config_customer_online'];
		} else {
			$data['config_customer_online'] = $this->config->get('config_customer_online');
		}

		if (isset($this->request->post['config_customer_group_id'])) {
			$data['config_customer_group_id'] = $this->request->post['config_customer_group_id'];
		} else {
			$data['config_customer_group_id'] = $this->config->get('config_customer_group_id');
		}

		$this->load->model('customer/customer_group');

		$data['customer_groups'] = $this->model_customer_customer_group->getCustomerGroups();

		if (isset($this->request->post['config_customer_group_display'])) {
			$data['config_customer_group_display'] = $this->request->post['config_customer_group_display'];
		} elseif ($this->config->get('config_customer_group_display')) {
			$data['config_customer_group_display'] = $this->config->get('config_customer_group_display');
		} else {
			$data['config_customer_group_display'] = array();
		}

		if (isset($this->request->post['config_customer_price'])) {
			$data['config_customer_price'] = $this->request->post['config_customer_price'];
		} else {
			$data['config_customer_price'] = $this->config->get('config_customer_price');
		}

		if (isset($this->request->post['config_login_attempts'])) {
			$data['config_login_attempts'] = $this->request->post['config_login_attempts'];
		} elseif ($this->config->has('config_login_attempts')) {
			$data['config_login_attempts'] = $this->config->get('config_login_attempts');
		} else {
			$data['config_login_attempts'] = 5;
		}

		if (isset($this->request->post['config_account_id'])) {
			$data['config_account_id'] = $this->request->post['config_account_id'];
		} else {
			$data['config_account_id'] = $this->config->get('config_account_id');
		}

		$this->load->model('catalog/information');

		$data['informations'] = $this->model_catalog_information->getInformations();

		if (isset($this->request->post['config_account_mail'])) {
			$data['config_account_mail'] = $this->request->post['config_account_mail'];
		} else {
			$data['config_account_mail'] = $this->config->get('config_account_mail');
		}

		if (isset($this->request->post['config_cart_weight'])) {
			$data['config_cart_weight'] = $this->request->post['config_cart_weight'];
		} else {
			$data['config_cart_weight'] = $this->config->get('config_cart_weight');
		}

		if (isset($this->request->post['config_checkout_guest'])) {
			$data['config_checkout_guest'] = $this->request->post['config_checkout_guest'];
		} else {
			$data['config_checkout_guest'] = $this->config->get('config_checkout_guest');
		}

		if (isset($this->request->post['config_checkout_id'])) {
			$data['config_checkout_id'] = $this->request->post['config_checkout_id'];
		} else {
			$data['config_checkout_id'] = $this->config->get('config_checkout_id');
		}

		if (isset($this->request->post['config_invoice_prefix'])) {
			$data['config_invoice_prefix'] = $this->request->post['config_invoice_prefix'];
		} elseif ($this->config->get('config_invoice_prefix')) {
			$data['config_invoice_prefix'] = $this->config->get('config_invoice_prefix');
		} else {
			$data['config_invoice_prefix'] = 'INV-' . date('Y') . '-00';
		}

		if (isset($this->request->post['config_order_status_id'])) {
			$data['config_order_status_id'] = $this->request->post['config_order_status_id'];
		} else {
			$data['config_order_status_id'] = $this->config->get('config_order_status_id');
		}

		if (isset($this->request->post['config_processing_status'])) {
			$data['config_processing_status'] = $this->request->post['config_processing_status'];
		} elseif ($this->config->get('config_processing_status')) {
			$data['config_processing_status'] = $this->config->get('config_processing_status');
		} else {
			$data['config_processing_status'] = array();
		}

		if (isset($this->request->post['config_complete_status'])) {
			$data['config_complete_status'] = $this->request->post['config_complete_status'];
		} elseif ($this->config->get('config_complete_status')) {
			$data['config_complete_status'] = $this->config->get('config_complete_status');
		} else {
			$data['config_complete_status'] = array();
		}

		if (isset($this->request->post['config_order_status_id'])) {
			$data['config_fraud_status_id'] = $this->request->post['config_fraud_status_id'];
		} else {
			$data['config_fraud_status_id'] = $this->config->get('config_fraud_status_id');
		}

		$this->load->model('localisation/order_status');

		$data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();

		if (isset($this->request->post['config_order_mail'])) {
			$data['config_order_mail'] = $this->request->post['config_order_mail'];
		} else {
			$data['config_order_mail'] = $this->config->get('config_order_mail');
		}

		if (isset($this->request->post['config_api_id'])) {
			$data['config_api_id'] = $this->request->post['config_api_id'];
		} else {
			$data['config_api_id'] = $this->config->get('config_api_id');
		}

		$this->load->model('user/api');

		$data['apis'] = $this->model_user_api->getApis();

		if (isset($this->request->post['config_stock_display'])) {
			$data['config_stock_display'] = $this->request->post['config_stock_display'];
		} else {
			$data['config_stock_display'] = $this->config->get('config_stock_display');
		}

		if (isset($this->request->post['config_stock_warning'])) {
			$data['config_stock_warning'] = $this->request->post['config_stock_warning'];
		} else {
			$data['config_stock_warning'] = $this->config->get('config_stock_warning');
		}

		if (isset($this->request->post['config_stock_checkout'])) {
			$data['config_stock_checkout'] = $this->request->post['config_stock_checkout'];
		} else {
			$data['config_stock_checkout'] = $this->config->get('config_stock_checkout');
		}

		if (isset($this->request->post['config_affiliate_auto'])) {
			$data['config_affiliate_approval'] = $this->request->post['config_affiliate_approval'];
		} elseif ($this->config->has('config_affiliate_commission')) {
			$data['config_affiliate_approval'] = $this->config->get('config_affiliate_approval');
		} else {
			$data['config_affiliate_approval'] = '';
		}

		if (isset($this->request->post['config_affiliate_auto'])) {
			$data['config_affiliate_auto'] = $this->request->post['config_affiliate_auto'];
		} elseif ($this->config->has('config_affiliate_auto')) {
			$data['config_affiliate_auto'] = $this->config->get('config_affiliate_auto');
		} else {
			$data['config_affiliate_auto'] = '';
		}

		if (isset($this->request->post['config_affiliate_commission'])) {
			$data['config_affiliate_commission'] = $this->request->post['config_affiliate_commission'];
		} elseif ($this->config->has('config_affiliate_commission')) {
			$data['config_affiliate_commission'] = $this->config->get('config_affiliate_commission');
		} else {
			$data['config_affiliate_commission'] = '5.00';
		}

		if (isset($this->request->post['config_affiliate_mail'])) {
			$data['config_affiliate_mail'] = $this->request->post['config_affiliate_mail'];
		} elseif ($this->config->has('config_affiliate_mail')) {
			$data['config_affiliate_mail'] = $this->config->get('config_affiliate_mail');
		} else {
			$data['config_affiliate_mail'] = '';
		}

		if (isset($this->request->post['config_affiliate_id'])) {
			$data['config_affiliate_id'] = $this->request->post['config_affiliate_id'];
		} else {
			$data['config_affiliate_id'] = $this->config->get('config_affiliate_id');
		}

		if (isset($this->request->post['config_return_id'])) {
			$data['config_return_id'] = $this->request->post['config_return_id'];
		} else {
			$data['config_return_id'] = $this->config->get('config_return_id');
		}

		if (isset($this->request->post['config_return_status_id'])) {
			$data['config_return_status_id'] = $this->request->post['config_return_status_id'];
		} else {
			$data['config_return_status_id'] = $this->config->get('config_return_status_id');
		}

		$this->load->model('localisation/return_status');

		$data['return_statuses'] = $this->model_localisation_return_status->getReturnStatuses();

		if (isset($this->request->post['config_captcha'])) {
			$data['config_captcha'] = $this->request->post['config_captcha'];
		} else {
			$data['config_captcha'] = $this->config->get('config_captcha');
		}

		$config_fields = array(
			"config_telephone_mask" => "+7 (xxx) xxx xxxx",
			"config_deliver_frames" => "9.00-12.00, 12.00-15.00, 15.00-19.00",
			"config_not_deliver_dates" => "",
			"config_latest_time_order" => "15:00",
			"config_latest_outofcity_time_order" => "12:00",
			"config_soc_vk" => "",
			"config_soc_fb" => "",
			"config_soc_pi" => "",
			"config_soc_in" => "",
			"config_store_list" => '',
			"config_store_metrics" => '',
			"config_telephone_2" => '',
			"config_smartsupp_key" => '',
		  	"config_smartsupp_enabled" => '',
		  	"config_preorder_days" => 2



		);

		foreach ($config_fields as $k => $v) {
			if (isset($this->request->post[$k])) {
				$data[$k] = $this->request->post[$k];
			} else {
				$data[$k] = ($this->config->get($k)) ? $this->config->get($k) : $v;
			}
		}

		if (isset($data['config_day_product_id']) && !empty($data['config_day_product_id'])) {
			$this->load->model('catalog/product');
			$product_info = $this->model_catalog_product->getProduct($data['config_day_product_id']);
			$data['day_product_name'] = $product_info['name'] . " (" . $this->currency->format($product_info['price']) . ")";
		} else {
			$data['day_product_name'] = '';
		}

		if (isset($data['config_charity_product_id']) && !empty($data['config_charity_product_id'])) {
			$this->load->model('catalog/product');
			$product_info = $this->model_catalog_product->getProduct($data['config_charity_product_id']);
			$data['charity_product_name'] = $product_info['name'] . " (" . $this->currency->format($product_info['price']) . ")";
		} else {
			$data['charity_product_name'] = '';
		}


		$data['exclDates'] = explode(',', str_replace(' ', '', $data['config_not_deliver_dates']));
		usort($data['exclDates'],"dateCompare");
		$data['config_not_deliver_dates'] = '';
		foreach ($data['exclDates'] as $date) {
			if (empty($date)) continue;
			if (!empty($data['config_not_deliver_dates'])) {
				$data['config_not_deliver_dates'] .= ", ";
			}
			$data['config_not_deliver_dates'] .= $date;
		}


		$data['storeList'] = json_decode(htmlspecialchars_decode($data['config_store_list']), true);
		foreach($data['storeList'] as $k => $v) {
			if (empty($v)) {
				unset($data['storeList'][$k]);
			}
		}
		$data['config_store_list'] = str_replace('null,', '', $data['config_store_list']);

		$this->load->model('extension/extension');

		$data['captchas'] = array();

		// Get a list of installed captchas
		$extensions = $this->model_extension_extension->getInstalled('captcha');

		foreach ($extensions as $code) {
			$this->load->language('captcha/' . $code);

			if ($this->config->has($code . '_status')) {
				$data['captchas'][] = array(
					'text'  => $this->language->get('heading_title'),
					'value' => $code
				);
			}
		}

		if (isset($this->request->post['config_captcha_page'])) {
			$data['config_captcha_page'] = $this->request->post['config_captcha_page'];
		} elseif ($this->config->has('config_captcha_page')) {
		   	$data['config_captcha_page'] = $this->config->get('config_captcha_page');
		} else {
			$data['config_captcha_page'] = array();
		}

		$data['captcha_pages'] = array();

		$data['captcha_pages'][] = array(
			'text'  => $this->language->get('text_register'),
			'value' => 'register'
		);

		$data['captcha_pages'][] = array(
			'text'  => $this->language->get('text_review'),
			'value' => 'review'
		);

		$data['captcha_pages'][] = array(
			'text'  => $this->language->get('text_return'),
			'value' => 'return'
		);

		$data['captcha_pages'][] = array(
			'text'  => $this->language->get('text_contact'),
			'value' => 'contact'
		);

		if (isset($this->request->post['config_logo'])) {
			$data['config_logo'] = $this->request->post['config_logo'];
		} else {
			$data['config_logo'] = $this->config->get('config_logo');
		}

		if (isset($this->request->post['config_logo']) && is_file(DIR_IMAGE . $this->request->post['config_logo'])) {
			$data['logo'] = $this->model_tool_image->resize($this->request->post['config_logo'], 100, 100);
		} elseif ($this->config->get('config_logo') && is_file(DIR_IMAGE . $this->config->get('config_logo'))) {
			$data['logo'] = $this->model_tool_image->resize($this->config->get('config_logo'), 100, 100);
		} else {
			$data['logo'] = $this->model_tool_image->resize('no_image.png', 100, 100);
		}

		if (isset($this->request->post['config_icon'])) {
			$data['config_icon'] = $this->request->post['config_icon'];
		} else {
			$data['config_icon'] = $this->config->get('config_icon');
		}

		if (isset($this->request->post['config_icon']) && is_file(DIR_IMAGE . $this->request->post['config_icon'])) {
			$data['icon'] = $this->model_tool_image->resize($this->request->post['config_logo'], 100, 100);
		} elseif ($this->config->get('config_icon') && is_file(DIR_IMAGE . $this->config->get('config_icon'))) {
			$data['icon'] = $this->model_tool_image->resize($this->config->get('config_icon'), 100, 100);
		} else {
			$data['icon'] = $this->model_tool_image->resize('no_image.png', 100, 100);
		}

		if (isset($this->request->post['config_image_category_width'])) {
			$data['config_image_category_width'] = $this->request->post['config_image_category_width'];
		} else {
			$data['config_image_category_width'] = $this->config->get('config_image_category_width');
		}

		if (isset($this->request->post['config_image_category_height'])) {
			$data['config_image_category_height'] = $this->request->post['config_image_category_height'];
		} else {
			$data['config_image_category_height'] = $this->config->get('config_image_category_height');
		}

		if (isset($this->request->post['config_image_thumb_width'])) {
			$data['config_image_thumb_width'] = $this->request->post['config_image_thumb_width'];
		} else {
			$data['config_image_thumb_width'] = $this->config->get('config_image_thumb_width');
		}

		if (isset($this->request->post['config_image_thumb_height'])) {
			$data['config_image_thumb_height'] = $this->request->post['config_image_thumb_height'];
		} else {
			$data['config_image_thumb_height'] = $this->config->get('config_image_thumb_height');
		}

		if (isset($this->request->post['config_image_popup_width'])) {
			$data['config_image_popup_width'] = $this->request->post['config_image_popup_width'];
		} else {
			$data['config_image_popup_width'] = $this->config->get('config_image_popup_width');
		}

		if (isset($this->request->post['config_image_popup_height'])) {
			$data['config_image_popup_height'] = $this->request->post['config_image_popup_height'];
		} else {
			$data['config_image_popup_height'] = $this->config->get('config_image_popup_height');
		}

		if (isset($this->request->post['config_image_product_width'])) {
			$data['config_image_product_width'] = $this->request->post['config_image_product_width'];
		} else {
			$data['config_image_product_width'] = $this->config->get('config_image_product_width');
		}

		if (isset($this->request->post['config_image_product_height'])) {
			$data['config_image_product_height'] = $this->request->post['config_image_product_height'];
		} else {
			$data['config_image_product_height'] = $this->config->get('config_image_product_height');
		}

		if (isset($this->request->post['config_image_additional_width'])) {
			$data['config_image_additional_width'] = $this->request->post['config_image_additional_width'];
		} else {
			$data['config_image_additional_width'] = $this->config->get('config_image_additional_width');
		}

		if (isset($this->request->post['config_image_additional_height'])) {
			$data['config_image_additional_height'] = $this->request->post['config_image_additional_height'];
		} else {
			$data['config_image_additional_height'] = $this->config->get('config_image_additional_height');
		}

		if (isset($this->request->post['config_image_related_width'])) {
			$data['config_image_related_width'] = $this->request->post['config_image_related_width'];
		} else {
			$data['config_image_related_width'] = $this->config->get('config_image_related_width');
		}

		if (isset($this->request->post['config_image_related_height'])) {
			$data['config_image_related_height'] = $this->request->post['config_image_related_height'];
		} else {
			$data['config_image_related_height'] = $this->config->get('config_image_related_height');
		}

		if (isset($this->request->post['config_image_compare_width'])) {
			$data['config_image_compare_width'] = $this->request->post['config_image_compare_width'];
		} else {
			$data['config_image_compare_width'] = $this->config->get('config_image_compare_width');
		}

		if (isset($this->request->post['config_image_compare_height'])) {
			$data['config_image_compare_height'] = $this->request->post['config_image_compare_height'];
		} else {
			$data['config_image_compare_height'] = $this->config->get('config_image_compare_height');
		}

		if (isset($this->request->post['config_image_wishlist_width'])) {
			$data['config_image_wishlist_width'] = $this->request->post['config_image_wishlist_width'];
		} else {
			$data['config_image_wishlist_width'] = $this->config->get('config_image_wishlist_width');
		}

		if (isset($this->request->post['config_image_wishlist_height'])) {
			$data['config_image_wishlist_height'] = $this->request->post['config_image_wishlist_height'];
		} else {
			$data['config_image_wishlist_height'] = $this->config->get('config_image_wishlist_height');
		}

		if (isset($this->request->post['config_image_cart_width'])) {
			$data['config_image_cart_width'] = $this->request->post['config_image_cart_width'];
		} else {
			$data['config_image_cart_width'] = $this->config->get('config_image_cart_width');
		}

		if (isset($this->request->post['config_image_cart_height'])) {
			$data['config_image_cart_height'] = $this->request->post['config_image_cart_height'];
		} else {
			$data['config_image_cart_height'] = $this->config->get('config_image_cart_height');
		}

		if (isset($this->request->post['config_image_location_width'])) {
			$data['config_image_location_width'] = $this->request->post['config_image_location_width'];
		} else {
			$data['config_image_location_width'] = $this->config->get('config_image_location_width');
		}

		if (isset($this->request->post['config_image_location_height'])) {
			$data['config_image_location_height'] = $this->request->post['config_image_location_height'];
		} else {
			$data['config_image_location_height'] = $this->config->get('config_image_location_height');
		}

		if (isset($this->request->post['config_ftp_hostname'])) {
			$data['config_ftp_hostname'] = $this->request->post['config_ftp_hostname'];
		} elseif ($this->config->get('config_ftp_hostname')) {
			$data['config_ftp_hostname'] = $this->config->get('config_ftp_hostname');
		} else {
			$data['config_ftp_hostname'] = str_replace('www.', '', $this->request->server['HTTP_HOST']);
		}

		if (isset($this->request->post['config_ftp_port'])) {
			$data['config_ftp_port'] = $this->request->post['config_ftp_port'];
		} elseif ($this->config->get('config_ftp_port')) {
			$data['config_ftp_port'] = $this->config->get('config_ftp_port');
		} else {
			$data['config_ftp_port'] = 21;
		}

		if (isset($this->request->post['config_ftp_username'])) {
			$data['config_ftp_username'] = $this->request->post['config_ftp_username'];
		} else {
			$data['config_ftp_username'] = $this->config->get('config_ftp_username');
		}

		if (isset($this->request->post['config_ftp_password'])) {
			$data['config_ftp_password'] = $this->request->post['config_ftp_password'];
		} else {
			$data['config_ftp_password'] = $this->config->get('config_ftp_password');
		}

		if (isset($this->request->post['config_ftp_root'])) {
			$data['config_ftp_root'] = $this->request->post['config_ftp_root'];
		} else {
			$data['config_ftp_root'] = $this->config->get('config_ftp_root');
		}

		if (isset($this->request->post['config_ftp_status'])) {
			$data['config_ftp_status'] = $this->request->post['config_ftp_status'];
		} else {
			$data['config_ftp_status'] = $this->config->get('config_ftp_status');
		}

		if (isset($this->request->post['config_mail_protocol'])) {
			$data['config_mail_protocol'] = $this->request->post['config_mail_protocol'];
		} else {
			$data['config_mail_protocol'] = $this->config->get('config_mail_protocol');
		}

		if (isset($this->request->post['config_mail_parameter'])) {
			$data['config_mail_parameter'] = $this->request->post['config_mail_parameter'];
		} else {
			$data['config_mail_parameter'] = $this->config->get('config_mail_parameter');
		}

		if (isset($this->request->post['config_mail_smtp_hostname'])) {
			$data['config_mail_smtp_hostname'] = $this->request->post['config_mail_smtp_hostname'];
		} else {
			$data['config_mail_smtp_hostname'] = $this->config->get('config_mail_smtp_hostname');
		}

		if (isset($this->request->post['config_mail_smtp_username'])) {
			$data['config_mail_smtp_username'] = $this->request->post['config_mail_smtp_username'];
		} else {
			$data['config_mail_smtp_username'] = $this->config->get('config_mail_smtp_username');
		}

		if (isset($this->request->post['config_mail_smtp_password'])) {
			$data['config_mail_smtp_password'] = $this->request->post['config_mail_smtp_password'];
		} else {
			$data['config_mail_smtp_password'] = $this->config->get('config_mail_smtp_password');
		}

		if (isset($this->request->post['config_mail_smtp_port'])) {
			$data['config_mail_smtp_port'] = $this->request->post['config_mail_smtp_port'];
		} elseif ($this->config->has('config_mail_smtp_port')) {
			$data['config_mail_smtp_port'] = $this->config->get('config_mail_smtp_port');
		} else {
			$data['config_mail_smtp_port'] = 25;
		}

		if (isset($this->request->post['config_mail_smtp_timeout'])) {
			$data['config_mail_smtp_timeout'] = $this->request->post['config_mail_smtp_timeout'];
		} elseif ($this->config->has('config_mail_smtp_timeout')) {
			$data['config_mail_smtp_timeout'] = $this->config->get('config_mail_smtp_timeout');
		} else {
			$data['config_mail_smtp_timeout'] = 5;
		}

		if (isset($this->request->post['config_mail_alert'])) {
			$data['config_mail_alert'] = $this->request->post['config_mail_alert'];
		} else {
			$data['config_mail_alert'] = $this->config->get('config_mail_alert');
		}

		if (isset($this->request->post['config_secure'])) {
			$data['config_secure'] = $this->request->post['config_secure'];
		} else {
			$data['config_secure'] = $this->config->get('config_secure');
		}

		if (isset($this->request->post['config_shared'])) {
			$data['config_shared'] = $this->request->post['config_shared'];
		} else {
			$data['config_shared'] = $this->config->get('config_shared');
		}

		if (isset($this->request->post['config_robots'])) {
			$data['config_robots'] = $this->request->post['config_robots'];
		} else {
			$data['config_robots'] = $this->config->get('config_robots');
		}

		if (isset($this->request->post['config_seo_url'])) {
			$data['config_seo_url'] = $this->request->post['config_seo_url'];
		} else {
			$data['config_seo_url'] = $this->config->get('config_seo_url');
		}

		if (isset($this->request->post['config_file_max_size'])) {
			$data['config_file_max_size'] = $this->request->post['config_file_max_size'];
		} elseif ($this->config->get('config_file_max_size')) {
			$data['config_file_max_size'] = $this->config->get('config_file_max_size');
		} else {
			$data['config_file_max_size'] = 300000;
		}

		if (isset($this->request->post['config_file_ext_allowed'])) {
			$data['config_file_ext_allowed'] = $this->request->post['config_file_ext_allowed'];
		} else {
			$data['config_file_ext_allowed'] = $this->config->get('config_file_ext_allowed');
		}

		if (isset($this->request->post['config_file_mime_allowed'])) {
			$data['config_file_mime_allowed'] = $this->request->post['config_file_mime_allowed'];
		} else {
			$data['config_file_mime_allowed'] = $this->config->get('config_file_mime_allowed');
		}

		if (isset($this->request->post['config_maintenance'])) {
			$data['config_maintenance'] = $this->request->post['config_maintenance'];
		} else {
			$data['config_maintenance'] = $this->config->get('config_maintenance');
		}

		if (isset($this->request->post['config_password'])) {
			$data['config_password'] = $this->request->post['config_password'];
		} else {
			$data['config_password'] = $this->config->get('config_password');
		}

		if (isset($this->request->post['config_encryption'])) {
			$data['config_encryption'] = $this->request->post['config_encryption'];
		} else {
			$data['config_encryption'] = $this->config->get('config_encryption');
		}

		if (isset($this->request->post['config_compression'])) {
			$data['config_compression'] = $this->request->post['config_compression'];
		} else {
			$data['config_compression'] = $this->config->get('config_compression');
		}

		if (isset($this->request->post['config_error_display'])) {
			$data['config_error_display'] = $this->request->post['config_error_display'];
		} else {
			$data['config_error_display'] = $this->config->get('config_error_display');
		}

		if (isset($this->request->post['config_error_log'])) {
			$data['config_error_log'] = $this->request->post['config_error_log'];
		} else {
			$data['config_error_log'] = $this->config->get('config_error_log');
		}

		if (isset($this->request->post['config_error_filename'])) {
			$data['config_error_filename'] = $this->request->post['config_error_filename'];
		} else {
			$data['config_error_filename'] = $this->config->get('config_error_filename');
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('setting/setting.tpl', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'setting/setting')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->request->post['config_name']) {
			$this->error['name'] = $this->language->get('error_name');
		}

		if ((utf8_strlen($this->request->post['config_owner']) < 3) || (utf8_strlen($this->request->post['config_owner']) > 64)) {
			$this->error['owner'] = $this->language->get('error_owner');
		}

		if ((utf8_strlen($this->request->post['config_address']) < 3) || (utf8_strlen($this->request->post['config_address']) > 256)) {
			$this->error['address'] = $this->language->get('error_address');
		}

		if ((utf8_strlen($this->request->post['config_email']) > 96) || !preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $this->request->post['config_email'])) {
			$this->error['email'] = $this->language->get('error_email');
		}

		if ((utf8_strlen($this->request->post['config_telephone']) < 3) || (utf8_strlen($this->request->post['config_telephone']) > 32)) {
			$this->error['telephone'] = $this->language->get('error_telephone');
		}

		if (!$this->request->post['config_meta_title']) {
			$this->error['meta_title'] = $this->language->get('error_meta_title');
		}

		if (!empty($this->request->post['config_customer_group_display']) && !in_array($this->request->post['config_customer_group_id'], $this->request->post['config_customer_group_display'])) {
			$this->error['customer_group_display'] = $this->language->get('error_customer_group_display');
		}

		if ($this->request->post['config_login_attempts'] < 1) {
			$this->error['login_attempts'] = $this->language->get('error_login_attempts');
		}

		if (!$this->request->post['config_voucher_min']) {
			$this->error['voucher_min'] = $this->language->get('error_voucher_min');
		}

		if (!$this->request->post['config_voucher_max']) {
			$this->error['voucher_max'] = $this->language->get('error_voucher_max');
		}

		if (!isset($this->request->post['config_processing_status'])) {
			$this->error['processing_status'] = $this->language->get('error_processing_status');
		}

		if (!isset($this->request->post['config_complete_status'])) {
			$this->error['complete_status'] = $this->language->get('error_complete_status');
		}

		if (!$this->request->post['config_image_category_width'] || !$this->request->post['config_image_category_height']) {
			$this->error['image_category'] = $this->language->get('error_image_category');
		}

		if (!$this->request->post['config_image_thumb_width'] || !$this->request->post['config_image_thumb_height']) {
			$this->error['image_thumb'] = $this->language->get('error_image_thumb');
		}

		if (!$this->request->post['config_image_popup_width'] || !$this->request->post['config_image_popup_height']) {
			$this->error['image_popup'] = $this->language->get('error_image_popup');
		}

		if (!$this->request->post['config_image_product_width'] || !$this->request->post['config_image_product_height']) {
			$this->error['image_product'] = $this->language->get('error_image_product');
		}

		if (!$this->request->post['config_image_additional_width'] || !$this->request->post['config_image_additional_height']) {
			$this->error['image_additional'] = $this->language->get('error_image_additional');
		}

		if (!$this->request->post['config_image_related_width'] || !$this->request->post['config_image_related_height']) {
			$this->error['image_related'] = $this->language->get('error_image_related');
		}

		if (!$this->request->post['config_image_compare_width'] || !$this->request->post['config_image_compare_height']) {
			$this->error['image_compare'] = $this->language->get('error_image_compare');
		}

		if (!$this->request->post['config_image_wishlist_width'] || !$this->request->post['config_image_wishlist_height']) {
			$this->error['image_wishlist'] = $this->language->get('error_image_wishlist');
		}

		if (!$this->request->post['config_image_cart_width'] || !$this->request->post['config_image_cart_height']) {
			$this->error['image_cart'] = $this->language->get('error_image_cart');
		}

		if (!$this->request->post['config_image_location_width'] || !$this->request->post['config_image_location_height']) {
			$this->error['image_location'] = $this->language->get('error_image_location');
		}

		if ($this->request->post['config_ftp_status']) {
			if (!$this->request->post['config_ftp_hostname']) {
				$this->error['ftp_hostname'] = $this->language->get('error_ftp_hostname');
			}

			if (!$this->request->post['config_ftp_port']) {
				$this->error['ftp_port'] = $this->language->get('error_ftp_port');
			}

			if (!$this->request->post['config_ftp_username']) {
				$this->error['ftp_username'] = $this->language->get('error_ftp_username');
			}

			if (!$this->request->post['config_ftp_password']) {
				$this->error['ftp_password'] = $this->language->get('error_ftp_password');
			}
		}

		if (!$this->request->post['config_error_filename']) {
			$this->error['error_filename'] = $this->language->get('error_error_filename');
		} else {
			if (preg_match('/\.\.[\/\\\]?/', $this->request->post['config_error_filename'])) {
				$this->error['error_filename'] = $this->language->get('error_malformed_filename');
			}
		}

		if (!$this->request->post['config_product_limit']) {
			$this->error['product_limit'] = $this->language->get('error_limit');
		}

		if (!$this->request->post['config_product_description_length']) {
			$this->error['product_description_length'] = $this->language->get('error_limit');
		}

		if (!$this->request->post['config_limit_admin']) {
			$this->error['limit_admin'] = $this->language->get('error_limit');
		}

		if ((utf8_strlen($this->request->post['config_encryption']) < 32) || (utf8_strlen($this->request->post['config_encryption']) > 1024)) {
			$this->error['encryption'] = $this->language->get('error_encryption');
		}

		if ($this->error && !isset($this->error['warning'])) {
			$this->error['warning'] = $this->language->get('error_warning');
		}

		return !$this->error;
	}

	public function template() {
		if ($this->request->server['HTTPS']) {
			$server = HTTPS_CATALOG;
		} else {
			$server = HTTP_CATALOG;
		}

		if (is_file(DIR_IMAGE . 'templates/' . basename($this->request->get['template']) . '.png')) {
			$this->response->setOutput($server . 'image/templates/' . basename($this->request->get['template']) . '.png');
		} else {
			$this->response->setOutput($server . 'image/no_image.png');
		}
	}
}
