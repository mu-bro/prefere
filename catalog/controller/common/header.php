<?php

class ControllerCommonHeader extends Controller {
    public function index() {
        // Analytics
        $this->load->model('extension/extension');

        $data['analytics'] = array();

        $analytics = $this->model_extension_extension->getExtensions('analytics');

        foreach ($analytics as $analytic) {
            if ($this->config->get($analytic['code'] . '_status')) {
                $data['analytics'][] = $this->load->controller('analytics/' . $analytic['code']);
            }
        }

        $data['informations'] = array();
        $this->load->model('catalog/information');
        foreach ($this->model_catalog_information->getInformations() as $result) {
            if ($result['bottom']) {
                $data['informations'][] = array(
                    'title' => $result['title'],
                    'href' => $this->url->link('information/information', 'information_id=' . $result['information_id'])
                );
            }
        }

        $data['config_smartsupp_enabled'] = $this->config->get('config_smartsupp_enabled');
        $data['config_smartsupp_key'] = $this->config->get('config_smartsupp_key');

        if ($this->request->server['HTTPS']) {
            $server = $this->config->get('config_ssl');
        } else {
            $server = $this->config->get('config_url');
        }

        if (is_file(DIR_IMAGE . $this->config->get('config_icon'))) {
            $this->document->addLink($server . 'image/' . $this->config->get('config_icon'), 'icon');
        }

        $data['lang'] = $this->language->get('code');

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/stylesheet/' . $this->language->get('code') . '.css')) {
            $this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/' . $this->language->get('code') . '.css');
        }

        $data['title'] = $this->document->getTitle();

        $data['base'] = $server;
        $data['description'] = $this->document->getDescription();
        $data['keywords'] = $this->document->getKeywords();
        $data['links'] = $this->document->getLinks();
        $data['styles'] = $this->document->getStyles();
        $data['scripts'] = $this->document->getScripts();

        $data['name'] = $this->config->get('config_name');

        if (is_file(DIR_IMAGE . $this->config->get('config_logo'))) {
            $data['logo'] = $server . 'image/' . $this->config->get('config_logo');
        } else {
            $data['logo'] = '';
        }

        $data = array_merge(isset($data) ? $data : array(), $this->load->language('common/header'));

        // Wishlist
        if ($this->customer->isLogged()) {
            $this->load->model('account/wishlist');

            $data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), $this->model_account_wishlist->getTotalWishlist());
        } else {
            $data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), (isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0));
        }
        $data['text_logged'] = sprintf($this->language->get('text_logged'), $this->url->link('account/account', '', 'SSL'), $this->customer->getFirstName(), $this->url->link('account/logout', '', 'SSL'));

        $data['home'] = $this->url->link('common/home');
        $data['wishlist'] = $this->url->link('account/wishlist', '', 'SSL');
        $data['logged'] = $this->customer->isLogged();
        $data['account_edit'] = $this->url->link('account/edit', '', 'SSL');
        $data['account_password'] = $this->url->link('account/password', '', 'SSL');
        $data['account_order'] = $this->url->link('account/order', '', 'SSL');
        $data['register'] = $this->url->link('account/register', '', 'SSL');
        $data['login'] = $this->url->link('account/login', '', 'SSL');
        $data['transaction'] = $this->url->link('account/transaction', '', 'SSL');
        $data['download'] = $this->url->link('account/download', '', 'SSL');
        $data['logout'] = $this->url->link('account/logout', '', 'SSL');
        $data['shopping_cart'] = $this->url->link('checkout/cart');
        $data['checkout'] = $this->url->link('checkout/checkout', '', 'SSL');
        $data['contact'] = $this->url->link('information/contact');
        $data['telephone'] = $this->config->get('config_telephone');
        $data['telephone_2'] = $this->config->get('config_telephone_2');

        $data['storeListconf'] = json_decode(htmlspecialchars_decode($this->config->get('config_store_list')), true);
        foreach ($data['storeListconf'] as $k => $v) {
            if (!empty($v)) {
                $data['storeList'][$v['store']] = $v['link'];
            }
        }


        $status = true;

        if (isset($this->request->server['HTTP_USER_AGENT'])) {
            $robots = explode("\n", str_replace(array(
                "\r\n",
                "\r"
            ), "\n", trim($this->config->get('config_robots'))));

            foreach ($robots as $robot) {
                if ($robot && strpos($this->request->server['HTTP_USER_AGENT'], trim($robot)) !== false) {
                    $status = false;

                    break;
                }
            }
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

        $data['config_store_metrics'] = $this->config->get('config_store_metrics');

        // Menu
        $this->load->model('catalog/category');

        $this->load->model('catalog/product');

        $data['cart_total'] = sprintf($this->language->get('text_items'), $this->cart->countProducts());

        $data['language'] = $this->load->controller('common/language');
        $data['currency'] = $this->load->controller('common/currency');
        $data['search'] = $this->load->controller('common/search');
        $data['cart'] = $this->load->controller('common/cart');
        $data['lng_editable'] = $this->load->controller('module/lng_editable');
        $data['quicksignup'] = $this->load->controller('common/quicksignup');
        $data['rcart'] = $this->load->controller('common/rcart');

        // For page specific css
        if (isset($this->request->get['route'])) {
            if (isset($this->request->get['product_id'])) {
                $class = '-' . $this->request->get['product_id'];
            } elseif (isset($this->request->get['path'])) {
                $class = '-' . $this->request->get['path'];
            } elseif (isset($this->request->get['manufacturer_id'])) {
                $class = '-' . $this->request->get['manufacturer_id'];
            } else {
                $class = '';
            }

            $data['class'] = str_replace('/', '-', $this->request->get['route']) . $class;
        } else {
            $data['class'] = 'common-home';
            $this->request->get['route'] = "common/home";
        }
        $data['product_count'] = $this->cart->countProducts();
        $data['showMiniCart'] = !in_array($this->request->get['route'], array(
            'checkout/cart',
            'checkout/checkout'
        ));

        $this->load->model('design/layout');
        $data['modules'] = $this->model_design_layout->getModules('header');

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/header.tpl')) {
            return $this->load->view($this->config->get('config_template') . '/template/common/header.tpl', $data);
        } else {
            return $this->load->view('default/template/common/header.tpl', $data);
        }
    }
}
