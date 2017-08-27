<div id="rcart">
    <div class="heading">
        <span id="rcart-total"><?php echo $text_items_full; ?></span>
    </div>
    <div class="content" id="rcart_content">
        <?php if ($products || $vouchers) { ?>
            <div class="mini-cart-info">
                <table cellpadding="0" cellspacing="0" border="0">
                    <?php foreach ($products as $product) { ?>
                        <tr>
                            <td class="image"><?php if ($product['thumb']) { ?>
                                    <a href="<?php echo $product['href']; ?>">
                                        <img src="<?php echo $product['thumb']; ?>"
                                             alt="<?php echo $product['name']; ?>"
                                             title="<?php echo $product['name']; ?>"/>

                                        <span class="removeButton r_delete"
                                           title="<?php echo $button_remove; ?>"
                                           onclick="cart.remove('<?php echo $product['cart_id']; ?>');return false;">
                                            <i class="fa fa-2 fa-times"></i>
                                        </span>

                                    </a>
                                <?php } ?></td>
                        </tr>
                    <?php } ?>
                </table>
            </div>
        <?php } else { ?>
            <div class="empty"><?php echo $text_cart_empty; ?></div>
        <?php } ?>
    </div>
    <?php if (count($products) > 2) { ?>
        <div class="arrow_down" onclick="func_arrow_down(this,<?php echo(count($products) * 88) ?>)">
            <img src="catalog/view/theme/default/image/product_list_arrow_cart.png"/></div>
        <script type="text/javascript"><!--
            var cview = localStorage.getItem('cart_display');
            if (cview == 'open') {
                $('#rcart .arrow_down').addClass('active');
                $('#rcart .arrow_down img').attr('src', 'catalog/view/theme/default/image/product_list_arrow_cart_up.png');
                $('#rcart .content').css('height', '<?php echo (count($products) * 88) ?>px');
            }
            //--></script>
    <?php } ?>
    <?php if ($products) { ?>
        <a type="button"
               value="<?php echo $text_checkout; ?>"
               id="button-rcart"
               class="btn btn-primary btn-block"
               onclick="window.location = '<?php echo $cart; ?>';"><?php echo $text_checkout; ?></a>
    <?php } ?>
</div>


<script type="text/javascript"><!--
    $('.right_cart .left').click(function(){
        if ( !$('.right_cart').hasClass('active') ) {
            $('.right_cart').addClass('active').animate({ width: '134px'}, 600);
            $('.right_cart .ccontent > div.right').animate({ width: '80px'}, 600);

        } else {
            $('.right_cart').removeClass('active').animate({ width: '42px'}, 600);
            $('.right_cart .ccontent > div.right').animate({ width: '0px'}, 600);
        }

    });
    cview = localStorage.getItem('cart_display');
    function func_arrow_down(item,nheight) {
        if (!$(item).hasClass('active') ) {
            $(item).addClass('active');
            coords = $('.right_cart').offset();
            $('.right_cart').css('position','absolute').css('top',coords.top);
            $('#rcart .content').animate({ height: nheight + 'px'}, 600)
            $('#rcart .arrow_down img').attr('src','catalog/view/theme/default/image/product_list_arrow_cart_up.png');
            localStorage.setItem('cart_display', 'open');
        } else {
            $(item).removeClass('active');
            $('#rcart .content').animate({ height: '176px'}, 600)
            $('#rcart .arrow_down img').attr('src','catalog/view/theme/default/image/product_list_arrow_cart.png');
            localStorage.setItem('cart_display', 'closed');

            coords = $('.right_cart').offset();
            var positionTop = coords.top - $(window).scrollTop();
            if (positionTop < 0) {
                positionTop = 20;
            }
            $('.right_cart').css('position','fixed').css('top',positionTop);
        }
    }
    //--></script>