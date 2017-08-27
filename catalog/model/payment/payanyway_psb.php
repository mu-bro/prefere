<?php 
class ModelPaymentPayanywayPsb extends Model {
  	public function getMethod($address, $total) {
        $this->load->language('payment/payanyway_psb');

        $method_data = array(
            'code'       => 'payanyway_psb',
            'title'      => $this->language->get('text_title'),
            'terms'      => '',
            'sort_order' => $this->config->get('payanyway_psb_sort_order')
        );
   
    	return $method_data;
  	}
}
?>