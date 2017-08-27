<?php 
class ModelPaymentPayanywayFM extends Model {
  	public function getMethod($address, $total) {
        $this->load->language('payment/payanyway_fm');

        $method_data = array(
            'code'       => 'payanyway_fm',
            'title'      => $this->language->get('text_title'),
            'terms'      => '',
            'sort_order' => $this->config->get('payanyway_fm_sort_order')
        );
   
    	return $method_data;
  	}
}
?>