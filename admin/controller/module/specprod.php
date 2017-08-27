<?php
class ControllerModuleSpecProd extends Controller {
	private $error = array();

	public function index() {
		$data = $this->load->language('module/specprod');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('extension/module');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			if (!isset($this->request->get['module_id'])) {
				$this->model_extension_module->addModule('specprod', $this->request->post);
			} else {
				$this->model_extension_module->editModule($this->request->get['module_id'], $this->request->post);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['name'])) {
			$data['error_name'] = $this->error['name'];
		} else {
			$data['error_name'] = '';
		}
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_module'),
			'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL')
		);

		if (!isset($this->request->get['module_id'])) {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link('module/specprod', 'token=' . $this->session->data['token'], 'SSL')
			);
		} else {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link('module/specprod', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL')
			);
		}

		if (!isset($this->request->get['module_id'])) {
			$data['action'] = $this->url->link('module/specprod', 'token=' . $this->session->data['token'], 'SSL');
		} else {
			$data['action'] = $this->url->link('module/specprod', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL');
		}

		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
		}

		$data['token'] = $this->session->data['token'];

		if (isset($this->request->post['name'])) {
			$data['name'] = $this->request->post['name'];
		} elseif (!empty($module_info)) {
			$data['name'] = $module_info['name'];
		} else {
			$data['name'] = '';
		}

		if (isset($this->request->post['day_product_id'])) {
			$data['day_product_id'] = $this->request->post['day_product_id'];
		} elseif (!empty($module_info)) {
			$data['day_product_id'] = $module_info['day_product_id'];
		} else {
			$data['day_product_id'] = '';
		}

		if (isset($this->request->post['charity_product_id'])) {
			$data['charity_product_id'] = $this->request->post['charity_product_id'];
		} elseif (!empty($module_info)) {
			$data['charity_product_id'] = $module_info['charity_product_id'];
		} else {
			$data['charity_product_id'] = '';
		}

		$this->load->model('catalog/product');

		if (isset($data['day_product_id']) && !empty($data['day_product_id'])) {
			$product_info = $this->model_catalog_product->getProduct($data['day_product_id']);
			$data['day_product_name'] = $product_info['name'] . " (" . $this->currency->format($product_info['price']) . ")";
		} else {
			$data['day_product_name'] = '';
		}

		if (isset($data['charity_product_id']) && !empty($data['charity_product_id'])) {
			$product_info = $this->model_catalog_product->getProduct($data['charity_product_id']);
			$data['charity_product_name'] = $product_info['name'] . " (" . $this->currency->format($product_info['price']) . ")";
		} else {
			$data['charity_product_name'] = '';
		}


		if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($module_info)) {
			$data['status'] = $module_info['status'];
		} else {
			$data['status'] = '';
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/specprod.tpl', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/specprod')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 64)) {
			$this->error['name'] = $this->language->get('error_name');
		}

		return !$this->error;
	}
}