<?php 
class ModelPaymentPayanywayPcard extends Model {
  	public function getMethod($address, $total) {
        $this->load->language('payment/payanyway_pcard');

        $method_data = array(
            'code'       => 'payanyway_pcard',
            'title'      => $this->language->get('text_title'),
            'terms'      => '',
            'sort_order' => $this->config->get('payanyway_pcard_sort_order')
        );
   
    	return $method_data;
  	}
}
?>