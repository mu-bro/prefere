<?php 
class ModelPaymentPayanywayCP extends Model {
  	public function getMethod($address, $total) {
        $this->load->language('payment/payanyway_cp');

        $method_data = array(
            'code'       => 'payanyway_cp',
            'title'      => $this->language->get('text_title'),
            'terms'      => '',
            'sort_order' => $this->config->get('payanyway_cp_sort_order')
        );
   
    	return $method_data;
  	}
}
?>