<?php 
class ModelPaymentPayanywayContact extends Model {
  	public function getMethod($address, $total) {
        $this->load->language('payment/payanyway_contact');

        $method_data = array(
            'code'       => 'payanyway_contact',
            'title'      => $this->language->get('text_title'),
            'terms'      => '',
            'sort_order' => $this->config->get('payanyway_contact_sort_order')
        );
   
    	return $method_data;
  	}
}
?>