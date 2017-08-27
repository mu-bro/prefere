<?php
class ModelPaymentGoPay extends Model {
  	public function getMethod($address, $total) {
		$this->load->language('payment/gopay');

		$gopay = $this->config->get('gopay');

		$status = true;;

		$store_id = $this->config->get('config_store_id');

		if (empty($gopay[$store_id]) || !empty($gopay[$store_id]['default']['restriction'])) {
			if ($total < (float)$gopay['default']['total']) {
				$status = false;
			}

			$geo_zone_id = $gopay['default']['geo_zone_id'];
			$display = (empty($gopay['default']['display']) ? false : true);
			$test = (empty($gopay['default']['test']) ? false : true);
		} else {
			if ($total < (float)$gopay[$store_id]['total']) {
				$status = false;
			}

			$geo_zone_id = $gopay[$store_id]['geo_zone_id'];
			$display = (empty($gopay[$store_id]['display']) ? false : true);
			$test = (empty($gopay[$store_id]['test']) ? false : true);
		}

		if ($status && $geo_zone_id) {
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone_to_geo_zone WHERE geo_zone_id = '" . (int)$geo_zone_id . "' AND country_id = '" . (int)$address['country_id'] . "' AND (zone_id = '" . (int)$address['zone_id'] . "' OR zone_id = '0')");

			if (!$query->num_rows) {
				$status = false;
			}
		}

		$method_data = array();

		if ($status) {
			if (empty($gopay[$store_id]) || !empty($gopay[$store_id]['default']['method'])) {
				$methods = $gopay['default']['method'];
			} else {
				$methods = $gopay[$store_id]['method'];
			}

			if ($display && $methods) {
				$quotes = array();

				foreach ($methods as $method_code => $method) {
					if (!empty($method['disabled'])) continue;

					if (!empty($method['min']) && (float)$method['min'] > $total) continue;

					if (!empty($method['max']) && (float)$method['max'] < $total) continue;

					$title = (empty($method['title'][$this->config->get('config_language_id')]) ? $method['title_orig'] : $method['title'][$this->config->get('config_language_id')]);

					if ($test) {
						$title .= $this->language->get('text_test');
					}

					if (!empty($method['image']) && file_exists(DIR_IMAGE . $method['image'])) {
						$image = HTTPS_SERVER . 'image/' . $method['image'];
					} else {
						$image = $gopay['default']['method'][$method_code]['image_orig'];
					}

					$quotes[$method_code] = array(
						'code'       => 'gopay.' . $method_code,
						'title'      => $title,
						'image'      => $image,
						'sort_order' => $method['sort_order'],
						'cost_percent' => (isset($method['cost']) ? $method['cost'] : 0),
					);
				}

				$sort_order = array();

				foreach ($quotes as $key => $value) {
					$sort_order[$key] = $value['sort_order'];
				}

				array_multisort($sort_order, SORT_ASC, $quotes);

				$method_data = array(
					'code'       => 'gopay',
					'title'      => $this->language->get('text_title'),
					'quote'      => $quotes,
					'terms'      => '',
					'sort_order' => $this->config->get('gopay_sort_order')
				);
			} else {
				$method_data = array(
					'code'       => 'gopay',
					'title'      => $this->language->get('text_title') . ($test ? $this->language->get('text_test') : ''),
					'terms'      => '',
					'sort_order' => $this->config->get('gopay_sort_order')
				);
			}
    	}

    	return $method_data;
  	}
}
?>