<?php 
class ModelPaymentPayanywayNovoplat extends Model {
  	public function getMethod($address, $total) {
        $this->load->language('payment/payanyway_novoplat');

        $method_data = array(
            'code'       => 'payanyway_novoplat',
            'title'      => $this->language->get('text_title'),
            'terms'      => '',
            'sort_order' => $this->config->get('payanyway_sort_order')
        );
   
    	return $method_data;
  	}
}
?>