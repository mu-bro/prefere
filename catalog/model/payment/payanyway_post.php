<?php 
class ModelPaymentPayanywayPost extends Model {
  	public function getMethod($address, $total) {
        $this->load->language('payment/payanyway_post');

        $method_data = array(
            'code'       => 'payanyway_post',
            'title'      => $this->language->get('text_title'),
            'terms'      => '',
            'sort_order' => $this->config->get('payanyway_post_sort_order')
        );
   
    	return $method_data;
  	}
}
?>