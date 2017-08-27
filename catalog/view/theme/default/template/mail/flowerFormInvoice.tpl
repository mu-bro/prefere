<table style="width:100%;">
    <tr>
        <td colspan="2">
            <h2 style="font-size: 16px; text-align:center;color: #000; margin: 0px; padding: 0px; text-transform: uppercase;font-weight:normal;"><?php echo $title_deliver_info; ?></h2>
        </td>
    </tr>
    <tr>
        <td style="width:50%;vertical-align:top;">
            <div>
                <h3 style="font-size: 13px; text-align:left;color: #000; margin: 0px; padding: 0px; text-transform: uppercase;font-weight:normal;margin-top:4px;"><?php echo $text_customer; ?></h3>

                <div class="infoText"><?php echo $order_info['firstname']; ?></div>
                <div class="infoText">
                    <a href="mailto:<?php echo $order_info['email']; ?>" style="color: #666;text-decoration:none;">
                        <?php echo $order_info['email']; ?>
                    </a>
                </div>
                <div class="infoText"><?php echo $order_info['telephone']; ?></div>
            </div>
            <?php if ($delInfo['deliverer'] == "ELSE") { ?>
                <h3 style="font-size: 13px; text-align:left;color: #000; margin: 0px; padding: 0px; text-transform: uppercase;font-weight:normal;margin-top:10px;"><?php echo $text_deliver; ?></h3>
                <div class="infoText"><?php echo $delInfo['deliver']['name']; ?></div>
                <div class="infoText"><?php echo $delInfo['deliver']['phone']; ?></div>
                <?php if (isset($delInfo['deliver']['surprize']) && $delInfo['deliver']['surprize'] == "Y") { ?>
                    <div class="infoText"><?php echo $text_it_is_suprize; ?></div>
                <?php } ?>
            <?php } ?>
        </td>
        <td style="width:50%;vertical-align:top;">
            <h3 style="font-size: 13px; text-align:left;color: #000; margin: 0px; padding: 0px; text-transform: uppercase;font-weight:normal;margin-top:4px;"><?php echo $text_date_and_place_delivery; ?></h3>
            <?php if (isset($delInfo['shipping_method']['info']['city'])) { ?>
                <div class="infoText">
                    <span style="color:#000;"><?php echo $text_city; ?>:</span>
                    <?php echo $delInfo['shipping_method']['info']['city']; ?>
                </div>
            <?php } ?>
            <?php if (isset($delInfo['shipping_method']['info']['address'])) { ?>
                <div class="infoText">
                    <span style="color:#000;"><?php echo $text_addres; ?>:</span>
                    <?php echo $delInfo['shipping_method']['info']['address']; ?>
                </div>
            <?php } ?>
            <div class="infoText">
                <span style="color:#000;"><?php echo $delivery_date; ?>:</span>
                <?php echo $delInfo['shipping_method']['info']['date']; ?>
            </div>
            <?php if ($delInfo['shipping_method']['code'] != 'flat.flat') { ?>
                <div class="infoText">
                    <span style="color:#000;"><?php echo $delivery_time; ?>:</span>
                    <?php echo $delInfo['shipping_method']['info']['time']; ?>
                </div>
            <?php } ?>
            <h3 style="font-size: 13px; text-align:left;color: #000; margin: 0px; padding: 0px; text-transform: uppercase;font-weight:normal;margin-top:10px;"><?php echo $text_shipping_method; ?></h3>

            <div class="infoText"><?php echo $delInfo['shipping_method']['name']; ?>
                ( <?php echo $delInfo['shipping_method']['costText']; ?> )
            </div>
        </td>

    </tr>
</table>

