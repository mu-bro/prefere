<?php 
class ModelPaymentPayanywayENet extends Model {
  	public function getMethod($address, $total) {
        $this->load->language('payment/payanyway_enet');

        $method_data = array(
            'code'       => 'payanyway_enet',
            'title'      => $this->language->get('text_title'),
            'terms'      => '',
            'sort_order' => $this->config->get('payanyway_enet_sort_order')
        );
   
    	return $method_data;
  	}
}
?>