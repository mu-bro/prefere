<?php

class ModelTotalShipping extends Model {
    public function getTotal(&$total_data, &$total, &$taxes) {
        if (isset($this->session->data['shipping_methods'])) {

            $delInfo = $this->session->data['delInfo'];
            if (isset($delInfo['shipping_method']['code'])) {
                $shippingCode = str_replace(".", "_", $delInfo['shipping_method']['code']);
                $shArray = explode("_", $shippingCode);
                $shippingInfo = $this->session->data['shipping_methods'][$shArray[0]]['quote'][$shArray[1]];

                $total_data[] = array(
                    'code' => 'shipping',
                    'title' => $shippingInfo['title'],
                    'value' => $shippingInfo['cost'],
                    'sort_order' => $this->config->get('shipping_sort_order')
                );

                if ($shippingInfo['tax_class_id']) {
                    $tax_rates = $this->tax->getRates($shippingInfo['cost'], $shippingInfo['tax_class_id']);

                    foreach ($tax_rates as $tax_rate) {
                        if (!isset($taxes[$tax_rate['tax_rate_id']])) {
                            $taxes[$tax_rate['tax_rate_id']] = $tax_rate['amount'];
                        } else {
                            $taxes[$tax_rate['tax_rate_id']] += $tax_rate['amount'];
                        }
                    }
                }

                $total += $shippingInfo['cost'];
            }
        }
    }

    public function getProductShipping($cart_id) {
        if (isset($this->session->data['delInfo'][$cart_id])) {
            $delInfo = $this->session->data['delInfo'][$cart_id];
            if (isset($delInfo['shipping_method']['code'])) {
                $shippingCode = str_replace(".", "_", $delInfo['shipping_method']['code']);
                $shArray = explode("_", $shippingCode);
                $shippingInfo = $this->session->data['shipping_methods'][$shArray[0]]['quote'][$shArray[1]];
                //p($product,$this->session->data);

                return array(
                    'code' => 'shipping',
                    'title' => $shippingInfo['title'],
                    'value' => $shippingInfo['cost'],
                    'price' => $this->currency->format($shippingInfo['cost']),

                );

            }
        }
    }
}