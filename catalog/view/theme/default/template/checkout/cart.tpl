<?php echo $header; ?>
<div class="container">
    <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
    </ul>
    <?php if ($attention) { ?>
        <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $attention; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
    <?php } ?>
    <?php if ($success) { ?>
        <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
    <?php } ?>
    <?php if ($error_warning) { ?>
        <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
    <?php } ?>
    <div class="row"><?php echo $column_left; ?>
        <?php if ($column_left && $column_right) { ?>
            <?php $class = 'col-sm-6'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
            <?php $class = 'col-sm-9'; ?>
        <?php } else { ?>
            <?php $class = 'col-sm-12'; ?>
        <?php } ?>
        <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
            <h1><?php echo $heading_title; ?>
                <?php if ($weight) { ?>
                    &nbsp;(<?php echo $weight; ?>)
                <?php } ?>
            </h1>

            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="cartForm">
                <div class="cartBlock checkout">
                    <?php foreach ($products as $k => $product) {
                        $key = $product["cart_id"];
                        $delInfo = $product["delInfo"];
                        ?>
                        <div class="row" id="cartProduct<?php echo $product['cart_id']; ?>">
                            <div class="col-lg-5 cartProductInfo">
                                <?php if ($product['thumb']) { ?>
                                    <div class="image">
                                        <a href="<?php echo $product['href']; ?>">
                                            <img src="<?php echo $product['thumb']; ?>"
                                                 alt="<?php echo $product['name']; ?>"
                                                 title="<?php echo $product['name']; ?>"/>
                                        </a>
                                    </div>
                                <?php } ?>
                                <div class="title">
                                    <a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                                    <?php if (!$product['stock']) { ?>
                                        <span class="stock">***</span>
                                    <?php } ?>
                                    <div>
                                        <?php foreach ($product['option'] as $option) { ?>
                                            <small><?php echo $option['name']; ?>
                                                : <?php echo $option['value']; ?></small>
                                            <br/>
                                        <?php } ?>
                                    </div>
                                    <?php if ($product['reward']) { ?>
                                        <small><?php echo $product['reward']; ?></small>
                                    <?php } ?>
                                    <div class="price">
                                        <?php echo $product['total']; ?>
                                    </div>
                                </div>
                                <a class="removeButton" href="javascript:void(0);"
                                   title="<?php echo $button_remove; ?>"
                                   onclick="cart.remove('<?php echo $product['cart_id']; ?>',<?php echo ($k == 0) ? 'true' : 'false'; ?>);"><i
                                        class="fa fa-2 fa-times"></i></a>

                                <div class="clear"></div>
                                <h3><?php echo $text_flower_message; ?></h3>
                                            <textarea

                                                id="message_<?php echo $key; ?>"
                                                maxlength="250"
                                                name="delInfo[<?php echo $key; ?>][message]" class="form-control"
                                                placeholder="<?php echo $text_flower_message_placeholder; ?>"><?php echo $delInfo['message']; ?></textarea>

                            </div>
                            <div class="col-lg-7">
                                <?php
                                $index = $k;
                                include "catalog/view/theme/default/template/checkout/flowerForm.tpl"; ?>
                            </div>
                        </div>

                    <?php } ?>
                </div>
            </form>
            <div class="row">
                <div class="col-lg-4 col-lg-offset-8 text-right couponCartBlock">
                    <?php echo $coupon; ?>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <table class="table cartTotals" id="cartBlock">
                        <?php foreach ($totals as $total) { ?>
                            <tr>
                                <td class="text-right"><?php echo $total['title']; ?>:</td>
                                <td class="text-right total"><?php echo $total['text']; ?></td>
                            </tr>
                        <?php } ?>
                    </table>
                </div>
            </div>
            <div class="buttons">
                <div class="pull-right"><a href="javascript: void(0);" onclick="sendCart();"
                                           class="btn btn-primary"><?php echo $button_checkout; ?></a></div>
            </div>
            <?php echo $content_bottom; ?></div>
        <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>

<script type="text/javascript"><!--
    $('input[name=\'next\']').bind('change', function () {
        $('.cart-module > div').hide();

        $('#' + this.value).show();
    });
    $('#create_account').change(function () {
        if ($(this).prop("checked")) {
            $("#passwordBlock").slideDown();
        } else {
            $("#passwordBlock").slideUp();
        }
    });
    $('.chooseBlock input[type="radio"]').on('change', function () {
        prodKey = $(this).closest(".chooseBlock").attr("rel");
        if ($(this).val() == "ELSE") {
            $("#deliverer_" + prodKey).slideDown();
        } else {
            $("#deliverer_" + prodKey).slideUp();
        }
    });
    $('.shipping_methods_choice input[type="radio"]').on('change', function () {
        prodKey = $(this).attr("rel");
        shipCode = $(this).attr("rev");
        choosenBlock = "#ship_" + prodKey + "_" + shipCode;
        $(".ship_" + prodKey + ":not(" + choosenBlock + ")").slideUp();
        $(choosenBlock).slideDown();

    });
    $(function () {
        $.mask.definitions['x'] = '[0-9]';
        $('.telephone_form').mask("<?php echo $config_telephone_mask; ?>", {placeholder: "_"});
    });
    //--></script>
<script type="text/javascript"><!--
    $('.date').datetimepicker({
        pickTime: false,
        disabledDates: ['<?php echo implode("','",$excludeDates) ?>'],
        locale: 'en'
    });
    $('.datePreOrder').datetimepicker({
        pickTime: false,
        disabledDates: ['<?php echo implode("','",$excludePreorderDates) ?>'],
        locale: 'en'
    });
    $('.datePickerGroup button').on('click', function () {
        $(this).closest('.datePickerGroup').find('input[type="text"]').trigger('click');
    });
    //--></script>