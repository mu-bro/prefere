<?php
class ControllerModuleSeoKeyword extends Controller {
	private $error = array();
	private $moduleName 			= 'seo_keyword';
	private $moduleModel 			= 'model_module_seo_keyword';
	private $moduleVersion 			= '1.2.0';

    public function install() {
		$this->load->model('module/'.$this->moduleName);
		$this->{$this->moduleModel}->install();
		$this->response->redirect($this->url->link('module/seo_keyword', 'token=' . $this->session->data['token'], 'SSL'));
    }

    public function uninstall() {
		$this->load->model('module/'.$this->moduleName);
		$this->{$this->moduleModel}->uninstall();
    }

	public function index() {
		$this->load->language('module/'.$this->moduleName);

		$this->load->model('module/'.$this->moduleName);

		$this->document->setTitle($this->language->get('heading_title'));

		$data['heading_title'] = $this->language->get('heading_title');

		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['text_load_message'] = $this->language->get('text_load_message');
		$data['error_message'] = $this->language->get('error_message');
		$data['error_no_message'] = $this->language->get('error_no_message');
		$data['text_retry'] = $this->language->get('text_retry');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_module'),
			'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title') . ' ' . $this->moduleVersion,
			'href' => $this->url->link('module/seo_keyword', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$data['token'] = $this->session->data['token'];

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/seo_keyword.tpl', $data));
	}

	public function getNotifications() {
		sleep(1);
		$this->load->model('module/'.$this->moduleName);
		$this->load->language('module/'.$this->moduleName);
		$response = $this->{$this->moduleModel}->getNotifications($this->moduleVersion);
		$json = array();
		if ($response===false) {
			$json['message'] = '';
			$json['error'] = $this->language->get('error_notifications');
		} else {
			$json['message'] = $response;
			$json['error'] = '';
		}
		$this->response->setOutput(json_encode($json));
	}
}
?>