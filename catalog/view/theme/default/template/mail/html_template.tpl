<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title><?php echo $title; ?></title>
</head>
<body id="emailBody" style="font-family: Arial, Helvetica, sans-serif; font-size: 12px; color: #666;">
<div style="width:680px;margin:0 auto;">
<table class="container">
    <tr class="row">
        <td class="col-sm-4" style="width:33%;">
            <div class="join_us">
                <div class="annabelle" style="font-size: 18px;text-align: center;font-style: italic;"><?php echo $text_join_us; ?></div>
                <div class="socLinks" style="margin-top: 2px;text-align: center;">
                    <?php foreach ($soc_icons as $soc => $link) { ?>
                        <div style="margin: 4px 2px; display: inline-block;">
                            <a href="<?php echo $link; ?>" target="_blank">
                                <img style="width: 24px;" src="<?php echo $store_url; ?>catalog/view/theme/default/image/<?php echo $soc; ?>.png"
                                     alt="<?php echo ${"title_soc_$soc"}; ?>"
                                     title="<?php echo ${"title_soc_$soc"}; ?>"/>
                            </a>
                        </div>
                    <?php } ?>
                </div>
            </div>
        </td>
        <td class="col-sm-4" style="width:33%;text-align:center;"">
            <div id="logo">
                <?php if ($logo) { ?>
                    <a href="<?php echo $store_url; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $store_name; ?>"
                                                             alt="<?php echo $store_name; ?>" class="img-responsive"/></a>
                <?php } else { ?>
                    <h1><a href="<?php echo $store_url; ?>"><?php echo $store_name; ?></a></h1>
                <?php } ?>
            </div>
        </td>
        <td style="text-align:right;width:33%;">
            <div class="headMenuBlock" >
                <div class="headMenu">
                    <a href="mailto:<?php echo
                    $config_email; ?>" style="color: #B89292;text-decoration:none;"><?php echo
                        $config_email; ?></a>
                </div>
                <div class="topPhone" style="border-top: 1px solid #7F7F7F;margin-top: 6px;">
                    <div class="phone" style="font-size: 22px;font-family: Georgia;padding-top: 6px;color: #000;"><?php echo $telephone; ?></div>
                    <div class="phoneInfo" style="font-size: 11px;padding-top: 4px;"><?php echo $text_call; ?></div>
                </div>
            </div>
        </td>
    </tr>


    <tr class="container">
        <td colspan="3">
            <div class="cartBlock checkout" style="border: 1px solid #6C6C6C;padding: 10px 15px;border-radius: 4px;margin-top:20px;">
                <?php echo $html; ?>
            </div>
        </td>
    </tr>


    <tr class="container">
        <td colspan="3">
            <div class="text-center" style="text-align:center;margin-top: 15px;padding-top: 15px;border-top: 1px solid #B7B7B7;">
                <p class="powered"><?php echo $powered; ?></p>
            </div>
        </td>
    </tr>
</table>
</div>
</body>
</html>
<style>

</style>



