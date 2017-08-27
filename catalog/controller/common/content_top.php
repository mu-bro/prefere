<?php
class ControllerCommonContentTop extends Controller {
	public function index() {
		$this->load->model('design/layout');
		$data['modules'] = $this->model_design_layout->getModules('content_top');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/content_top.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/common/content_top.tpl', $data);
		} else {
			return $this->load->view('default/template/common/content_top.tpl', $data);
		}
	}
}