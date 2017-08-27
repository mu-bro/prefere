<?php 
class ModelPaymentPayanywayEuroset extends Model {
  	public function getMethod($address, $total) {
        $this->load->language('payment/payanyway_euroset');

        $method_data = array(
            'code'       => 'payanyway_euroset',
            'title'      => $this->language->get('text_title'),
            'terms'      => '',
            'sort_order' => $this->config->get('payanyway_euroset_sort_order')
        );
   
    	return $method_data;
  	}
}
?>