<?php
class ModelCheckoutCart extends Model {

	public function cartValidation($cartInfo) {
		$error = array();
		$customer = $cartInfo["customer"];

		if (empty($customer['name'])) {
			$error['customer']['name'] = $this->language->get('error_customer_name');
		} elseif (utf8_strlen($customer['name']) < 2 || utf8_strlen($customer['name']) > 32) {
			$error['customer']['name'] = $this->language->get('error_name_length');
		}
		if (empty($customer['email'])) {
			$error['customer']['email'] = $this->language->get('error_customer_email');
		} elseif ((utf8_strlen($customer['email']) > 96) || !preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $customer['email'])) {
			$error['customer']['email'] = $this->language->get('error_email_valid');
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

		$delInfo = $cartInfo["delInfo"];
//p($this->cart->getProducts(),$delInfo);
		foreach ($this->cart->getProducts() as $key => $product) {
			$cartKey = $product['cart_id'];
			if (!isset($delInfo[$cartKey])) {
				$error['fatal'] = true;
			} else {
				$cartInfo = $delInfo[$cartKey];
				if (utf8_strlen($cartInfo['message']) > 250) {
					$error['products'][$cartKey]['message'] = $this->language->get('error_message_length');
				}

				if (empty($cartInfo['deliverer'])) {
					$error['products'][$cartKey]['deliverer'] = $this->language->get('error_deliverer');
				} elseif ($cartInfo['deliverer'] == "ELSE") {

					if (empty($cartInfo['deliver']['name'])) {
						$error['products'][$cartKey]['deliver']['name'] = $this->language->get('error_deliver_name');
					} elseif ((utf8_strlen($cartInfo['deliver']['name']) > 96) || utf8_strlen($cartInfo['deliver']['name']) < 2) {
						$error['products'][$cartKey]['deliver']['name'] = $this->language->get('error_name_length');
					}

					if (empty($cartInfo['deliver']['phone'])) {
						$error['products'][$cartKey]['deliver']['phone'] = $this->language->get('error_deliver_phone');
					}
				}
				if (empty($cartInfo['shipping_method']['code'])) {
					$error['products'][$cartKey]['shipping_method']['code'] = $this->language->get('error_shipping_method');
				} else {
					$codeName = str_replace(".", "_", $cartInfo['shipping_method']['code']);
					$shipInfo = $cartInfo['shipping_method'][$codeName];
					if ($codeName != "pickup_pickup") {
						if ($codeName != "citylink_citylink") {
							if (empty($shipInfo['city'])) {
								$error['products'][$cartKey]['shipping_method']['addr']['city'] = $this->language->get('error_city');
							}
						}
						if (empty($shipInfo['address'])) {
							$error['products'][$cartKey]['shipping_method']['addr']['address'] = $this->language->get('error_address');
						}
					}
					if (empty($shipInfo['date'])) {
						$error['products'][$cartKey]['shipping_method']['addr']['date'] = $this->language->get('error_date');
					}
					if (empty($shipInfo['time'])) {
						$error['products'][$cartKey]['shipping_method']['addr']['time'] = $this->language->get('error_time');
					}
					if (isset($error['products'][$cartKey]['shipping_method']['addr'])) {
						$error['products'][$cartKey]['shipping_method']['codeValue'] = $codeName;
					}


					//p($info);
				}

			}
		}

		//p($error, $delInfo);

		return $error;
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
