<?php
class ControllerModuleFeatured extends Controller {
	public function index($setting) {

		$data = array_merge( isset($data) ? $data : array() , $this->load->language('module/featured'));

		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		$data['catalog_link'] = $this->url->link('product/category', 'path=33');

		$data['products'] = array();

		if (!$setting['limit']) {
			$setting['limit'] = 4;
		}

		if (isset($this->request->get['route']) && $this->request->get['route'] == 'product/product') {
			$data['heading_title'] = $this->language->get('heading_title_product');
		}

		$products = array_slice($setting['product'], 0, (int)$setting['limit']);

		if (empty($products) || count($products) < $setting['limit'] && !empty($setting['category'])) {
			$this->load->model('catalog/product');

			$products = array_merge(isset($products) ? $products : array() , $this->model_catalog_product->findProductsByCategories
				($setting['category']));
		}
		$products = array_unique(array_slice($products, 0, (int)$setting['limit']));

		if (!empty($products)) {

			foreach ($products as $product_id) {
				$product_info = $this->model_catalog_product->getProduct($product_id);

				if ($product_info) {
					if ($product_info['image']) {
						$image = $this->model_tool_image->resize($product_info['image'], $setting['width'], $setting['height']);
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
					}

					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}

					if ((float)$product_info['special']) {
						$special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}

					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$product_info['special'] ? $product_info['special'] : $product_info['price']);
					} else {
						$tax = false;
					}

					if ($this->config->get('config_review_status')) {
						$rating = $product_info['rating'];
					} else {
						$rating = false;
					}

					$description = utf8_substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length'));
					if (!empty($description)) {
						$description .= "..";
					}

					$data['products'][] = array(
						'product_id'  => $product_info['product_id'],
						'thumb'       => $image,
						'name'        => $product_info['name'],
						'description' => $description,
						'price'       => $price,
						'special'     => $special,
						'tax'         => $tax,
						'rating'      => $rating,
						'href'        => $this->url->link('product/product', 'product_id=' . $product_info['product_id'])
					);
				}
			}
		}

		if ($data['products']) {
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/featured.tpl')) {
				return $this->load->view($this->config->get('config_template') . '/template/module/featured.tpl', $data);
			} else {
				return $this->load->view('default/template/module/featured.tpl', $data);
			}
		}
	}
}