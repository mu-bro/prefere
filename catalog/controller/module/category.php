<?php
class ControllerModuleCategory extends Controller {
	public function index($setting) {

	$data = array_merge( isset($data) ? $data : array() , $this->load->language('module/category'));

		$this->load->model('catalog/category');

		$this->load->model('tool/image');

		$data['categories'] = array();
		$categories = $setting['category_categories'];
		$data['heading_title'] = $setting['name'];

		foreach ($categories as $category_id) {
			$category_info = $this->model_catalog_category->getCategory($category_id);

			if ($category_info['image']) {
				$thumb = $this->model_tool_image->resize($category_info['image'], 500, 500);
			} else {
				$thumb = '';
			}
			if (empty($thumb)) continue;
			$data['categories'][] = array(
				'category_id' => $category_id,
				'name'        => $category_info['name'],
				'image'       => $thumb,
				'href'        => $this->url->link('product/category', 'path=' . $category_id)
			);
		}

		$column = (int) (count($data['categories']) == 5) ? 15 : (12 / count($data['categories']));
		$data['columnClass'] = "col-lg-$column col-sm-$column col-md-$column col-xs-6";
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/category.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/module/category.tpl', $data);
		} else {
			return $this->load->view('default/template/module/category.tpl', $data);
		}
	}
}