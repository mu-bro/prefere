<?php 
class ModelPaymentPayanywayDengimail extends Model {
  	public function getMethod($address, $total) {
        $this->load->language('payment/payanyway_dengimail');

        $method_data = array(
            'code'       => 'payanyway_dengimail',
            'title'      => $this->language->get('text_title'),
            'terms'      => '',
            'sort_order' => $this->config->get('payanyway_dengimail_sort_order')
        );
   
    	return $method_data;
  	}
}
?>