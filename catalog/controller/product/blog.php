<?php
class ControllerProductBlog extends Controller {
	public function index() {

		$data = $this->load->language('product/blog');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

			$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('product/blog')
		);

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/blog.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/product/blog.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/product/blog.tpl', $data));
		}
	}
}
