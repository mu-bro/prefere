<?php
define('DOMAIN', 'localhost/prefere_alena'); // указать свой домен без http:// и слеша в конце
define('DIR_ROOT', str_replace('\\', '/', realpath('..')) . '/');
define('CURRENT_AREA', 'C');

// HTTP
define('HTTP_SERVER', 'http://' . DOMAIN . '/');

// HTTPS
define('HTTPS_SERVER', 'http://' . DOMAIN . '/');

// DIR
define('DIR_APPLICATION', DIR_ROOT . 'catalog/');
define('DIR_SYSTEM', DIR_ROOT . 'system/');
define('DIR_LANGUAGE', DIR_ROOT . 'catalog/language/');
define('DIR_TEMPLATE', DIR_ROOT . 'catalog/view/theme/');
define('DIR_CONFIG', DIR_ROOT . 'system/config/');
define('DIR_IMAGE', DIR_ROOT . 'image/');
define('DIR_CACHE', DIR_ROOT . 'system/storage/cache/');
define('DIR_DOWNLOAD', DIR_ROOT . 'system/storage/download/');
define('DIR_LOGS', DIR_ROOT . 'system/storage/logs/');
define('DIR_MODIFICATION', DIR_ROOT . 'system/storage/modification/');
define('DIR_UPLOAD', DIR_ROOT . 'system/storage/upload/');

require(DIR_ROOT . 'dbconfig.php');