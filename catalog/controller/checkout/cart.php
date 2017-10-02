<?php

class ControllerCheckoutCart extends Controller {
    public function index() {
//        p($this->session->data);
        $data = array_merge(isset($data) ? $data : array(), $this->load->language('checkout/cart'));

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('checkout/cart');
        $data["shipping_methods"] = $this->model_checkout_cart->getShippingMethods();
//unset($this->session->data['delInfo']['shipping_method']);
        $data["isLogged"] = $this->customer->isLogged();
        if (!isset($this->session->data['customerInfo'])) {
            if ($this->customer->isLogged()) {
                $data["customerInfo"] = $this->session->data['customerInfo'] = array(
                    "name" => $this->customer->getFirstName(),
                    "email" => $this->customer->getEmail(),
                    "phone" => $this->customer->getTelephone()
                );
            } else {
                $data["customerInfo"] = $this->session->data['customerInfo'] = array(
                    "name" => "",
                    "email" => "",
                    "phone" => ""
                );
            }
        } else {
            $data["customerInfo"] = $this->session->data['customerInfo'];
        }

        if (isset($this->session->data['comment'])) {
            $data['comment'] = $this->session->data['comment'];
        } else {
            $data['comment'] = '';
        }

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'href' => $this->url->link('common/home'),
            'text' => $this->language->get('text_home')
        );

        $data['breadcrumbs'][] = array(
            'href' => $this->url->link('checkout/cart'),
            'text' => $this->language->get('heading_title')
        );

