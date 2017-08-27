<?php 
class ModelPaymentPayanywayPPay extends Model {
  	public function getMethod($address, $total) {
        $this->load->language('payment/payanyway_ppay');

        $method_data = array(
            'code'       => 'payanyway_ppay',
            'title'      => $this->language->get('text_title'),
            'terms'      => '',
            'sort_order' => $this->config->get('payanyway_ppay_sort_order')
        );
   
    	return $method_data;
  	}
}
?>