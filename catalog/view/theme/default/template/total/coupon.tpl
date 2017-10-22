<div class="delInfo">
    <input type="radio" name="additions" value="coupon" id="coupon_addition" <?php if (!empty($coupon)) echo 'checked="checked"'; ?> />
    <label class="subTitle" for="coupon_addition"><?php echo $heading_title; ?></label>
</div>
<div id="coupon-block" class="additionBlock" <?php if (!empty($coupon)) echo 'style="display:block;"'; ?>>
    <div class="input-group">
        <input
               style="max-width:200px;"
               type="text"
               name="coupon"
               value="<?php echo $coupon; ?>"
               placeholder="<?php echo $entry_coupon; ?>"
               id="input-coupon"
               class="form-control"/>
        <span style="float:left;" class="input-group-btn">
        <input
               type="button"
               value="<?php echo $button_coupon; ?>"
               id="button-coupon"
               data-loading-text="<?php echo $text_loading; ?>"
               class="btn btn-primary"/>
        </span></div>
</div>

<script type="text/javascript"><!--
    $('#button-coupon').on('click', function () {
        $.ajax({
            url: 'index.php?route=total/coupon/coupon',
            type: 'post',
            data: 'coupon=' + encodeURIComponent($('input[name=\'coupon\']').val()),
            dataType: 'json',
//            beforeSend: function () {
//                $('#button-coupon').button('loading');
//            },
//            complete: function () {
//                $('#button-coupon').button('reset');
//            },
            success: function (json) {
                $('.alert').remove();

                if (json['error']) {
                    $('#additions').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }
                if (json['totals']) {
                    $('#additions').prepend('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                    $('.cartTotals').html(json['totals']);
                }
                if (json['redirect']) {
                    location = json['redirect'];
                }
            }
        });
    });
    //--></script>

