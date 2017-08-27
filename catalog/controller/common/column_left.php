<?php
class ControllerCommonColumnLeft extends Controller {
	public function index() {

		$this->load->model('design/layout');
		$data['modules'] = $this->model_design_layout->getModules('column_left');


		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/column_left.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/common/column_left.tpl', $data);
		} else {
			return $this->load->view('default/template/common/column_left.tpl', $data);
		}
	}
}