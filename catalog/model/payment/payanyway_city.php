<?php 
class ModelPaymentPayanywayCity extends Model {
  	public function getMethod($address, $total) {
        $this->load->language('payment/payanyway_city');

        $method_data = array(
            'code'       => 'payanyway_city',
            'title'      => $this->language->get('text_title'),
            'terms'      => '',
            'sort_order' => $this->config->get('payanyway_city_sort_order')
        );
   
    	return $method_data;
  	}
}
?>