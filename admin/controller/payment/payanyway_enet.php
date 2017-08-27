<?php 
class ControllerPaymentPayanywayENet extends Controller {
	private $error = array(); 
	 
	public function index() { 
		$this->load->language('payment/payanyway_enet');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
				
		$this->load->model('localisation/currency');
		$data['currencies'] = array();
		$results = $this->model_localisation_currency->getCurrencies();	
		foreach ($results as $result) {
			if ($result['status']) {
   				$data['currencies'][] = array(
					'title'        => $result['title'],
					'code'         => $result['code']
				);
			}
		}

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('payanyway', $this->request->post['payanyway']);
			$this->model_setting_setting->editSetting('payanyway_enet', $this->request->post['payanyway_enet']);

			$this->session->data['success'] = $this->language->get('text_success');
			
			$this->response->redirect($this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_all_zones'] = $this->language->get('text_all_zones');
				
		$data['entry_order_status'] = $this->language->get('entry_order_status');
		$data['entry_payed_order_status'] = $this->language->get('entry_payed_order_status');

		$data['entry_mnt_server'] = $this->language->get('entry_mnt_server');
		$data['entry_order_status'] = $this->language->get('entry_order_status');
		$data['entry_mnt_id'] = $this->language->get('entry_mnt_id');
		$data['entry_mnt_dataintegrity_code'] = $this->language->get('entry_mnt_dataintegrity_code');
		$data['entry_mnt_currency_code'] = $this->language->get('entry_mnt_currency_code');
		$data['entry_mnt_test_mode'] = $this->language->get('entry_mnt_test_mode');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
		
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		$data['tab_general'] = $this->language->get('tab_general');

 		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

  		$data['breadcrumbs'] = array();

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_payment'),
			'href'      => $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('payment/payanyway_enet', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$data['action'] = $this->url->link('payment/payanyway_enet', 'token=' . $this->session->data['token'], 'SSL');

		$data['cancel'] = $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL');
		
		if (isset($this->request->post['payanyway_mnt_server'])) {
			$data['payanyway_mnt_server'] = $this->request->post['payanyway_mnt_server'];
		} else {
			$data['payanyway_mnt_server'] = $this->config->get('payanyway_mnt_server');
		}
				
		if (isset($this->request->post['payanyway_mnt_id'])) {
			$data['payanyway_mnt_id'] = $this->request->post['payanyway_mnt_id'];
		} else {
			$data['payanyway_mnt_id'] = $this->config->get('payanyway_mnt_id');
		} 
		
		if (isset($this->request->post['payanyway_order_status_id'])) {
			$data['payanyway_order_status_id'] = $this->request->post['payanyway_order_status_id'];
		} else {
			$data['payanyway_order_status_id'] = $this->config->get('payanyway_order_status_id');
		}

		if (isset($this->request->post['payanyway_payed_order_status_id'])) {
			$data['payanyway_payed_order_status_id'] = $this->request->post['payanyway_payed_order_status_id'];
		} else {
			$data['payanyway_payed_order_status_id'] = $this->config->get('payanyway_payed_order_status_id');
		}

		$this->load->model('localisation/order_status');
		
		$data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();
		
		if (isset($this->request->post['payanyway_mnt_dataintegrity_code'])) {
			$data['payanyway_mnt_dataintegrity_code'] = $this->request->post['payanyway_mnt_dataintegrity_code'];
		} else {
			$data['payanyway_mnt_dataintegrity_code'] = $this->config->get('payanyway_mnt_dataintegrity_code');
		} 
		
		if (isset($this->request->post['payanyway_mnt_currency_code'])) {
			$data['payanyway_mnt_currency_code'] = $this->request->post['payanyway_mnt_currency_code'];
		} else {
			$data['payanyway_mnt_currency_code'] = $this->config->get('payanyway_mnt_currency_code');
		}

		if (isset($this->request->post['payanyway_mnt_test_mode'])) {
			$data['payanyway_mnt_test_mode'] = $this->request->post['payanyway_mnt_test_mode'];
		} else {
			$data['payanyway_mnt_test_mode'] = $this->config->get('payanyway_mnt_test_mode');
		}
		
		if (isset($this->request->post['payanyway_enet_status'])) {
			$data['payanyway_enet_status'] = $this->request->post['payanyway_enet_status'];
		} else {
			$data['payanyway_enet_status'] = $this->config->get('payanyway_enet_status');
		}

		if (isset($this->request->post['payanyway_enet_sort_order'])) {
			$data['payanyway_enet_sort_order'] = $this->request->post['payanyway_enet_sort_order'];
		} else {
			$data['payanyway_enet_sort_order'] = $this->config->get('payanyway_enet_sort_order');
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('payment/payanyway_enet.tpl', $data));
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'payment/payanyway_enet')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
				
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
?>