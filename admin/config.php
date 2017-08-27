<?php
define('DOMAIN', 'localhost/prefere'); // указать свой домен без http:// и слеша в конце
define('DIR_ROOT', str_replace('\\', '/', realpath('..')) . '/');
define('CURRENT_AREA', 'A');

// HTTP
define('HTTP_SERVER', 'http://' . DOMAIN . '/admin/');
define('HTTP_CATALOG', 'http://' . DOMAIN . '/');

// HTTPS
define('HTTPS_SERVER', 'http://' . DOMAIN . '/admin/');
define('HTTPS_CATALOG', 'http://' . DOMAIN . '/');

// DIR
define('DIR_APPLICATION', DIR_ROOT . 'admin/');
define('DIR_SYSTEM', DIR_ROOT . 'system/');
define('DIR_LANGUAGE', DIR_ROOT . 'admin/language/');
define('DIR_TEMPLATE', DIR_ROOT . 'admin/view/template/');
define('DIR_CONFIG', DIR_ROOT . 'system/config/');
define('DIR_IMAGE', DIR_ROOT . 'image/');
define('DIR_CACHE', DIR_ROOT . 'system/storage/cache/');
define('DIR_DOWNLOAD', DIR_ROOT . 'system/storage/download/');
define('DIR_LOGS', DIR_ROOT . 'system/storage/logs/');
define('DIR_MODIFICATION', DIR_ROOT . 'system/storage/modification/');
define('DIR_UPLOAD', DIR_ROOT . 'system/storage/upload/');
define('DIR_CATALOG', DIR_ROOT . 'catalog/');

// DB
require(DIR_ROOT . 'dbconfig.php');