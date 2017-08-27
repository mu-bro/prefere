<?php 
class ModelPaymentPayanywayComepay extends Model {
  	public function getMethod($address, $total) {
        $this->load->language('payment/payanyway_comepay');

        $method_data = array(
            'code'       => 'payanyway_comepay',
            'title'      => $this->language->get('text_title'),
            'terms'      => '',
            'sort_order' => $this->config->get('payanyway_comepay_sort_order')
        );
   
    	return $method_data;
  	}
}
?>