<?php 
class ModelPaymentPayanywayQiwi extends Model {
  	public function getMethod($address, $total) {
        $this->load->language('payment/payanyway_qiwi');

        $method_data = array(
            'code'       => 'payanyway_qiwi',
            'title'      => $this->language->get('text_title'),
            'terms'      => '',
            'sort_order' => $this->config->get('payanyway_qiwi_sort_order')
        );
   
    	return $method_data;
  	}
}
?>