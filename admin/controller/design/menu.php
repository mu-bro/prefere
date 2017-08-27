<?php 
class ControllerDesignMenu extends Controller {
	private $error = array();
 
	public function index() {

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('design/menu');
		
		$this->getList();
	}

	public function insert() {
		$this->load->language('design/menu');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('design/menu');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_design_menu->addMenu($this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			
			$this->response->redirect($this->url->link('design/menu', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function update() {
		$this->load->language('design/menu');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('design/menu');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_design_menu->editMenu($this->request->get['menu_id'], $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
					
			$this->response->redirect($this->url->link('design/menu', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}
 
	public function delete() {
		$this->load->language('design/menu');
 
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('design/menu');
		
		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $menu_id) {
				$this->model_design_menu->deleteMenu($menu_id);
			}
			
			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('design/menu', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getList();
	}

	private function getList() {

		$data = $this->load->language('design/menu');
		$this->document->setTitle($this->language->get('heading_title'));

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'name';
		}
		
		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}
		
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
			
		$url = '';
			
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

  		$data['breadcrumbs'] = array();

   		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL')
   		);

   		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('design/menu', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);

		$data['insert'] = $this->url->link('design/menu/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$data['delete'] = $this->url->link('design/menu/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');
		 
		$data['menus'] = array();

		$filter_data = array(
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit' => $this->config->get('config_admin_limit')
		);
		
		$menu_total = $this->model_design_menu->getTotalMenus();
		
		$results = $this->model_design_menu->getMenus($filter_data);
		
		foreach ($results as $result) {
			$action = array();
			
			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('design/menu/update', 'token=' . $this->session->data['token'] . '&menu_id=' . $result['menu_id'] . $url, 'SSL')
			);

			$data['menus'][] = array(
				'menu_id' => $result['menu_id'],
				'name'      => $result['name'],
				'column_limit'      => $result['column_limit'],
				'style_id' => $result['style_id'],
				'selected'  => isset($this->request->post['selected']) && in_array($result['menu_id'], $this->request->post['selected']),				
				'action'    => $action
			);
		}

 		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		
		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		$url = '';

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
		$data['sort_name'] = $this->url->link('design/menu', 'token=' . $this->session->data['token'] . '&sort=name' . $url, 'SSL');
		
		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
		
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $menu_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('design/menu', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$data['pagination'] = $pagination->render();
		
		$data['sort'] = $sort;
		$data['order'] = $order;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('design/menu_list.tpl', $data));
	}

	private function getForm() {
		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['text_default'] = $this->language->get('text_default');
		
		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_type'] = $this->language->get('entry_type');
		$data['entry_store'] = $this->language->get('entry_store');
		$data['entry_route'] = $this->language->get('entry_route');
		$data['entry_route_name'] = $this->language->get('entry_route_name');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_add_route'] = $this->language->get('button_add_route');
		$data['button_remove'] = $this->language->get('button_remove');

		$data['text_default'] = $this->language->get('text_default');
		$data['text_image_manager'] = $this->language->get('text_image_manager');
 		$data['text_browse'] = $this->language->get('text_browse');
		$data['text_clear'] = $this->language->get('text_clear');

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

		$data["token"] = $this->session->data["token"];

		$types = array(
			"route"         => $this->language->get('type_route'),
			"submenu"       => $this->language->get('type_submenu'),
			"category"      => $this->language->get('type_category'),
			"information"   => $this->language->get('type_information'),
			"html"          => $this->language->get('type_html'),
			"contactus"     => $this->language->get('type_contactus'),
			"delimiter"     => $this->language->get('type_delimiter'),
		);
		$types2 = array(
			"empty"         => $this->language->get("type_empty"),
			"route"         => $this->language->get('type_route'),
			"category"      => $this->language->get('type_category'),
			"information"   => $this->language->get('type_information'),
			"contactus"     => $this->language->get('type_contactus')
		);
		
		$this->load->model("catalog/category");
		$data["category"] = $this->model_catalog_category->getCategories(0);
		
		$this->load->model("catalog/information");
		$data["information"] = $this->model_catalog_information->getInformations();
		
		$data["submenu"] = array();
		
		$menu_list = $this->model_design_menu->getMenus();
		
		foreach( $menu_list as $menu ) {
			if( empty( $this->request->get["menu_id"] ) || $menu["menu_id"] != (int)$this->request->get["menu_id"] ){
				$data["submenu"][] = $menu;
			}
		}
		
		$data["types"] = $types;
		$data["types2"] = $types2;

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

  		$data['breadcrumbs'] = array();

   		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
   		);

   		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('design/menu', 'token=' . $this->session->data['token'] . $url, 'SSL'),
			'separator' => ' :: '
   		);

		if (!isset($this->request->get['menu_id'])) { 
			$data['action'] = $this->url->link('design/menu/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$data['action'] = $this->url->link('design/menu/update', 'token=' . $this->session->data['token'] . '&menu_id=' . $this->request->get['menu_id'] . $url, 'SSL');
		}
		
		$data['cancel'] = $this->url->link('design/menu', 'token=' . $this->session->data['token'] . $url, 'SSL');
		
		if (isset($this->request->get['menu_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$menu_info = $this->model_design_menu->getMenu($this->request->get['menu_id']);
		}

		if (isset($this->request->post['name'])) {
			$data['name'] = $this->request->post['name'];
		} elseif (!empty($menu_info)) {
			$data['name'] = $menu_info['name'];
		} else {
			$data['name'] = '';
		}
		$data['text_form'] = $this->language->get('text_form') . ": " . $data['name'];


		if (isset($this->request->post['column_limit'])) {
			$data['column_limit'] = $this->request->post['column_limit'];
		} elseif (!empty($menu_info)) {
			$data['column_limit'] = $menu_info['column_limit'];
		} else {
			$data['column_limit'] = '';
		}
		
		if (isset($this->request->post['style_id'])) {
			$data['style_id'] = $this->request->post['style_id'];
		} elseif (!empty($menu_info)) {
			$data['style_id'] = $menu_info['style_id'];
		} else {
			$data['style_id'] = '';
		}

		if (isset($this->request->post['color'])) {
			$data['color'] = $this->request->post['color'];
		} elseif (!empty($menu_info)) {
			$data['color'] = $menu_info['color'];
		} else {
			$data['color'] = '';
		}
		
		if (isset($this->request->post['column_width'])) {
			$data['column_width'] = $this->request->post['column_width'];
		} elseif (!empty($menu_info)) {
			$data['column_width'] = $menu_info['column_width'];
		} else {
			$data['column_width'] = '';
		}
		
		$this->load->model('setting/store');
		
		$data['stores'] = $this->model_setting_store->getStores();
		
		$this->load->model('localisation/language');
		
		$data['languages'] = $this->model_localisation_language->getLanguages();
		
		if (isset($this->request->post['menu_route'])) {
			$menu_routes = $this->request->post['menu_route'];
		} elseif (isset($this->request->get['menu_id'])) {
			$menu_routes = $this->model_design_menu->getMenuRoutes($this->request->get['menu_id']);
		} else {
			$menu_routes = array();
		}
		
		$this->load->model('tool/image');
		
		$data['menu_routes'] = array();
		
		foreach ($menu_routes as $menu_route) {
			if ($menu_route['image'] && file_exists(DIR_IMAGE . $menu_route['image'])) {
				$image = $menu_route['image'];
				$thumb = $menu_route['image'];
			} else {
				$image = '';
				$thumb = 'no_image.png';
			}

			$data['menu_routes'][] = array(
				'menu_route_description'   => $menu_route['menu_route_description'],
				'sort_order'               => $menu_route['sort_order'],
				'submenu'                  => $menu_route['submenu'],
				'category'                 => $menu_route['category'],
				'information'              => $menu_route['information'],
				'route'                    => $menu_route['route'],
				'menu_type'                => $menu_route['menu_type'],
				'menu_type_2'              => $menu_route['menu_type_2'],
				'store_id'                 => $menu_route['store_id'],
				'menu_id'                  => $menu_route['menu_id'],
				'menu_route_id'            => $menu_route['menu_route_id'],
				'image'                    => $image,
				'thumb'                    => $this->model_tool_image->resize($thumb, 40, 40)
			);
		}

		$data['placeholder'] = $this->model_tool_image->resize('no_image.png', 40, 40);

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('design/menu_form.tpl', $data));
	}

	private function validateForm() {
		if (!$this->user->hasPermission('modify', 'design/menu')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 64)) {
			$this->error['name'] = $this->language->get('error_name');
		}
		if ( (int)$this->request->post['column_limit'] == 0 ){
			$this->request->post['column_limit'] = 0;
		} else {
			$this->request->post['column_limit'] = (int) $this->request->post['column_limit'];
		}
		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	private function validateDelete() {
		if (!$this->user->hasPermission('modify', 'design/menu')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
	
		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}
}
?>