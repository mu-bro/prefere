<?php 
class ModelPaymentPayanywayWM extends Model {
  	public function getMethod($address, $total) {
        $this->load->language('payment/payanyway_wm');

        $method_data = array(
            'code'       => 'payanyway_wm',
            'title'      => $this->language->get('text_title'),
            'terms'      => '',
            'sort_order' => $this->config->get('payanyway_wm_sort_order')
        );
   
    	return $method_data;
  	}
}
?>