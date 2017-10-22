<?php echo $header; ?>
<div class="container mainBlock">
    <div class="row">
        <?php echo $column_left; ?>
        <?php if ($column_left && $column_right) { ?>
            <?php $class = 'col-sm-6'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
            <?php $class = 'col-sm-10'; ?>
        <?php } else { ?>
            <?php $class = 'col-sm-12'; ?>
        <?php } ?>
        <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
            <div class="row">
                <?php if ($column_left || $column_right) { ?>
                    <?php $class = 'col-sm-4'; ?>
                <?php } else { ?>
                    <?php $class = 'col-sm-4'; ?>
                <?php } ?>
                <div class="<?php echo $class; ?>">
                    <div class="thumbBlock">
                        <?php if ($thumb || $images) { ?>
                            <ul class="thumbnails">
                                <?php if ($thumb) { ?>
                                    <li><a id="thumbnail" class="thumbnail"
                                           href="<?php echo $popup; ?>"
                                           title="<?php echo $heading_title; ?>"><img
                                                src="<?php echo $thumb; ?>"
                                                title="<?php echo $heading_title; ?>"
                                                alt="<?php echo $heading_title; ?>"/></a></li>
                                <?php } ?>
                            </ul>
                        <?php if ($images) { ?>
                            <div class="additions owl-carousel">
                                <?php foreach ($images as $image) { ?>
                                    <div class="image-additional">
                                        <a class="add-thumbnail"
                                           href="<?php echo $image['popup']; ?>"
                                           title="<?php echo $heading_title; ?>">
                                            <img src="<?php echo $image['thumb']; ?>"
                                                 title="<?php echo $heading_title; ?>"
                                                 alt="<?php echo $heading_title; ?>" class="img-responsive"/>
                                        </a>
                                    </div>
                                <?php } ?>
                            </div>
                            <script type="text/javascript"><!--
                                $('.additions').owlCarousel({
                                    items: 3,
                                    itemsDesktop: [1199, 3],
                                    itemsDesktopSmall: [979, 3],
                                    itemsTablet: [768, 3],
                                    itemsTabletSmall: [600, 3],
                                    itemsMobile: [479, 3],
                                    navigation: true,
                                    slideSpeed: 600,
                                    navigationText: ['<i class="fa fa-angle-left fa-5x"></i>', '<i class="fa fa-angle-right fa-5x"></i>'],
                                    pagination: false
                                });
                                --></script>
                        <?php } ?>
                        <?php } ?>

                        <?php if (!empty($video)) { ?>
                            <div class="video">
                                <div class="video_title"><?php echo $txt_video_title; ?></div>
                                <?php echo html_entity_decode($video); ?>
                            </div>
                        <?php } ?>
                    </div>
                </div>
                <?php if ($column_left || $column_right) { ?>
                    <?php $class = 'col-sm-8'; ?>
                <?php } else { ?>
                    <?php $class = 'col-sm-8'; ?>
                <?php } ?>
                <div class="<?php echo $class; ?>">
                    <ul class="breadcrumb" style="display:none;">
                        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                            <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                        <?php } ?>
                    </ul>
                    <h1 class="annabelle"><?php echo $heading_title; ?></h1>
                    <?php if ($price) { ?>
                        <ul class="priceList list-unstyled">
                            <?php if (!$special) { ?>
                                <li class="priceItem" id="price">
                                    <?php echo $price; ?>
                                </li>
                            <?php } else { ?>
                                <li><span style="text-decoration: line-through;">
                                    <?php echo $price; ?></span></li>
                                <li class="priceItem" id="price">
                                    <?php echo $special; ?>
                                </li>
                            <?php } ?>
                            <?php if ($tax) { ?>
                                <li><?php echo $text_tax; ?> <?php echo $tax; ?></li>
                            <?php } ?>
                            <?php if ($reward) { ?>
                                <li class="points"><?php echo $text_reward; ?> <span id="points"><?php echo $reward; ?></span></li>
                            <?php } ?>
                            <?php if ($discounts) { ?>
                                <li>
                                    <hr>
                                </li>
                                <?php foreach ($discounts as $discount) { ?>
                                    <li>
                                        <?php echo $discount['quantity']; ?><?php echo $text_discount; ?>
                                        <?php echo $discount['price']; ?>
                                    </li>
                                <?php } ?>
                            <?php } ?>
                        </ul>
                    <?php } ?>
                    <div id="product">
                        <div class="row">
                            <div class="col-lg-6 col-md-12 col-sm-12 col-xs-12 optionBlock">
                                <div class="form-group">
                                    <label class="control-label" for="input-quantity">
                                        <?php echo $entry_qty; ?>:
                                    </label>
                                    <div class="input-group quantityBlock">
                                            <input type="input"
                                                   name="quantity"
                                                   value="<?php echo $minimum; ?>"
                                                   id="input-quantity"
                                                   class="form-control input-number"
                                                   min="1" max="50"
                                                />
                                    </div>
                                </div>
                            </div>
                            <?php if ($options) { ?>
                                <?php include 'catalog/view/theme/default/template/product/product_options.tpl'; ?>
                            <?php } ?>
                        </div>
                        <?php if (!empty(strip_tags($description))) { ?>
                            <div class="prodDescription"><?php echo $description; ?></div>
                        <?php } ?>
                        <?php if ($recurrings) { ?>
                            <hr>
                            <h3><?php echo $text_payment_recurring ?></h3>
                            <div class="form-group required">
                                <select name="recurring_id" class="form-control">
                                    <option value=""><?php echo $text_select; ?></option>
                                    <?php foreach ($recurrings as $recurring) { ?>
                                        <option value="<?php echo $recurring['recurring_id'] ?>"><?php echo $recurring['name'] ?></option>
                                    <?php } ?>
                                </select>

                                <div class="help-block" id="recurring-description"></div>
                            </div>
                        <?php } ?>
                        <div class="productButtons">
                            <input type="hidden" name="product_id" value="<?php echo $product_id; ?>"/>
                            <?php if ($preorder) { ?>
                                <div class="preorderText"><?php echo $textPreorder; ?>
                                    <span data-toggle="tooltip"
                                          data-placement="right"
                                          data-original-title="<?php echo $textPreorderDescr; ?>"><i class="fa fa-info-circle"></i></span>
                                </div>
                            <?php } ?>
                            <div class="row buttonBlock">
                                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                                    <button type="button"
                                            id="button-cart"
                                            data-loading-text="<?php echo $text_loading; ?>"
                                            class="btn btn-primary btn-lg btn-block"><?php echo $button_cart; ?></button>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 hidden ">
                                    <button type="button"
                                            data-toggle="modal" data-target="#fastorder"
                                            data-loading-text="<?php echo $text_loading; ?>"
                                            class="btn btn-primary btn-lg btn-block"><?php echo $entry_fo_button; ?></button>
                                </div>
                            </div>

                        </div>
                        <?php if (isset($manufacturer_image)) { ?>
                            <div class="imageDescription"><img src="<?php echo $manufacturer_image; ?>" class="img-responsive"/></div>
                        <?php } ?>
                    </div>
                    <?php if ($minimum > 1) { ?>
                        <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $text_minimum; ?></div>
                    <?php } ?>
                </div>
            </div>
            <div class="row">
                <?php if ($products) { ?>
                    <div class="topBorder"></div>
                    <div class="centralBlock recomended">
                        <h3 class="small"><span><?php echo $text_related; ?></span></h3>

                        <div class="row">
                            <?php include 'catalog/view/theme/' . $config_template . '/template/product/product_list.tpl'; ?>
                        </div>
                    </div>
                <?php } ?>
            </div>
        </div>
        <?php echo $column_right; ?>
    </div>
    <?php if ($tags) { ?>
        <p><?php echo $text_tags; ?>
            <?php for ($i = 0; $i < count($tags); $i++) { ?>
                <?php if ($i < (count($tags) - 1)) { ?>
                    <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
                <?php } else { ?>
                    <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
                <?php } ?>
            <?php } ?>
        </p>
    <?php } ?>
    <?php echo $content_bottom; ?>
