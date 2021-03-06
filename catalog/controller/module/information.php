<?php
class ControllerModuleInformation extends Controller {
	public function index() {
$data = array_merge( isset($data) ? $data : array() , $this->load->language('module/information'));

		$this->load->model('catalog/information');

		$data['informations'] = array();

		foreach ($this->model_catalog_information->getInformations() as $result) {
			$data['informations'][] = array(
				'title' => $result['title'],
				'href'  => $this->url->link('information/information', 'information_id=' . $result['information_id'])
			);
		}

		$data['contact'] = $this->url->link('information/contact');
		$data['sitemap'] = $this->url->link('information/sitemap');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/information.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/module/information.tpl', $data);
		} else {
			return $this->load->view('default/template/module/information.tpl', $data);
		}
	}
}