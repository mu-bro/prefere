<?php
class ModelModuleSeoKeyword extends Model {
	public function install() {

		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "seo_keyword;");
		$this->db->query("
		CREATE TABLE " . DB_PREFIX . "seo_keyword ( `keyword_id` int(11) NOT NULL AUTO_INCREMENT,
			`url_alias_id` INT NOT NULL,
			PRIMARY KEY (`keyword_id`),
			KEY `url_alias_id` (`url_alias_id`)) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;");

		$start_array = array(
			array('query' => 'affiliate/account', 'keyword' => 'affiliates'),
			array('query' => 'affiliate/login', 'keyword' => 'affiliate-login'),
			array('query' => 'affiliate/register', 'keyword' => 'create-affiliate-account'),
			array('query' => 'affiliate/forgotten', 'keyword' => 'affiliate-forgot-password'),
			array('query' => 'account/reward', 'keyword' => 'reward-points'),
			array('query' => 'account/address', 'keyword' => 'address-book'),
			array('query' => 'account/recurring', 'keyword' => 'recurring'),
			array('query' => 'account/register', 'keyword' => 'create-account'),
			array('query' => 'account/transaction', 'keyword' => 'transactions'),
			array('query' => 'account/return', 'keyword' => 'returns'),
			array('query' => 'account/download', 'keyword' => 'downloads'),
			array('query' => 'account/forgotten', 'keyword' => 'forgot-password'),
			array('query' => 'account/return/add', 'keyword' => 'return-add'),
			array('query' => 'account/newsletter', 'keyword' => 'newsletter'),
			array('query' => 'account/order', 'keyword' => 'order-history'),
			array('query' => 'account/account', 'keyword' => 'my-account'),
			array('query' => 'account/wishlist', 'keyword' => 'wishlist'),
			array('query' => 'account/voucher', 'keyword' => 'vouchers'),
			array('query' => 'account/logout', 'keyword' => 'logout'),
			array('query' => 'account/login', 'keyword' => 'login'),
			array('query' => 'checkout/checkout', 'keyword' => 'checkout'),
			array('query' => 'checkout/voucher', 'keyword' => 'voucher'),
			array('query' => 'checkout/success', 'keyword' => 'success'),
			array('query' => 'checkout/cart', 'keyword' => 'cart'),
			array('query' => 'product/search', 'keyword' => 'search'),
			array('query' => 'product/compare', 'keyword' => 'compare-products'),
			array('query' => 'product/manufacturer', 'keyword' => 'brands'),
			array('query' => 'product/special', 'keyword' => 'specials'),
			array('query' => 'information/sitemap', 'keyword' => 'sitemap'),
			array('query' => 'information/contact', 'keyword' => 'contact-us'),
			array('query' => 'common/home', 'keyword' => ''),
		);

		foreach($start_array as $item){

			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias (query, keyword) SELECT * FROM (SELECT '" . $this->db->escape($item['query']) . "', '" . $this->db->escape($item['keyword']) . "') AS tmp
				WHERE NOT EXISTS ( SELECT query, keyword FROM " . DB_PREFIX . "url_alias WHERE query = '" . $this->db->escape($item['query']) . "' OR keyword = '" . $this->db->escape($item['keyword']) . "') LIMIT 1");

			$last_id = $this->db->getLastId();
			if($last_id){
				$this->db->query("INSERT INTO `" . DB_PREFIX . "seo_keyword` SET `url_alias_id` = " . (int)$last_id);
			}
		}
	}

	public function uninstall() {

		$this->db->query("DELETE FROM `" . DB_PREFIX . "url_alias` WHERE url_alias_id IN (SELECT url_alias_id FROM `" . DB_PREFIX . "seo_keyword`)");

		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "seo_keyword;");

		$this->db->query("UPDATE `" . DB_PREFIX . "modification` SET status=0 WHERE `name` LIKE'%SEO Keyword%'");
		$modifications = $this->load->controller('extension/modification/refresh');
	}

	protected function curl_get_contents($url) {
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_HEADER, 0);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		$output = curl_exec($ch);
		curl_close($ch);
		return $output;
	}

	public function getNotifications($version) {
		$language_code = $this->config->get( 'config_admin_language' );
		$result = $this->curl_get_contents("http://vanstudio.co.ua/index.php?route=information/message&type=module_seo_keyword_lite&version=$version&language_code=$language_code");

		if (stripos($result,'<html') !== false) {
			return '';
		}
		return $result;
	}
}