</div>
<script type="text/javascript"><!--
    $('select[name=\'recurring_id\'], input[name="quantity"]').change(function () {
        $.ajax({
            url: 'index.php?route=product/product/getRecurringDescription',
            type: 'post',
            data: $('input[name=\'product_id\'], input[name=\'quantity\'], select[name=\'recurring_id\']'),
            dataType: 'json',
            beforeSend: function () {
                $('#recurring-description').html('');
            },
            success: function (json) {
                $('.alert, .text-danger').remove();

                if (json['success']) {
                    $('#recurring-description').html(json['success']);
                }
            }
        });
    });
    //--></script>
<script type="text/javascript"><!--
    $('#button-cart').on('click', function () {
        $.ajax({
            url: 'index.php?route=checkout/cart/add',
            type: 'post',
            data: $('#product input[type=\'text\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
            dataType: 'json',
            beforeSend: function () {
                $('#button-cart').button('loading');
            },
            complete: function () {
                $('#button-cart').button('reset');
            },
            success: function (json) {
                $('.alert, .text-danger').remove();
                $('.form-group').removeClass('has-error');

                if (json['error']) {
                    if (json['error']['option']) {
                        for (i in json['error']['option']) {
                            var element = $('#input-option' + i.replace('_', '-'));

                            if (element.parent().hasClass('input-group')) {
                                element.parent().parent().append('<div class="text-danger">' + json['error']['option'][i] + '</div>');
                            } else {
                                element.parent().append('<div class="text-danger">' + json['error']['option'][i] + '</div>');
                            }
                        }
                    }

                    if (json['error']['recurring']) {
                        $('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
                    }

                    // Highlight any found errors
                    $('.text-danger').parent().addClass('has-error');
                }

                if (json['success']) {
                    $('.breadcrumb').after('<div class="alert alert-success">' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');

                    $('#cart-total').html(json['total']);

                    $('html, body').animate({scrollTop: $("#content").offset().top - 20}, 'slow');

                    $('#cart > ul').load('index.php?route=common/cart/info ul li');
                    $('#rcart').load('index.php?route=common/rcart/info #rcart > *');

                    if ($('.right_cart').hasClass('hidden')) {
                        $('.right_cart').removeClass('hidden');
                        $('.right_cart .left').click();
                        setTimeout(function () {
                            $('.right_cart .left').click();
                        }, 2000);
                    }
                }
            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });
    //--></script>
<script type="text/javascript"><!--
    $('.date').datetimepicker({
        pickTime: false
    });

    $('.datetime').datetimepicker({
        pickDate: true,
        pickTime: true
    });

    $('.time').datetimepicker({
        pickDate: false
    });

    $('button[id^=\'button-upload\']').on('click', function () {
        var node = this;

        $('#form-upload').remove();

        $('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

        $('#form-upload input[name=\'file\']').trigger('click');

        if (typeof timer != 'undefined') {
            clearInterval(timer);
        }

        timer = setInterval(function () {
            if ($('#form-upload input[name=\'file\']').val() != '') {
                clearInterval(timer);

                $.ajax({
                    url: 'index.php?route=tool/upload',
                    type: 'post',
                    dataType: 'json',
                    data: new FormData($('#form-upload')[0]),
                    cache: false,
                    contentType: false,
                    processData: false,
                    beforeSend: function () {
                        $(node).button('loading');
                    },
                    complete: function () {
                        $(node).button('reset');
                    },
                    success: function (json) {
                        $('.text-danger').remove();

                        if (json['error']) {
                            $(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
                        }

                        if (json['success']) {
                            alert(json['success']);

                            $(node).parent().find('input').attr('value', json['code']);
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });
            }
        }, 500);
    });
    //--></script>
<script type="text/javascript"><!--
    $('#review').delegate('.pagination a', 'click', function (e) {
        e.preventDefault();

        $('#review').fadeOut('slow');

        $('#review').load(this.href);

        $('#review').fadeIn('slow');
    });

    $('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

    $('#button-review').on('click', function () {
        $.ajax({
            url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
            type: 'post',
            dataType: 'json',
            data: $("#form-review").serialize(),
            beforeSend: function () {
                $('#button-review').button('loading');
            },
            complete: function () {
                $('#button-review').button('reset');
            },
            success: function (json) {
                $('.alert-success, .alert-danger').remove();

                if (json['error']) {
                    $('#review').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
                }

                if (json['success']) {
                    $('#review').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');

                    $('input[name=\'name\']').val('');
                    $('textarea[name=\'text\']').val('');
                    $('input[name=\'rating\']:checked').prop('checked', false);
                }
            }
        });
    });

    $(document).ready(function () {
        $('.thumbBlock').magnificPopup({
            type: 'image',
            delegate: 'a',
            gallery: {
                enabled: true
            }
        });
        $('.sizeOption').on('click', function () {
            $('.sizeOption').removeClass('active');
            $(this).addClass('active');

            radioInput = $(this).find('input[type="radio"]');
            radioInput.prop('checked', true);

            optionImage = radioInput.attr('rel');
            if (optionImage != '') {
                $('#thumbnail').attr('href', optionImage);
                $('#thumbnail img').attr('src', radioInput.attr('rev'));
            }
        });
        $('.colorOptions select').on('change', function () {
            var optionImage = $('option:selected', this).attr('rel');
            var optionThumb = $('option:selected', this).attr('rev');

            if (optionImage != '') {
                $('#thumbnail').attr('href', optionImage);
                $('#thumbnail img').attr('src', optionThumb);
            }
        });
    });
    //--></script>
<?php include 'catalog/view/theme/' . $config_template . '/template/product/fast_order.tpl'; ?>
<?php echo $footer; ?>
