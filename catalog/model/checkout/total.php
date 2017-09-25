<?php

class ModelCheckoutTotal extends Model {

    public function getTotals() {
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
        return array(
            $data['totals'],
            $total
        );
    }

    public function getTotalsHtml() {
        list($totals,$total) = $this->getTotals();

        $total_text = '<tr><td class="text-right">%s:</td><td class="text-right total">%s</td></tr>';
        $result = '';
        foreach ($totals as $total_item) {
            $result .= sprintf($total_text, $total_item['title'],$total_item['text']);
        }
        return $result;
    }

}
