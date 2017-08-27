<?php
class ControllerModuleCategory extends Controller {
	public function index() {

$data = array_merge( isset($data) ? $data : array() , $this->load->language('module/category'));

		if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
		} else {
			$parts = array();
		}

		if (isset($parts[0])) {
			$data['category_id'] = $parts[0];
		} else {
			$data['category_id'] = 0;
		}

		if (isset($parts[1])) {
			$data['child_id'] = $parts[1];
		} else {
			$data['child_id'] = 0;
		}

		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		$data['categories'] = array();
		$data['catalog_link'] = $this->url->link('product/category', 'path=33');

		$categories = $this->config->get('category_categories');

		foreach ($categories as $category_id) {
			$category_info = $this->model_catalog_category->getCategory($category_id);
//p($category_info);
			if ($category_info['image']) {
				$thumb = $this->model_tool_image->resize($category_info['image'], 500, 500);
			} else {
				$thumb = '';
			}

			$data['categories'][] = array(
				'category_id' => $category_id,
				'name'        => $category_info['name'],
				'image'       => $thumb,
				'href'        => $this->url->link('product/category', 'path=' . $category_id)
			);
		}
//p($data['categories']);
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/category.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/module/category.tpl', $data);
		} else {
			return $this->load->view('default/template/module/category.tpl', $data);
		}
	}
}