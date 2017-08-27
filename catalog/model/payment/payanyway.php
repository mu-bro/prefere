<?php 
class ModelPaymentPayanyway extends Model {
  	public function getMethod($address, $total) {
        $this->load->language('payment/payanyway');

        $method_data = array(
            'code'       => 'payanyway',
            'title'      => $this->language->get('text_title'),
            'terms'      => '',
            'sort_order' => $this->config->get('payanyway_sort_order')
        );
   
    	return $method_data;
  	}
}
?>