<?php 
class ModelPaymentPayanywayYM extends Model {
  	public function getMethod($address, $total) {
        $this->load->language('payment/payanyway_ym');

        $method_data = array(
            'code'       => 'payanyway_ym',
            'title'      => $this->language->get('text_title'),
            'terms'      => '',
            'sort_order' => $this->config->get('payanyway_ym_sort_order')
        );
   
    	return $method_data;
  	}
}
?>