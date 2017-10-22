<?php
class ControllerCommonFooter extends Controller {
	public function index() {

		$headerData = $this->load->language('common/header');
		$data['telephone_label'] = $headerData['telephone_label'];
		$data['telephone_label_2'] = $headerData['telephone_label_2'];

		$data = array_merge( isset($data) ? $data : array() , $this->load->language('common/footer'));

		$data['scripts'] = $this->document->getScripts('footer');


		$data['powered'] = sprintf($this->language->get('text_powered'), $this->config->get('config_name'), date('Y', time()));
		$data['telephone'] = $this->config->get('config_telephone');
		$data['telephone_2'] = $this->config->get('config_telephone_2');

		if (!isset($this->session->data['preload'])) {
			$this->session->data['preload'] = true;
			$data['preload_action'] = true;
		} else {
			$data['preload_action'] = false;
		}

		// Whos Online
		if ($this->config->get('config_customer_online')) {
			$this->load->model('tool/online');

			if (isset($this->request->server['REMOTE_ADDR'])) {
				$ip = $this->request->server['REMOTE_ADDR'];
			} else {
				$ip = '';
			}

			if (isset($this->request->server['HTTP_HOST']) && isset($this->request->server['REQUEST_URI'])) {
				$url = 'http://' . $this->request->server['HTTP_HOST'] . $this->request->server['REQUEST_URI'];
			} else {
				$url = '';
			}

			if (isset($this->request->server['HTTP_REFERER'])) {
				$referer = $this->request->server['HTTP_REFERER'];
			} else {
				$referer = '';
			}

			$this->model_tool_online->addOnline($ip, $this->customer->getId(), $url, $referer);
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
		$data['blog'] = $this->url->link('news_reviews/category', 'cat=1', 'SSL');

		$this->load->model('design/layout');
		$data['modules'] = $this->model_design_layout->getModules('footer');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/footer.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/common/footer.tpl', $data);
		} else {
			return $this->load->view('default/template/common/footer.tpl', $data);
		}
	}
}
