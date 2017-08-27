<?php

class ControllerModuleSpecprod extends Controller {
    public function index($setting) {

        $data = array_merge(isset($data) ? $data : array(), $this->load->language('module/specprod'));

        $this->load->model('catalog/product');

        $this->load->model('tool/image');
        $image_dementions = 390;

        $data['products'] = array();

        if (isset($setting['day_product_id']) && !empty($setting['day_product_id'])) {
            $product_info = $this->model_catalog_product->getProduct($setting['day_product_id']);
            if (!empty($product_info)) {
                if ($product_info['image']) {
                    $product_info['thumb'] = $this->model_tool_image->resize($product_info['image'], $image_dementions, $image_dementions);
                } else {
                    $product_info['thumb'] = $this->model_tool_image->resize('placeholder.png', $image_dementions, $image_dementions);
                }

                if ((float)$product_info['special']) {
                    $product_info['special'] = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));
                } else {
                    $product_info['special'] = false;
                }


                $product_info['price'] = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
				
				$description = utf8_substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length'));
				if (!empty($description)) {
					$description .= "..";
				}				
                $product_info['description'] = $description;

                $product_info['title'] = $this->language->get('title_day_product');
                $product_info['help'] = $this->language->get('help_day_product');
                $product_info['icon'] = "catalog/view/theme/default/image/prod_day_icon.png";
                $product_info['href'] = $this->url->link('product/product', 'product_id=' . $product_info['product_id']);
                $data['products'][] = $product_info;
            }

        }

        if (isset($setting['charity_product_id']) && !empty($setting['charity_product_id'])) {
            $product_info = $this->model_catalog_product->getProduct($setting['charity_product_id']);
            if (!empty($product_info)) {
                if ($product_info['image']) {
                    $product_info['thumb'] = $this->model_tool_image->resize($product_info['image'], $image_dementions, $image_dementions);
                } else {
                    $product_info['thumb'] = $this->model_tool_image->resize('placeholder.png', $image_dementions, $image_dementions);
                }
				
                if ((float)$product_info['special']) {
                    $product_info['special'] = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));
                } else {
                    $product_info['special'] = false;
                }				
                $product_info['price'] = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
				
				$description = utf8_substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length'));
				if (!empty($description)) {
					$description .= "..";
				}				
                $product_info['description'] = $description;

                $product_info['title'] = $this->language->get('title_charity_product');
                $product_info['help'] = $this->language->get('help_charity_product');
                $product_info['icon'] = "catalog/view/theme/default/image/prod_charity_icon.png";
                $product_info['href'] = $this->url->link('product/product', 'product_id=' . $product_info['product_id']);
                $data['products'][] = $product_info;
            }
        }


        if (!empty($data['products'])) {
            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/specprod.tpl')) {
                return $this->load->view($this->config->get('config_template') . '/template/module/specprod.tpl', $data);
            } else {
                return $this->load->view('default/template/module/specprod.tpl', $data);
            }
        }
    }
}