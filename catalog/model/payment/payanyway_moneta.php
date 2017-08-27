<?php 
class ModelPaymentPayanywayMoneta extends Model {
  	public function getMethod($address, $total) {
        $this->load->language('payment/payanyway_moneta');

        $method_data = array(
            'code'       => 'payanyway_moneta',
            'title'      => $this->language->get('text_title'),
            'terms'      => '',
            'sort_order' => $this->config->get('payanyway_moneta_sort_order')
        );
   
    	return $method_data;
  	}
}
?>