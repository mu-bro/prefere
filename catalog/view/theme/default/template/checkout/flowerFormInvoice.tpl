<div class="delInfo" >
    <h2><?php echo $title_deliver_info; ?></h2>
    <div class="row">
        <div class="col-lg-6">
            <div >
                <h3><?php echo $text_customer; ?></h3>

                <div class="infoText"><?php echo $order_info['firstname']; ?></div>
                <div class="infoText"><?php echo $order_info['email']; ?></div>
                <div class="infoText"><?php echo $order_info['telephone']; ?></div>
            </div>
            <?php if ($delInfo['deliverer'] == "ELSE") { ?>
                <h3><?php echo $text_deliver; ?></h3>
                <div class="infoText"><?php echo $delInfo['deliver']['name']; ?></div>
                <div class="infoText"><?php echo $delInfo['deliver']['phone']; ?></div>
                <?php if (isset($delInfo['deliver']['surprize']) && $delInfo['deliver']['surprize'] == "Y") { ?>
                    <div class="infoText"><?php echo $text_it_is_suprize; ?></div>
                <?php } ?>
            <?php } ?>
        </div>
        <div class="col-lg-6 shippingInfoBlock">
            <h3><?php echo $text_date_and_place_delivery; ?></h3>
            <?php if (isset($delInfo['shipping_method']['info']['city'])) { ?>
                <div class="infoText"><b><?php echo $text_city; ?>:</b> <?php echo $delInfo['shipping_method']['info']['city']; ?></div>
            <?php } ?>
            <?php if (isset($delInfo['shipping_method']['info']['address'])) { ?>
                <div class="infoText"><b><?php echo $text_addres; ?>:</b> <?php echo $delInfo['shipping_method']['info']['address']; ?></div>
            <?php } ?>
            <div class="infoText"><b><?php echo $delivery_date; ?>:</b> <?php echo $delInfo['shipping_method']['info']['date']; ?></div>
            <?php if ($delInfo['shipping_method']['code'] != 'flat.flat') { ?>
                <div class="infoText"><b><?php echo $delivery_time; ?>:</b> <?php echo $delInfo['shipping_method']['info']['time']; ?></div>
            <?php } ?>

            <h3><?php echo $text_shipping_method; ?></h3>
            <div class="infoText"><?php echo $delInfo['shipping_method']['name']; ?> ( <?php echo $delInfo['shipping_method']['costText']; ?> )</div>
        </div>
    </div>
</div>
