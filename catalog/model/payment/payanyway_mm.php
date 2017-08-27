<?php 
class ModelPaymentPayanywayMM extends Model {
  	public function getMethod($address, $total) {
        $this->load->language('payment/payanyway_mm');

        $method_data = array(
            'code'       => 'payanyway_mm',
            'title'      => $this->language->get('text_title'),
            'terms'      => '',
            'sort_order' => $this->config->get('payanyway_mm_sort_order')
        );
   
    	return $method_data;
  	}
}
?>