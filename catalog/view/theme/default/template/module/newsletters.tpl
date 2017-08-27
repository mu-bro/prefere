<script>
    function subscribe() {
        $('.error, .success').remove();
        var emailpattern = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
        var email = $('#txtemail').val();
        if (email != "") {
            if (!emailpattern.test(email)) {
                $("#newLetterForm").after("<span class='error'><?php echo $text_invalid_email; ?></span>");
                return false;
            }
            else {
                $.ajax({
                    url: 'index.php?route=module/newsletters/news',
                    type: 'post',
                    data: 'email=' + $('#txtemail').val(),
                    dataType: 'json',
                    success: function (json) {
                        if (json['error']) {
                            $("#newLetterForm").after("<span class='error'>" + json['error'] + "</span>");
                        } else {
                            $("#newLetterForm").after("<span class='success'>" + json['success'] + "</span>");
                        }
                    }

                });
                return false;
            }
        }
        else {
            $("#newLetterForm").append("<span class='error'><?php echo $text_email_is_required; ?></span>");
            $(email).focus();
            return false;
        }
    }
</script>

<div class="newsLetter">
<h5><?php echo $heading_title; ?></h5>
    <form action="" method="post" id="newLetterForm">
        <div class="input-group">
            <input type="email" name="txtemail" id="txtemail" value="" placeholder="<?php echo $subscribe_newsletter; ?>"
                   class="form-control"/>
                <span class="input-group-btn">
                    <button type="submit" class="btn btn-default" onclick="return subscribe();"><i class="fa
                    fa-chevron-right"></i></button>
                </span>
        </div>
    </form>
</div>