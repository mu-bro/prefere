<?php
class ControllerPaymentPayanywayEuroset extends Controller {
	public function index() {
		$this->load->language('payment/payanyway_euroset');
		
    	$data['button_confirm'] = $this->language->get('button_confirm');

		$data['continue'] = $this->url->link('checkout/success');

		$this->load->model('checkout/order');
		$order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);

        $mnt_id = $this->config->get('payanyway_mnt_id');
        $order_id = $this->session->data['order_id'];
        $currency = $this->config->get('payanyway_mnt_currency_code');
        $mnt_test_mode = $this->config->get('payanyway_mnt_test_mode');
        $mnt_dataintegrity_code = $this->config->get('payanyway_mnt_dataintegrity_code');
		
        $amount = $this->currency->format($order_info['total'], $currency, '', false);
		$amount = number_format($amount, 2, '.', '');
        $signature = md5("{$mnt_id}{$order_id}{$amount}{$currency}{$mnt_test_mode}{$mnt_dataintegrity_code}");

		$data['action'] = $this->url->link('payment/payanyway/invoice');
		$data['mnt_id'] = $mnt_id;
		$data['order_id'] = $order_id;
		$data['currency'] = $currency;
		$data['amount'] = $amount;
		$data['mnt_signature'] = $signature;
		$data['mnt_test_mode'] = $mnt_test_mode;
		$data['paymentSystemUnitId'] = 248362;
		$data['paymentSystemAccountId'] = 136;
		$data['mnt_success_url'] = $this->url->link('payment/payanyway/success');
		$data['mnt_fail_url'] = $this->url->link('checkout/checkout', '', 'SSL');

		$data['entry_additionalParameters'] = $this->language->get('entry_additionalParameters');
		$data['entry_rapidaPhone'] = $this->language->get('entry_rapidaPhone');
		$data['entry_rapidaPhoneHelp'] = $this->language->get('entry_rapidaPhoneHelp');
		$data['entry_rapidaPhoneError'] = $this->language->get('entry_rapidaPhoneError');


		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/payanyway_euroset.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/payment/payanyway_euroset.tpl', $data);
		} else {
			return $this->load->view('default/template/payment/payanyway_euroset.tpl', $data);
		}
	}
}
?>