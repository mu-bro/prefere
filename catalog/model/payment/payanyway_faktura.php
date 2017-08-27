<?php 
class ModelPaymentPayanywayFaktura extends Model {
  	public function getMethod($address, $total) {
        $this->load->language('payment/payanyway_faktura');

        $method_data = array(
            'code'       => 'payanyway_faktura',
            'title'      => $this->language->get('text_title'),
            'terms'      => '',
            'sort_order' => $this->config->get('payanyway_faktura_sort_order')
        );
   
    	return $method_data;
  	}
}
?>