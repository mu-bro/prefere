<?php
class ControllerCommonMail extends Controller {
	public function index($html) {

		$data = array_merge( isset($data) ? $data : array() , $this->load->language('mail/common'));

		$data['logo'] = $this->config->get('config_url') . 'image/' . $this->config->get('config_logo');
		$data['store_name'] = $this->config->get('config_name');
		$data['title'] = $this->config->get('config_meta_title');
		$data['config_email'] = $this->config->get('config_email');
		$data['html'] = $html;

		if ($this->config->get('config_store_id')) {
			$data['store_url'] = $this->config->get('config_url');
		} else {
			$data['store_url'] = HTTP_SERVER;
		}
		$icons = array();
		if (!empty($this->config->get('config_soc_fb'))) {
			$icons['fb'] = $this->config->get('config_soc_fb');
		}
		if (!empty($this->config->get('config_soc_vk'))) {
			$icons['vk'] = $this->config->get('config_soc_vk');
		}
		if (!empty($this->config->get('config_soc_pi'))) {
			$icons['pi'] = $this->config->get('config_soc_pi');
		}
		if (!empty($this->config->get('config_soc_in'))) {
			$icons['in'] = $this->config->get('config_soc_in');
		}
		$data['soc_icons'] = $icons;

		$data['telephone'] = $this->config->get('config_telephone');
		$data['powered'] = sprintf($this->language->get('text_powered'), $this->config->get('config_name'), date('Y', time()));

//echo $this->load->view('default/template/mail/html_template.tpl', $data);die;
		return $this->load->view('default/template/mail/html_template.tpl', $data);
	}
}
