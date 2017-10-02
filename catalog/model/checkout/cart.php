<?php
class ModelCheckoutCart extends Model {

	public function cartValidation($cartInfo) {
		$error = array();
		$delInfo = $cartInfo["delInfo"];

		$this->validateCustomer($cartInfo, $error);
		$this->validateMessage($delInfo, $error);
		$this->validateDeliverer($delInfo, $error);
		$this->validateShippingMethod($delInfo, $error);
		$this->validateCompany($delInfo, $error);
//p($error,$cartInfo);
//p($this->cart->getProducts(),$delInfo);

		return $error;
	}
	private function validateMessage($cartInfo, &$error) {
		if (utf8_strlen($cartInfo['message']) > 250) {
			$error['products']['message'] = $this->language->get('error_message_length');
		}
	}
	private function validateCustomer($cartInfo, &$error) {
		$customer = $cartInfo["customer"];

		if (empty($customer['name'])) {
			$error['customer']['name'] = $this->language->get('error_customer_name');
		} elseif (utf8_strlen($customer['name']) < 2 || utf8_strlen($customer['name']) > 32) {
			$error['customer']['name'] = $this->language->get('error_name_length');
		}
		if (empty($customer['email'])) {
			$error['customer']['email'] = $this->language->get('error_customer_email');
		} elseif ((utf8_strlen($customer['email']) > 96) || !preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $customer['email'])) {
			$error['customer']['email'] = $this->language->get('error_email_validd');
		}
		if (empty($customer['phone'])) {
			$error['customer']['phone'] = $this->language->get('error_customer_phone');
		}
		if (isset($customer['createAccount']) && !$this->customer->isLogged()) {
			if (empty($customer['password'])) {
				$error['customer']['password'] = $this->language->get('error_customer_password');
			} elseif (utf8_strlen($customer['password']) < 5 || utf8_strlen($customer['password']) > 32) {
				$error['customer']['password'] = $this->language->get('error_customer_password_length');
			}
			if ($customer['password'] != $customer['confirm_password']) {
				$error['customer']['confirm_password'] = $this->language->get('error_customer_confirm_password');
			}
			$this->load->model('account/customer');
			if (!isset($error['customer']['email']) && $this->model_account_customer->getTotalCustomersByEmail($customer['email'])) {
				$error['customer']['email'] = $this->language->get('error_email_exists');
			}
		}
	}

	private function validateDeliverer($cartInfo, &$error) {
		if (empty($cartInfo['deliverer'])) {
			$error['delInfo']['deliverer'] = $this->language->get('error_deliverer');
		} elseif ($cartInfo['deliverer'] == "ELSE") {

			if (empty($cartInfo['deliver']['name'])) {
				$error['delInfo']['deliver']['name'] = $this->language->get('error_deliver_name');
			} elseif ((utf8_strlen($cartInfo['deliver']['name']) > 96) || utf8_strlen($cartInfo['deliver']['name']) < 2) {
				$error['delInfo']['deliver']['name'] = $this->language->get('error_name_length');
			}

			if (empty($cartInfo['deliver']['phone'])) {
				$error['delInfo']['deliver']['phone'] = $this->language->get('error_deliver_phone');
			}
		}
	}

	private function validateCompany($delInfo, &$error) {
		if (!isset($delInfo["company"])) return;

		$company = $delInfo["company"];
		if (isset($company['is_company'])) {
			if (empty($company['name'])) {
				$error['delInfo']['company']['name'] = $this->language->get('error_company_name');
			}
			if (empty($company['inn'])) {
				$error['delInfo']['company']['inn'] = $this->language->get('error_company_inn');
			}
			if (empty($company['inn2'])) {
				$error['delInfo']['company']['inn2'] = $this->language->get('error_company_inn2');
			}
			if (empty($company['address'])) {
				$error['delInfo']['company']['address'] = $this->language->get('error_company_address');
			}
		}
	}

	private function validateShippingMethod($cartInfo, &$error) {
//		p($cartInfo);
		if (empty($cartInfo['shipping_method']['code'])) {
			$error['delInfo']['shipping_method']['code'] = $this->language->get('error_shipping_method');
		} else {
			$codeName = str_replace(".", "_", $cartInfo['shipping_method']['code']);
			$shipInfo = $cartInfo['shipping_method'][$codeName];
			if ($codeName != "pickup_pickup") {
				if ($codeName != "citylink_citylink") {
					if (empty($shipInfo['city'])) {
						$error['delInfo']['shipping_method']['addr']['city'] = $this->language->get('error_city');
					}
				}
				if (empty($shipInfo['address'])) {
					$error['delInfo']['shipping_method']['addr']['address'] = $this->language->get('error_address');
				}
			}
			if (empty($shipInfo['date'])) {
				$error['delInfo']['shipping_method']['addr']['date'] = $this->language->get('error_date');
			} elseif (!$this->document->isValidDeliverDate($shipInfo['date'])) {
				$error['delInfo']['shipping_method']['addr']['date'] = $this->language->get('error_unavail_date');
			}
			if (empty($shipInfo['time'])) {
				$error['delInfo']['shipping_method']['addr']['time'] = $this->language->get('error_time');
			}
			if (isset($error['delInfo']['shipping_method']['addr'])) {
				$error['delInfo']['shipping_method']['codeValue'] = $codeName;
			}
		}
	}

	public function getShippingMethods() {
		$this->language->load('checkout/checkout');

		$this->load->model('account/address');

		if ($this->customer->isLogged() && isset($this->session->data['shipping_address_id'])) {
			$shipping_address = $this->model_account_address->getAddress($this->session->data['shipping_address_id']);
		} elseif (isset($this->session->data['guest'])) {
			$shipping_address = $this->session->data['guest']['shipping'];
		}

		if (!isset($shipping_address['country_id'])) {
			$shipping_address['country_id'] = $this->config->get("config_country_id");
		}
		if (!isset($shipping_address['zone_id'])) {
			$shipping_address['zone_id'] = $this->config->get("config_zone_id");
		}

		if (!empty($shipping_address)) {
			// Shipping Methods
			$method_data = array();

			$this->load->model('extension/extension');

			$results = $this->model_extension_extension->getExtensions('shipping');

			foreach ($results as $result) {
				if ($this->config->get($result['code'] . '_status')) {
					$this->load->model('shipping/' . $result['code']);

					$quote = $this->{'model_shipping_' . $result['code']}->getQuote($shipping_address);

					if ($quote) {
						$shipping_code = $quote['quote'][$result['code']]['code'];
						$quote['quote'][$result['code']]['outOfCity'] = $this->document->isOutOfCityDelivery($shipping_code);

						$method_data[$result['code']] = array(
							'title' => $quote['title'],
							'quote' => $quote['quote'],
							'sort_order' => $quote['sort_order'],
							'error' => $quote['error']
						);
					}
				}
			}

			$sort_order = array();

			foreach ($method_data as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			}

			array_multisort($sort_order, SORT_ASC, $method_data);

			return $this->session->data['shipping_methods'] = $method_data;
		}
	}
}
