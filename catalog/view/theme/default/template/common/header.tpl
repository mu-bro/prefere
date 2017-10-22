<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]>-->
<html lang="<?php echo $lang; ?>">
<!--<![endif]-->
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><?php echo $title; ?></title>
    <base href="<?php echo $base; ?>"/>
    <?php if ($description) { ?>
        <meta name="description" content="<?php echo $description; ?>"/>
    <?php } ?>
    <?php if ($keywords) { ?>
        <meta name="keywords" content="<?php echo $keywords; ?>"/>
    <?php } ?>
    <script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
    <link href="catalog/view/javascript/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen"/>
    <script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <link href="catalog/view/javascript/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" type="text/css"
          href="catalog/view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css"/>
    <link href="catalog/view/theme/default/stylesheet/stylesheet.css" rel="stylesheet">

    <?php foreach ($styles as $style) { ?>
        <link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>"
              media="<?php echo $style['media']; ?>"/>
    <?php } ?>
    <script src="catalog/view/javascript/common.js" type="text/javascript"></script>
    <?php foreach ($links as $link) { ?>
        <link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>"/>
    <?php } ?>
    <?php foreach ($scripts as $script) { ?>
        <script src="<?php echo $script; ?>" type="text/javascript"></script>
    <?php } ?>
    <?php foreach ($analytics as $analytic) { ?>
        <?php echo $analytic; ?>
    <?php } ?>
    <?php if ($config_smartsupp_enabled) { ?>
        <script type="text/javascript">
            var _smartsupp = _smartsupp || {};
            _smartsupp.key = '<?php echo $config_smartsupp_key; ?>';
            _smartsupp.cookieDomain = ".<?php $smartsupp_host = parse_url($base); echo $smartsupp_host['host']; ?>";
            window.smartsupp || (function (d) {
                var o = smartsupp = function () {
                    o._.push(arguments)
                }, s = d.getElementsByTagName('script')[0], c = d.createElement('script');
                o._ = [];
                c.async = true;
                c.type = 'text/javascript';
                c.charset = 'utf-8';
                c.src = '//www.smartsuppchat.com/loader.js';
                s.parentNode.insertBefore(c, s);
            })(document);
        </script>
    <?php } ?>

</head>


<body class="<?php echo $class; ?>">
<?php echo $lng_editable; ?>
<div id="hidden_top" class="visible-sm visible-md visible-lg"></div>
<header>
    <div class="container">
        <div class="row">

            <div class="col-xs-5">
                <div class="top_informations row">
                    <div class="col-lg-12">
                        <?php foreach ($informations as $information) { ?>
                            <a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a>
                        <?php } ?>
                    </div>
                </div>
                <div class="left_information row">
                    <?php echo $language; ?>
                    <?php echo $currency; ?>
                </div>
                <div class="logo">
                    <?php if ($logo) { ?>
                        <a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>"
                                                            alt="<?php echo $name; ?>" class="img-responsive"/></a>
                    <?php } else { ?>
                        <h1><a href="<?php echo $home; ?>"><?php echo $name; ?></a></h1>
                    <?php } ?>
                </div>
            </div>
            <div class="col-xs-2 logoColumn">
                <div id="logo">
                    <?php if ($logo) { ?>
                        <a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>"
                                                            alt="<?php echo $name; ?>" class="img-responsive"/></a>
                    <?php } else { ?>
                        <h1><a href="<?php echo $home; ?>"><?php echo $name; ?></a></h1>
                    <?php } ?>
                </div>
            </div>
            <div class="col-xs-5 text-right thirdHeadColumn">
                <div class="socLinks">
                    <?php foreach ($soc_icons as $soc => $link) { ?>
                        <div>
                            <a href="<?php echo $link; ?>" target="_blank">
                                <img src="catalog/view/theme/default/image/<?php echo $soc; ?>.png"
                                     alt="<?php echo ${"title_soc_$soc"}; ?>"
                                     title="<?php echo ${"title_soc_$soc"}; ?>"/>
                            </a>
                        </div>
                    <?php } ?>
                </div>
                <div class="headMenuBlock row">
                    <div class="topPhone col-md-8 col-sm-12">
                        <div class="phone">
                            <span><?php echo $telephone_label; ?>:</span>
                            <?php echo $telephone; ?>
                        </div>
                        <?php if (!empty($telephone_2)) { ?>
                            <div class="phone">
                                <span><?php echo $telephone_label_2; ?>:</span>
                                <?php echo $telephone_2; ?>
                            </div>
                        <?php } ?>
                    </div>
                    <div class="headMenu col-md-4 col-sm-12">
                        <div class="right-float dropdown">
                            <?php if ($logged) { ?>
                                <span class="btn-link dropdown-toggle" data-toggle="dropdown">
                                    <img class="img-responsive" src="catalog/view/theme/default/image/login.png"
                                         alt="<?php echo $text_account; ?>"
                                         title="<?php echo $text_account; ?>" data-toggle="tooltip"/>
                                </span>
                                <ul class="dropdown-menu pull-right">
                                    <li><a href="<?php echo $account_edit; ?>"><?php echo $text_account; ?></a></li>
                                    <li><a href="<?php echo $account_order; ?>"><?php echo $text_order; ?></a></li>
                                    <li><a href="<?php echo $account_password; ?>"><?php echo $text_change_password; ?></a></li>
                                    <li><a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></li>
                                </ul>
                            <?php } else { ?>
                                <span class="quick_signup">
                                    <img src="catalog/view/theme/default/image/login.png"
                                         class="img-responsive"
                                         alt="<?php echo $text_account; ?>"
                                         title="<?php echo $text_account; ?>"/>
                                </span>
                            <?php } ?>

                            <span class="cartHolder" onclick="location = '<?php echo $shopping_cart; ?>'" title="<?php echo
                            $text_cart; ?>">
                                <img src="catalog/view/theme/default/image/cart.png"
                                     alt="<?php echo $text_cart; ?>" class="img-responsive"
                                     title="<?php echo $text_cart; ?>" data-toggle="tooltip"/>

                                <a href="<?php echo $shopping_cart; ?>" id="cart-total"><?php echo $cart_total; ?></a>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <?php echo $quicksignup; ?>

    <?php foreach ($modules as $module) { ?>
        <?php echo $module; ?>
    <?php } ?>


    <?php if ($showMiniCart) { ?>
        <div class="bbox right_cart <?php if ($product_count == 0) echo 'hidden'; ?> hidden-xs hidden-sm hidden-md">
            <div class="bbox_inner">
                <div class="title"><span onclick="location = 'index.php?route=checkout/cart';"><?php echo $text_cart; ?></span>
                </div>
                <div class="ccontent">
                    <div class="left">
                        <div class="ctitle"><?php echo $text_checkout; ?></div>
                    </div>
                    <div class="right">
                        <?php echo $rcart; ?>
                    </div>
                    <div class="clearing"></div>
                </div>
            </div>
        </div>
    <?php } ?>

    <div class="mainImage">
        <img src="catalog/view/theme/default/image/main_bg.png" />
    </div>
</header>

<div class="mainContent">