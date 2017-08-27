<?php 
class ModelPaymentPayanywayMKB extends Model {
  	public function getMethod($address, $total) {
        $this->load->language('payment/payanyway_mkb');

        $method_data = array(
            'code'       => 'payanyway_mkb',
            'title'      => $this->language->get('text_title'),
            'terms'      => '',
            'sort_order' => $this->config->get('payanyway_mkb_sort_order')
        );
   
    	return $method_data;
  	}
}
?>