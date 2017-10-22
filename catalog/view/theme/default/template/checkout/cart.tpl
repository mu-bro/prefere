<?php echo $header; ?>
<div class="main-container">
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
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="cartForm">
                <div class="container cartBlock centralBlock checkout delInfo">
                    <h1>
                        <span><?php echo $heading_title; ?>
                            <?php if ($weight) { ?>
                                &nbsp;(<?php echo $weight; ?>)
                            <?php } ?>
                        </span>
                    </h1>
                    <div class="row">
                        <div class="col-lg-12">
                            <table class="table cartProductTable">
                                <thead>
                                <tr>
                                    <th colspan="2"><?php echo $column_name; ?></th>
                                    <th><?php echo $column_price; ?></th>
                                    <th><?php echo $column_quantity; ?></th>
                                    <th><?php echo $column_total; ?></th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>
                                <?php foreach ($products as $k => $product) {
                                    $key = $product["cart_id"]; ?>
                                    <?php include "catalog/view/theme/default/template/checkout/cart/products.tpl"; ?>
                                <?php } ?>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="row continueRow">
                        <div class="col-sm-6">
                            <a class="linkButton" href="<?php echo $continue; ?>"><?php echo $button_shopping; ?></a>
                        </div>
                        <div class="col-sm-6">
                            <?php include "catalog/view/theme/default/template/checkout/cart/totals.tpl"; ?>
                        </div>
                    </div>
                </div>
                <div class="messageBlock row">
                    <h3><?php echo $text_flower_message; ?></h3>
                    <textarea
                        id="message"
                        maxlength="250"
                        name="delInfo[message]" class="form-control"
                        placeholder="<?php echo $text_flower_message_placeholder; ?>"><?php echo $delInfo['message']; ?></textarea>
                </div>
                <div class="container cartBlock delInfo">
                    <div class="row" id="flowerForm">
                        <?php include "catalog/view/theme/default/template/checkout/cart/flowerForm.tpl"; ?>
                    </div>
                </div>
                <input type="hidden"
                       name="delInfo[source_found]"
                       id="source_found"
                       value="<?php if (isset($delInfo['source_found'])) echo $delInfo['source_found']; ?>"/>
            </form>
            <div class="container delInfo" id="additions">
                <div class="row">
                    <div class="col-sm-6 col-xs-12 couponCartBlock">
                        <?php echo $coupon; ?>
                    </div>
                    <div class="col-sm-6 col-xs-12 text-right couponCartBlock">
                        <?php echo $reward; ?>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12 text-center totalBlock">
                        <div class="bottomTotals">
                            <?php include "catalog/view/theme/default/template/checkout/cart/totals.tpl"; ?>                                       </div>
                        <div class="buttons">
                                <a href="javascript: void(0);" onclick="sendCart();"
                                   class="btn btn-primary"><?php echo $button_checkout; ?></a>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <?php include "catalog/view/theme/default/template/checkout/cart/source_find.tpl"; ?>
                    </div>
                </div>
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
        updateDelivererBlockStatus($(this).val());
    });
    $('.chooseBlock input[type="checkbox"]#is_company').on('change', function () {
        updateCompanyBlockStatus($(this));
    });
    $('.shipping_methods_choice input[type="radio"]').on('change', function () {
        prodKey = $(this).attr("rel");
        shipCode = $(this).attr("rev");
        choosenBlock = "#ship" + "_" + shipCode;
        $(".ship" + ":not(" + choosenBlock + ")").slideUp();
        $(choosenBlock).slideDown();

    });
    $('.couponCartBlock input[name="additions"]').on('change', function () {
        $('.additionBlock').hide();
        itemValue = $(this).val();
        $('.additionBlock#' + itemValue + '-block').show();
    });

    $('.quantity input').on('change', function () {
        var cartId = $(this).attr('rel');
        var quantity = $(this).val();
        updateProductQuantity(this, cartId, quantity);
    });


    $(function () {
        $.mask.definitions['x'] = '[0-9]';
        $('.telephone_form').mask("<?php echo $config_telephone_mask; ?>", {placeholder: "_"});
        updateDelivererBlockStatus($('.chooseBlock input[name="delInfo[deliverer]"]:checked').val());
        updateCompanyBlockStatus($('.chooseBlock input[type="checkbox"]#is_company'));
    });
    //--></script>
<script type="text/javascript"><!--
    $('.date').datetimepicker({
        pickTime: false,
        disabledDates: ['<?php echo implode("','",$excludeDates) ?>'],
        minDate: new Date(),
        locale: 'en'
    });
    $('.outOfCityDate').datetimepicker({
        pickTime: false,
        disabledDates: ['<?php echo implode("','",$excludeOutOfCityDates) ?>'],
        minDate: new Date(),
        locale: 'en'
    });
    $('.datePickerGroup button').on('click', function () {
        $(this).closest('.datePickerGroup').find('input[type="text"]').trigger('click');
    });
    //--></script>