        if ($this->cart->hasProducts() || !empty($this->session->data['vouchers'])) {

            if (!$this->cart->hasStock() && (!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning'))) {
            } elseif (isset($this->session->data['error'])) {
                $data['error_warning'] = $this->session->data['error'];

                unset($this->session->data['error']);
            } else {
                $data['error_warning'] = '';
            }

            if ($this->config->get('config_customer_price') && !$this->customer->isLogged()) {
                $data['attention'] = sprintf($this->language->get('text_login'), $this->url->link('account/login'), $this->url->link('account/register'));
            } else {
                $data['attention'] = '';
            }

            if (isset($this->session->data['success'])) {
                $data['success'] = $this->session->data['success'];

                unset($this->session->data['success']);
            } else {
                $data['success'] = '';
            }

            $data['action'] = $this->url->link('checkout/cart/edit', '', true);

            if ($this->config->get('config_cart_weight')) {
                $data['weight'] = $this->weight->format($this->cart->getWeight(), $this->config->get('config_weight_class_id'), $this->language->get('decimal_point'), $this->language->get('thousand_point'));
            } else {
                $data['weight'] = '';
            }

            $this->load->model('tool/image');
            $this->load->model('tool/upload');

            $data['products'] = array();
            $preorder = false;

            $products = $this->cart->getProducts();

            foreach ($products as $product) {
                $product_total = 0;

                foreach ($products as $product_2) {
                    if ($product_2['product_id'] == $product['product_id']) {
                        $product_total += $product_2['quantity'];
                    }
                }

                if ($product['minimum'] > $product_total) {
                    $data['error_warning'] = sprintf($this->language->get('error_minimum'), $product['name'], $product['minimum']);
                }

                if ($product['image']) {
                    $image = $this->model_tool_image->resize($product['image'], $this->config->get('config_image_cart_width'), $this->config->get('config_image_cart_height'));
                } else {
                    $image = '';
                }

                $option_data = array();

                foreach ($product['option'] as $option) {
                    if ($option['type'] != 'file') {
                        $value = $option['value'];
                    } else {
                        $upload_info = $this->model_tool_upload->getUploadByCode($option['value']);

                        if ($upload_info) {
                            $value = $upload_info['name'];
                        } else {
                            $value = '';
                        }
                    }

                    $option_data[] = array(
                        'name' => $option['name'],
                        'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value)
                    );
                }

                // Display prices
                if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                    $price = $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')));
                } else {
                    $price = false;
                }

                // Display prices
                if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                    $total = $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')) * $product['quantity']);
                } else {
                    $total = false;
                }

                $recurring = '';

                if ($product['recurring']) {
                    $frequencies = array(
                        'day' => $this->language->get('text_day'),
                        'week' => $this->language->get('text_week'),
                        'semi_month' => $this->language->get('text_semi_month'),
                        'month' => $this->language->get('text_month'),
                        'year' => $this->language->get('text_year'),
                    );

                    if ($product['recurring']['trial']) {
                        $recurring = sprintf($this->language->get('text_trial_description'), $this->currency->format($this->tax->calculate($product['recurring']['trial_price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax'))), $product['recurring']['trial_cycle'], $frequencies[$product['recurring']['trial_frequency']], $product['recurring']['trial_duration']) . ' ';
                    }

                    if ($product['recurring']['duration']) {
                        $recurring .= sprintf($this->language->get('text_payment_description'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax'))), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
                    } else {
                        $recurring .= sprintf($this->language->get('text_payment_cancel'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax'))), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
                    }
                }

                $data['products'][] = array(
                    'cart_id' => $product['cart_id'],
                    'thumb' => $image,
                    'name' => $product['name'],
                    'preorder' => $product['preorder'],
                    'model' => $product['model'],
                    'option' => $option_data,
                    'recurring' => $recurring,
                    'quantity' => $product['quantity'],
                    'stock' => $product['stock'] ? true : !(!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning')),
                    'reward' => ($product['reward'] ? sprintf($this->language->get('text_points'), $product['reward']) : ''),
                    'price' => $price,
                    'total' => $total,
                    'href' => $this->url->link('product/product', 'product_id=' . $product['product_id'])
                );

                if ($product['preorder']) {
                    $preorder = true;
                }
            }

            $data['delInfo'] = isset($this->session->data['delInfo']) ? $this->session->data['delInfo'] :
                $this->delInfoObject();
            $data['preorder'] = $preorder;

            $data['config_telephone_mask'] = $this->config->get("config_telephone_mask");
            $data['excludeDates'] = $preorder ? $this->document->getDisabledPreOrderDates() : $this->document->getDisabledDates();
//            $data['excludePreorderDates'] = $this->document->getDisabledPreOrderDates();
            $data['excludeOutOfCityDates'] = $this->document->getDisabledOutOfCityDates();
            $data['defaultDate'] = $this->document->getDefaultDate();
            $data['deliver_frames'] = explode(",", str_replace(" ","",$this->config->get("config_deliver_frames")));

            // Gift Voucher
            $data['vouchers'] = array();

            if (!empty($this->session->data['vouchers'])) {
                foreach ($this->session->data['vouchers'] as $key => $voucher) {
                    $data['vouchers'][] = array(
                        'key' => $key,
                        'description' => $voucher['description'],
                        'amount' => $this->currency->format($voucher['amount']),
                        'remove' => $this->url->link('checkout/cart', 'remove=' . $key)
                    );
                }
            }

            list($data['totals'], $total) = $this->getTotals();

            $data['continue'] = $this->url->link('common/home');

            $data['checkout'] = $this->url->link('checkout/checkout', '', 'SSL');

            $this->load->model('extension/extension');

            $data['checkout_buttons'] = array();

            $files = glob(DIR_APPLICATION . '/controller/total/*.php');

            if ($files) {
                foreach ($files as $file) {
                    $extension = basename($file, '.php');

                    $data[$extension] = $this->load->controller('total/' . $extension);
                }
            }

            $this->document->addScript('catalog/view/javascript/jquery/jquery.maskedinput-1.3.min.js');
            $this->document->addScript('catalog/view/javascript/jquery/datetimepicker/moment.js');
            $this->document->addScript('catalog/view/javascript/jquery/datetimepicker/'.$this->language->get('langs').'.js');
            $this->document->addScript('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js');
            $this->document->addStyle('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css');

            $data['column_left'] = $this->load->controller('common/column_left');
            $data['column_right'] = $this->load->controller('common/column_right');
            $data['content_top'] = $this->load->controller('common/content_top');
            $data['content_bottom'] = $this->load->controller('common/content_bottom');
            $data['footer'] = $this->load->controller('common/footer');
            $data['header'] = $this->load->controller('common/header');

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/cart.tpl')) {
                $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/checkout/cart.tpl', $data));
            } else {
                $this->response->setOutput($this->load->view('default/template/checkout/cart.tpl', $data));
            }
        } else {

            $data['continue'] = $this->url->link('common/home');

            unset($this->session->data['success']);


            $data['column_left'] = $this->load->controller('common/column_left');
            $data['column_right'] = $this->load->controller('common/column_right');
            $data['content_top'] = $this->load->controller('common/content_top');
            $data['content_bottom'] = $this->load->controller('common/content_bottom');
            $data['footer'] = $this->load->controller('common/footer');
            $data['header'] = $this->load->controller('common/header');

            $data['text_error'] = $this->language->get('text_empty');



            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
                $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/error/not_found.tpl', $data));
            } else {
                $this->response->setOutput($this->load->view('default/template/error/not_found.tpl', $data));
            }
        }
    }

    public function add() {
        $data = array_merge(isset($data) ? $data : array(), $this->load->language('checkout/cart'));

        $json = array();

        if (isset($this->request->post['product_id'])) {
            $product_id = (int)$this->request->post['product_id'];
        } else {
            $product_id = 0;
        }

        $this->load->model('catalog/product');

        $product_info = $this->model_catalog_product->getProduct($product_id);

        if ($product_info) {
            if (isset($this->request->post['quantity']) && ((int)$this->request->post['quantity'] >= $product_info['minimum'])) {
                $quantity = (int)$this->request->post['quantity'];
            } else {
                $quantity = $product_info['minimum'] ? $product_info['minimum'] : 1;
            }

            if (isset($this->request->post['option'])) {
                $option = array_filter($this->request->post['option']);
            } else {
                $option = array();
            }

            $product_options = $this->model_catalog_product->getProductOptions($this->request->post['product_id']);

            foreach ($product_options as $product_option) {
                if ($product_option['required'] && empty($option[$product_option['product_option_id']])) {
                    $json['error']['option'][$product_option['product_option_id']] = sprintf($this->language->get('error_required'), $product_option['name']);
                }
            }

            if (isset($this->request->post['recurring_id'])) {
                $recurring_id = $this->request->post['recurring_id'];
            } else {
                $recurring_id = 0;
            }

            $recurrings = $this->model_catalog_product->getProfiles($product_info['product_id']);

            if ($recurrings) {
                $recurring_ids = array();

                foreach ($recurrings as $recurring) {
                    $recurring_ids[] = $recurring['recurring_id'];
                }

                if (!in_array($recurring_id, $recurring_ids)) {
                    $json['error']['recurring'] = $this->language->get('error_recurring_required');
                }
            }

            if (!$json) {
                $this->cart->add($this->request->post['product_id'], $quantity, $option, $recurring_id);

                $json['success'] = sprintf($this->language->get('text_success'), $this->url->link('product/product', 'product_id=' . $this->request->post['product_id']), $product_info['name'], $this->url->link('checkout/cart'));

                // Unset all shipping and payment methods
                unset($this->session->data['shipping_method']);
                unset($this->session->data['shipping_methods']);
                unset($this->session->data['payment_method']);
                unset($this->session->data['payment_methods']);

                $json['total'] = sprintf($this->language->get('text_items'), $this->cart->countProducts());
            } else {
                $json['redirect'] = str_replace('&amp;', '&', $this->url->link('product/product', 'product_id=' . $this->request->post['product_id']));
            }
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function editQuantity() {
        $this->cart->update($this->request->post['cartId'], $this->request->post['quantity']);
        $product = $this->cart->getProductInfoByCartId($this->request->post['cartId']);
        $price = $this->currency->format($this->tax->calculate($product['total'], $product['tax_class_id'], $this->config->get
        ('config_tax')));

        $response = array();
        $response['price'] = $price;

        list($totals,$total) = $this->getTotals();
        $total_text = '<tr><td class="text-right">%s:</td><td class="text-right total">%s</td></tr>';
        $response['totals'] = '';
        foreach ($totals as $total_item) {
            $response['totals'] .= sprintf($total_text, $total_item['title'],$total_item['text']);
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($response));

    }
    public function edit() {

        $data = array_merge(isset($data) ? $data : array(), $this->load->language('checkout/cart'));

        $json = array();

        // Update
        if (!empty($this->request->post['quantity'])) {
            foreach ($this->request->post['quantity'] as $key => $value) {
                $this->cart->update($key, $value);
            }

            unset($this->session->data['shipping_method']);
            unset($this->session->data['shipping_methods']);
            unset($this->session->data['payment_method']);
            unset($this->session->data['payment_methods']);
            unset($this->session->data['reward']);

            $this->response->redirect($this->url->link('checkout/cart'));
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function remove() {

        $data = array_merge(isset($data) ? $data : array(), $this->load->language('checkout/cart'));

        $json = array();

        // Remove
        if (isset($this->request->post['key'])) {
            $this->cart->remove($this->request->post['key']);

            unset($this->session->data['vouchers'][$this->request->post['key']]);

            unset($this->session->data['delInfo'][$this->request->post['key']]);

            $this->session->data['success'] = $this->language->get('text_remove');

            unset($this->session->data['shipping_method']);
            unset($this->session->data['shipping_methods']);
            unset($this->session->data['payment_method']);
            unset($this->session->data['payment_methods']);
            unset($this->session->data['reward']);

            list($totals, $total) = $this->getTotals();

            $total_text = '<tr><td class="text-right">%s:</td><td class="text-right total">%s</td></tr>';
            $json['totals'] = '';
            foreach ($totals as $total_item) {
                $json['totals'] .= sprintf($total_text, $total_item['title'],$total_item['text']);
            }

            $json['total'] = sprintf($this->language->get('text_items'), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total));


        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function cartUpdate() {
        $this->language->load('checkout/cart');
        $this->load->model('checkout/cart');

        $this->session->data['delInfo'] = $this->request->post["delInfo"];
        $this->session->data['customerInfo'] = $this->request->post["customer"];
        $this->session->data['comment'] = strip_tags($this->request->post['comment']);

//        p($this->request->post);
        $error = $this->model_checkout_cart->cartValidation($this->request->post);
        //p($error,$this->session->data['delInfo']);
        if (empty($error)) {
            $this->load->model('account/customer');
            $customer = $this->request->post["customer"];
            if (isset($customer['createAccount'])) {

                $this->model_account_customer->addCustomer($customer);

                $this->customer->login($customer['email'], $customer['password']);
                unset($this->session->data['guest']);
            }
            $json['success'] = true;
        } else {
            $json['error'] = $error;
            list($totals,$total) = $this->getTotals();
            $total_text = '<tr><td class="text-right">%s:</td><td class="text-right total">%s</td></tr>';
            $json['totals'] = '';
            foreach ($totals as $total_item) {
                $json['totals'] .= sprintf($total_text, $total_item['title'],$total_item['text']);
            }
        }

        $this->response->setOutput(json_encode($json));
    }



    private function delInfoObject() {
        return $array = array(
            "deliverer" => '',
            "deliver" => array(
                "name" => '',
                "phone" => '',
                "surprize" => '',
                "anonymous" => ''
            ),
            "company" => array(
              "is_company" => '',
              "name" => '',
              "inn" => '',
              "inn2" => '',
              "address" => ''
            ),
            "message" => '',
            "shipping_method" => array(
                "code" => ''
            )
        );
    }

    private function getTotals() {
        // Totals
        $this->load->model('extension/extension');

        $total_data = array();
        $total = 0;
        $taxes = $this->cart->getTaxes();

        // Display prices
        if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
            $sort_order = array();

            $results = $this->model_extension_extension->getExtensions('total');

            foreach ($results as $key => $value) {
                $sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
            }

            array_multisort($sort_order, SORT_ASC, $results);

            foreach ($results as $result) {
                if ($this->config->get($result['code'] . '_status')) {
                    $this->load->model('total/' . $result['code']);

                    $this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
                }
            }

            $sort_order = array();

            foreach ($total_data as $key => $value) {
                $sort_order[$key] = $value['sort_order'];
            }

            array_multisort($sort_order, SORT_ASC, $total_data);
        }

        $data['totals'] = array();

        foreach ($total_data as $total) {
            $data['totals'][] = array(
                'title' => $total['title'],
                'text' => $this->currency->format($total['value'])
            );
        }
        return array($data['totals'],$total);
    }

    public function updatesource() {
        if (isset($this->request->post['source'])) {
            $source = $this->request->post['source'];
        } else {
            $source = '';
        }
        $this->session->data['delInfo']['source_found'] = $source;
    }
}
