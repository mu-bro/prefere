<?php
class ControllerTotalCoupon extends Controller {
	public function index() {
		if ($this->config->get('coupon_status')) {

$data = array_merge( isset($data) ? $data : array() , $this->load->language('total/coupon'));

			if (isset($this->session->data['coupon'])) {
				$data['coupon'] = $this->session->data['coupon'];
			} else {
				$data['coupon'] = '';
			}

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/total/coupon.tpl')) {
				return $this->load->view($this->config->get('config_template') . '/template/total/coupon.tpl', $data);
			} else {
				return $this->load->view('default/template/total/coupon.tpl', $data);
			}
		}
	}

	public function coupon() {        
		$data = array_merge( isset($data) ? $data : array() , $this->load->language('total/coupon'));

		$json = array();

		$this->load->model('total/coupon');

		if (isset($this->request->post['coupon'])) {
			$coupon = $this->request->post['coupon'];
		} else {
			$coupon = '';
		}

		$coupon_info = $this->model_total_coupon->getCoupon($coupon);

		if (empty($this->request->post['coupon'])) {
			$json['error'] = $this->language->get('error_empty');

			unset($this->session->data['coupon']);
		} elseif ($coupon_info) {
			$this->session->data['coupon'] = $this->request->post['coupon'];

			$json['success'] = $this->language->get('text_success');

			list($totals,$total) = $this->getTotals();
			$total_text = '<tr><td class="text-right">%s:</td><td class="text-right total">%s</td></tr>';
			$json['totals'] = '';
			foreach ($totals as $total_item) {
			    $json['totals'] .= sprintf($total_text, $total_item['title'],$total_item['text']);
			}
		} else {
			$json['error'] = $this->language->get('error_coupon');
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
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
}
