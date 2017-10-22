<?php
class ControllerModuleIcons extends Controller {
	public function index($setting) {
		static $module = 0;

		$this->load->model('design/banner');
		$this->load->model('tool/image');

		$data['banners'] = array();

		$results = $this->model_design_banner->getBanner($setting['banner_id']);

		foreach ($results as $result) {
			$text = explode("::", $result['title']);

			if (is_file(DIR_IMAGE . $result['image'])) {
				$data['banners'][] = array(
					'title' => $text[0],
					'description' => (isset($text[1])) ? $text[1] : '',
					'link'  => $result['link'],
					'image' => $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height'])
				);
			}
		}

		if (isset($setting['position']) && $setting['position'] == 'column_right') {
			$data['columnClass'] = "col-lg-12 col-sm-12 col-md-12 col-xs-12";
		} else {
			$column = (int)(count($data['banners']) == 5) ? 15 : (12 / count($data['banners']));
			$data['columnClass'] = "col-lg-$column col-sm-$column col-md-$column col-xs-$column";
		}

		$data['module'] = $module++;

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/icons.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/module/icons.tpl', $data);
		} else {
			return $this->load->view('default/template/module/icons.tpl', $data);
		}
	}
}
