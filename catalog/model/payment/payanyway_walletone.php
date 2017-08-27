<?php 
class ModelPaymentPayanywayWalletone extends Model {
  	public function getMethod($address, $total) {
        $this->load->language('payment/payanyway_walletone');

        $method_data = array(
            'code'       => 'payanyway_walletone',
            'title'      => $this->language->get('text_title'),
            'terms'      => '',
            'sort_order' => $this->config->get('payanyway_walletone_sort_order')
        );
   
    	return $method_data;
  	}
}
?>