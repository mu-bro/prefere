<?php 
class ModelPaymentPayanywayPLT extends Model {
  	public function getMethod($address, $total) {
        $this->load->language('payment/payanyway_plt');

        $method_data = array(
            'code'       => 'payanyway_plt',
            'title'      => $this->language->get('text_title'),
            'terms'      => '',
            'sort_order' => $this->config->get('payanyway_plt_sort_order')
        );
   
    	return $method_data;
  	}
}
?>