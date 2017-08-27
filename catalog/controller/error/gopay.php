<?php
class ControllerErrorGoPay extends Controller {
	public function index() {
		$this->language->load('payment/gopay');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = array();

      	$data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
        	'separator' => FALSE
      	);

		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('error/gopay'),
			'separator' => $this->language->get('text_separator')
		);

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_error_info'] = $this->language->get('text_error_info');

		$data['button_continue'] = $this->language->get('button_continue');

		if (isset($this->session->data['error'])) {
			$data['error'] = $this->session->data['error'];

			unset($this->session->data['error']);
		}

		$data['continue'] = $this->url->link('checkout/checkout', '', 'SSL');

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/gopay.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/error/gopay.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/error/gopay.tpl', $data));
		}
  	}
}
?>