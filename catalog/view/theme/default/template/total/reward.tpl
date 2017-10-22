<div class="delInfo">
    <input type="radio" name="additions" value="reward" id="reward_addition" <?php if (!empty($reward)) echo 'checked="checked"'; ?>/>
    <label class="subTitle" for="reward_addition"><?php echo $heading_title; ?></label>
</div>
<div id="reward-block" class="additionBlock" <?php if (!empty($reward)) echo 'style="display:block;"'; ?>>
    <div class="input-group">
        <input style="max-width:200px;float:right;" type="text"
               name="reward"
               value="<?php echo $reward; ?>"
               placeholder="<?php echo $entry_reward; ?>"
               id="input-reward"
               class="form-control"/>
        <span class="input-group-btn">
        <input type="submit"
               value="<?php echo $button_reward; ?>"
               id="button-reward"
               data-loading-text="<?php echo $text_loading; ?>"
               class="btn btn-primary"/>
        </span>
    </div>
</div>

<script type="text/javascript"><!--
    $('#button-reward').on('click', function () {
        $.ajax({
            url: 'index.php?route=total/reward/reward',
            type: 'post',
            data: 'reward=' + encodeURIComponent($('input[name=\'reward\']').val()),
            dataType: 'json',
//            beforeSend: function () {
//                $('#button-reward').button('loading');
//            },
//            complete: function () {
//                $('#button-reward').button('reset');
//            },
            success: function (json) {
                $('.alert').remove();

                if (json['error']) {
                    $('#additions').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');

//                    $('html, body').animate({scrollTop: 0}, 'slow');
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