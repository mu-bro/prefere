<?php

class ControllerTotalReward extends Controller {
    public function index() {
        $points = $this->customer->getRewardPoints();

        $points_total = 0;

        foreach ($this->cart->getProducts() as $product) {
            if ($product['points']) {
                $points_total += $product['points'];
            }
        }

        if ($points && $points_total && $this->config->get('reward_status')) {

            $data = array_merge(isset($data) ? $data : array(), $this->load->language('total/reward'));

            $data['heading_title'] = sprintf($this->language->get('heading_title'), $points);

            $data['entry_reward'] = sprintf($this->language->get('entry_reward'), $points_total);
            $data['max_points'] = $points_total;

            if (isset($this->session->data['reward'])) {
                $data['reward'] = $this->session->data['reward'];
            } else {
                $data['reward'] = '';
            }

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/total/reward.tpl')) {
                return $this->load->view($this->config->get('config_template') . '/template/total/reward.tpl', $data);
            } else {
                return $this->load->view('default/template/total/reward.tpl', $data);
            }
        }
    }

    public function reward() {

        $data = array_merge(isset($data) ? $data : array(), $this->load->language('total/reward'));

        $json = array();

        $points = $this->customer->getRewardPoints();

        $points_total = 0;

        foreach ($this->cart->getProducts() as $product) {
            if ($product['points']) {
                $points_total += $product['points'];
            }
        }

        if (empty($this->request->post['reward'])) {
            $json['error'] = $this->language->get('error_reward');
        }

        if ($this->request->post['reward'] > $points) {
            $json['error'] = sprintf($this->language->get('error_points'), $this->request->post['reward']);
        }

        if ($this->request->post['reward'] > $points_total) {
            $json['error'] = sprintf($this->language->get('error_maximum'), $points_total);
        }

        if (!$json) {
            $this->session->data['reward'] = abs($this->request->post['reward']);

            $json['success'] = $this->language->get('text_success');

            $this->load->model('checkout/total');
            $json['totals'] = $this->model_checkout_total->getTotalsHtml();
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
}
