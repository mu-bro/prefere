<?php 
class ModelPaymentPayanywaySberbank extends Model {
  	public function getMethod($address, $total) {
        $this->load->language('payment/payanyway_sberbank');

        $method_data = array(
            'code'       => 'payanyway_sberbank',
            'title'      => $this->language->get('text_title'),
            'terms'      => '',
            'sort_order' => $this->config->get('payanyway_sberbank_sort_order')
        );
   
    	return $method_data;
  	}
}
?>