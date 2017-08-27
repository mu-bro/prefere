<?php
require_once('config.php');
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
require_once(DIR_SYSTEM . 'library/gopay/gopay_config.php');
require_once(DIR_SYSTEM . 'library/gopay/gopay_helper.php');
require_once(DIR_SYSTEM . 'library/gopay/gopay_soap.php');
require_once(DIR_SYSTEM . 'library/db.php');

function objectToArray( $object )
{
	if( !is_object( $object ) && !is_array( $object ) )
	{
		return $object;
	}
	if( is_object( $object ) )
	{
		$object = get_object_vars( $object );
	}
	return array_map( 'objectToArray', $object );
}

// Startup
require_once(DIR_SYSTEM . 'startup.php');

$db = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE, DB_PORT);

$query = $db->query("SELECT value FROM " . DB_PREFIX . "setting WHERE `key` = 'gopay'");

if (empty($query->row)) {
	header('Location: ' . HTTP_SERVER);
	exit;
}

$gopay = objectToArray(json_decode($query->row['value']));

$returnedPaymentSessionId = $_GET['paymentSessionId'];
$returnedGoId = $_GET['targetGoId'];
$returnedVariableSymbol = $_GET['orderNumber'];
$returnedEncryptedSignature = $_GET['encryptedSignature'];

$order = $db->query("SELECT * FROM `" . DB_PREFIX . "order` WHERE order_id = " . (int)$returnedVariableSymbol . " AND gopay_id = '" . $db->escape($returnedPaymentSessionId) . "'");

if (empty($order->row)) {
	header('Location: ' . HTTP_SERVER);
	exit;
}

if (empty($gopay[$order->row['store_id']]) || !empty($gopay[$order->row['store_id']]['default']['restriction'])) {
	$test = (!empty($gopay['default']['test']) ? true : false);
} else {
	$test = (!empty($gopay[$order->row['store_id']]['test']) ? true : false);
}

GopayConfig::init($test ? GopayConfig::TEST : GopayConfig::PROD);

$result = array(
	'order_id' => $order->row['order_id'],
	'redirect' => TRUE,
	'hash'     => uniqid()
);

if (empty($gopay[$order->row['store_id']]) || !empty($gopay[$order->row['store_id']]['default']['credential'])) {
	$goid = $gopay['default']['goid'];
	$secret = $gopay['default']['secret'];
} else {
	$goid = $gopay[$order->row['store_id']]['goid'];
	$secret = $gopay[$order->row['store_id']]['secret'];
}

$currency = $db->query("SELECT decimal_place FROM " . DB_PREFIX . "currency WHERE currency_id = " . (int)$order->row['currency_id']);

$decimal_place = ($currency->row ? $currency->row['decimal_place'] : 2);

try {
	GopayHelper::checkPaymentIdentity(
		(float)$returnedGoId,
		(float)$returnedPaymentSessionId,
		null,
		$returnedVariableSymbol,
		$returnedEncryptedSignature,
		$goid,
		$order->row['order_id'],
		$secret
	);

	$order_product = $db->query("SELECT name FROM " . DB_PREFIX . "order_product WHERE order_id = " . (int)$order->row['order_id'] . " LIMIT 1");

	if (!$order_product->row) {
		$order_product->row = array(
			'name' => 'Voucher',
		);
	}

	$gopay_result = GopaySoap::isPaymentDone(
		(float)$returnedPaymentSessionId,
		$goid,
		$order->row['order_id'],
		(int)(number_format(round($order->row['total'] * $order->row['currency_value'], (int)$decimal_place), (int)$decimal_place, '.', '') * 100),
		$order->row['currency_code'],
		$order_product->row['name'],
		$secret
	);

	if ($gopay_result['sessionState'] == GopayHelper::PAID) {
		$result['code'] = 1;
	} elseif (in_array($gopay_result['sessionState'], array(GopayHelper::PAYMENT_METHOD_CHOSEN, GopayHelper::AUTHORIZED))) {
		$result['code'] = 2;
	} else {
		$result['code'] = 0;
	}
} catch (Exception $e) {
	header('Location: ' . $order->row['store_url'] . 'index.php?route=error/gopay&error=' . GopayHelper::FAILED);
	exit;
}

$query = $db->query("SELECT value FROM " . DB_PREFIX . "setting WHERE `key` = 'config_encryption' AND store_id = 0");

require('../system/library/encryption.php');

$encryption = new Encryption($query->row['value']);

header('Location: ' . $order->row['store_url'] . 'index.php?route=payment/gopay/callback&hash=' . $result['hash'] . '&data=' . rawurlencode($encryption->encrypt(serialize($result))));
exit;