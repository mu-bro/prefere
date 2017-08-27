<?php 
class ModelPaymentPayanywayBanktransfer extends Model {
  	public function getMethod($address, $total) {
        $this->load->language('payment/payanyway_banktransfer');

        $method_data = array(
            'code'       => 'payanyway_banktransfer',
            'title'      => $this->language->get('text_title'),
            'terms'      => '',
            'sort_order' => $this->config->get('payanyway_banktransfer_sort_order')
        );
   
    	return $method_data;
  	}
}
?>