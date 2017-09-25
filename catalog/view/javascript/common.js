function getURLVar(key) {
    var value = [];

    var query = String(document.location).split('?');

    if (query[1]) {
        var part = query[1].split('&');

        for (i = 0; i < part.length; i++) {
            var data = part[i].split('=');

            if (data[0] && data[1]) {
                value[data[0]] = data[1];
            }
        }

        if (value[key]) {
            return value[key];
        } else {
            return '';
        }
    }
}

$(document).ready(function () {
    // Highlight any found errors
    $('.text-danger').each(function () {
        var element = $(this).parent().parent();

        if (element.hasClass('form-group')) {
            element.addClass('has-error');
        }
    });

    // Currency
    $('#currency .currency-select').on('click', function (e) {
        e.preventDefault();

        $('#currency input[name=\'code\']').attr('value', $(this).attr('name'));

        $('#currency').submit();
    });

    // Language
    $('#language_form a').on('click', function (e) {
        e.preventDefault();
        $('#language_form input[name=\'code\']').attr('value', $(this).attr('href'));
        $('#language_form').submit();
    });

    /* Search */
    $('#search input[name=\'search\']').parent().find('button').on('click', function () {
        url = $('base').attr('href') + 'index.php?route=product/search';

        var value = $('header input[name=\'search\']').val();

        if (value) {
            url += '&search=' + encodeURIComponent(value);
        }

        location = url;
    });

    $('#search input[name=\'search\']').on('keydown', function (e) {
        if (e.keyCode == 13) {
            $('header input[name=\'search\']').parent().find('button').trigger('click');
        }
    });

    // Menu
    $('#menu .dropdown-menu').each(function () {
        var menu = $('#menu').offset();
        var dropdown = $(this).parent().offset();

        var i = (dropdown.left + $(this).outerWidth()) - (menu.left + $('#menu').outerWidth());

        if (i > 0) {
            $(this).css('margin-left', '-' + (i + 5) + 'px');
        }
    });

    // Product List
    $('#list-view').click(function () {
        $('#content .product-grid > .clearfix').remove();

        //$('#content .product-layout').attr('class', 'product-layout product-list col-xs-12');
        $('#content .row > .product-grid').attr('class', 'product-layout product-list col-xs-12');

        localStorage.setItem('display', 'list');
    });

    // Product Grid
    $('#grid-view').click(function () {
        // What a shame bootstrap does not take into account dynamically loaded columns
        cols = $('#column-right, #column-left').length;

        if (cols == 2) {
            $('#content .product-list').attr('class', 'product-layout product-grid col-lg-6 col-md-6 col-sm-12 col-xs-12');
        } else if (cols == 1) {
            $('#content .product-list').attr('class', 'product-layout product-grid col-lg-4 col-md-4 col-sm-6 col-xs-12');
        } else {
            $('#content .product-list').attr('class', 'product-layout product-grid col-lg-15 col-md-15 col-sm-6 col-xs-12');
        }

        localStorage.setItem('display', 'grid');
    });

    if (localStorage.getItem('display') == 'list') {
        $('#list-view').trigger('click');
    } else {
        $('#grid-view').trigger('click');
    }

    // Checkout
    $(document).on('keydown', '#collapse-checkout-option input[name=\'email\'], #collapse-checkout-option input[name=\'password\']', function (e) {
        if (e.keyCode == 13) {
            $('#collapse-checkout-option #button-login').trigger('click');
        }
    });

    // tooltips on hover
    $('[data-toggle=\'tooltip\']').tooltip({container: 'body'});

    // Makes tooltips work on ajax generated content
    $(document).ajaxStop(function () {
        $('[data-toggle=\'tooltip\']').tooltip({container: 'body'});
    });
});

// Cart add remove functions
var cart = {
    'add': function (product_id, quantity) {
        $.ajax({
            url: 'index.php?route=checkout/cart/add',
            type: 'post',
            data: 'product_id=' + product_id + '&quantity=' + (typeof(quantity) != 'undefined' ? quantity : 1),
            dataType: 'json',
            beforeSend: function () {
                $('#cart > button').button('loading');
            },
            complete: function () {
                $('#cart > button').button('reset');
            },
            success: function (json) {
                $('.alert, .text-danger').remove();

                if (json['redirect']) {
                    location = json['redirect'];
                }

                if (json['success']) {
                    $('#content').parent().before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');

                    // Need to set timeout otherwise it wont update the total
                    setTimeout(function () {
                        $('#cart-total').html(json['total']);
                    }, 100);

                    $('html, body').animate({scrollTop: 0}, 'slow');

                    $('#cart > ul').load('index.php?route=common/cart/info ul li');
                    $('#rcart').load('index.php?route=common/rcart/info #rcart > *');
                }
            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    },
    'update': function (key, quantity) {
        $.ajax({
            url: 'index.php?route=checkout/cart/edit',
            type: 'post',
            data: 'key=' + key + '&quantity=' + (typeof(quantity) != 'undefined' ? quantity : 1),
            dataType: 'json',
            beforeSend: function () {
                $('#cart > button').button('loading');
            },
            complete: function () {
                $('#cart > button').button('reset');
            },
            success: function (json) {
                // Need to set timeout otherwise it wont update the total
                setTimeout(function () {
                    $('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
                }, 100);

                if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
                    location = 'index.php?route=checkout/cart';
                } else {
                    $('#cart > ul').load('index.php?route=common/cart/info ul li');
                    $('#rcart').load('index.php?route=common/rcart/info #rcart > *');
                }
            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    },
    'remove': function (key, needReload) {
        $.ajax({
            url: 'index.php?route=checkout/cart/remove',
            type: 'post',
            data: 'key=' + key,
            dataType: 'json',
            beforeSend: function () {
                $('#cart > button').button('loading');
            },
            complete: function () {
                $('#cart > button').button('reset');
            },
            success: function (json) {
                // Need to set timeout otherwise it wont update the total
                setTimeout(function () {
                    $('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
                }, 100);

                if (needReload) {
                    location.reload();
                    return false;
                }
                if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
                    $('#cartBlock').html(json['totals']);
                    $('#cartProduct' + key).remove();
                } else {
                    $('#cart > ul').load('index.php?route=common/cart/info ul li');
                    $('#rcart').load('index.php?route=common/rcart/info #rcart > *');
                }
            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    }
}

var voucher = {
    'add': function () {

    },
    'remove': function (key) {
        $.ajax({
            url: 'index.php?route=checkout/cart/remove',
            type: 'post',
            data: 'key=' + key,
            dataType: 'json',
            beforeSend: function () {
                $('#cart > button').button('loading');
            },
            complete: function () {
                $('#cart > button').button('reset');
            },
            success: function (json) {
                // Need to set timeout otherwise it wont update the total
                setTimeout(function () {
                    $('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
                }, 100);

                if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
                    location = 'index.php?route=checkout/cart';
                } else {
                    $('#cart > ul').load('index.php?route=common/cart/info ul li');
                    $('#rcart').load('index.php?route=common/rcart/info #rcart > *');
                }
            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    }
}

var wishlist = {
    'add': function (product_id) {
        $.ajax({
            url: 'index.php?route=account/wishlist/add',
            type: 'post',
            data: 'product_id=' + product_id,
            dataType: 'json',
            success: function (json) {
                $('.alert').remove();

                if (json['redirect']) {
                    location = json['redirect'];
                }

                if (json['success']) {
                    $('#content').parent().before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }

                $('#wishlist-total span').html(json['total']);
                $('#wishlist-total').attr('title', json['total']);

                $('html, body').animate({scrollTop: 0}, 'slow');
            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    },
    'remove': function () {

    }
}

var compare = {
    'add': function (product_id) {
        $.ajax({
            url: 'index.php?route=product/compare/add',
            type: 'post',
            data: 'product_id=' + product_id,
            dataType: 'json',
            success: function (json) {
                $('.alert').remove();

                if (json['success']) {
                    $('#content').parent().before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');

                    $('#compare-total').html(json['total']);

                    $('html, body').animate({scrollTop: 0}, 'slow');
                }
            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    },
    'remove': function () {

    }
}

/* Agree to Terms */
$(document).delegate('.agree', 'click', function (e) {
    e.preventDefault();

    $('#modal-agree').remove();

    var element = this;

    $.ajax({
        url: $(element).attr('href'),
        type: 'get',
        dataType: 'html',
        success: function (data) {
            html = '<div id="modal-agree" class="modal">';
            html += '  <div class="modal-dialog">';
            html += '    <div class="modal-content">';
            html += '      <div class="modal-header">';
            html += '        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>';
            html += '        <h4 class="modal-title">' + $(element).text() + '</h4>';
            html += '      </div>';
            html += '      <div class="modal-body">' + data + '</div>';
            html += '    </div';
            html += '  </div>';
            html += '</div>';

            $('body').append(html);

            $('#modal-agree').modal('show');
        }
    });
});

// Autocomplete */
(function ($) {
    $.fn.autocomplete = function (option) {
        return this.each(function () {
            this.timer = null;
            this.items = new Array();

            $.extend(this, option);

            $(this).attr('autocomplete', 'off');

            // Focus
            $(this).on('focus', function () {
                this.request();
            });

            // Blur
            $(this).on('blur', function () {
                setTimeout(function (object) {
                    object.hide();
                }, 200, this);
            });

            // Keydown
            $(this).on('keydown', function (event) {
                switch (event.keyCode) {
                    case 27: // escape
                        this.hide();
                        break;
                    default:
                        this.request();
                        break;
                }
            });

            // Click
            this.click = function (event) {
                event.preventDefault();

                value = $(event.target).parent().attr('data-value');

                if (value && this.items[value]) {
                    this.select(this.items[value]);
                }
            }

            // Show
            this.show = function () {
                var pos = $(this).position();

                $(this).siblings('ul.dropdown-menu').css({
                    top: pos.top + $(this).outerHeight(),
                    left: pos.left
                });

                $(this).siblings('ul.dropdown-menu').show();
            }

            // Hide
            this.hide = function () {
                $(this).siblings('ul.dropdown-menu').hide();
            }

            // Request
            this.request = function () {
                clearTimeout(this.timer);

                this.timer = setTimeout(function (object) {
                    object.source($(object).val(), $.proxy(object.response, object));
                }, 200, this);
            }

            // Response
            this.response = function (json) {
                html = '';

                if (json.length) {
                    for (i = 0; i < json.length; i++) {
                        this.items[json[i]['value']] = json[i];
                    }

                    for (i = 0; i < json.length; i++) {
                        if (!json[i]['category']) {
                            html += '<li data-value="' + json[i]['value'] + '"><a href="#">' + json[i]['label'] + '</a></li>';
                        }
                    }

                    // Get all the ones with a categories
                    var category = new Array();

                    for (i = 0; i < json.length; i++) {
                        if (json[i]['category']) {
                            if (!category[json[i]['category']]) {
                                category[json[i]['category']] = new Array();
                                category[json[i]['category']]['name'] = json[i]['category'];
                                category[json[i]['category']]['item'] = new Array();
                            }

                            category[json[i]['category']]['item'].push(json[i]);
                        }
                    }

                    for (i in category) {
                        html += '<li class="dropdown-header">' + category[i]['name'] + '</li>';

                        for (j = 0; j < category[i]['item'].length; j++) {
                            html += '<li data-value="' + category[i]['item'][j]['value'] + '"><a href="#">&nbsp;&nbsp;&nbsp;' + category[i]['item'][j]['label'] + '</a></li>';
                        }
                    }
                }

                if (html) {
                    this.show();
                } else {
                    this.hide();
                }

                $(this).siblings('ul.dropdown-menu').html(html);
            }

            $(this).after('<ul class="dropdown-menu"></ul>');
            $(this).siblings('ul.dropdown-menu').delegate('a', 'click', $.proxy(this.click, this));

        });
    }
})(window.jQuery);


function sendCart() {
    $.ajax({
        url: 'index.php?route=checkout/cart/cartUpdate',
        type: 'post',
        data: $('#cartForm').serialize(),
        dataType: 'json',
        success: function (json) {
            $('.success, .warning, .attention, .information, .error').remove();
            if (json['error']) {
                if (json['error']['customer']) {
                    for (field in json['error']['customer']) {
                        $("#customer_block input[name='customer[" + field + "]'").after("<span class='error'>" + json['error']['customer'][field] + "</span>");
                    }
                }

                if (json['error']['delInfo']) {
                    if (json['error']['delInfo']['company']) {
                        for (field in json['error']['delInfo']['company']) {
                            $("#flowerForm #is_company_block *[name='delInfo[company][" + field + "]'")
                                .after("<span class='error'>" + json['error']['delInfo']['company'][field] + "</span>");
                        }
                    }
                    if (json['error']['delInfo']['deliver']) {
                        for (field in json['error']['delInfo']['deliver']) {
                            $("#flowerForm #deliverer input[name='delInfo[deliver][" + field + "]'")
                                .after("<span class='error'>" + json['error']['delInfo']['deliver'][field] + "</span>");
                        }
                    }
                    if (json['error']['delInfo']['message']) {
                        $("#flowerForm #message").after("<span class='error'>" + json['error']['delInfo']['message'] + "</span>");
                    }
                    if (json['error']['delInfo']['deliverer']) {
                        $("#flowerForm #chooseBlock").after("<span class='error'>" + json['error']['delInfo']['deliverer'] + "</span>");
                    }
                    if (json['error']['delInfo']['shipping_method']) {
                        if (json['error']['delInfo']['shipping_method']['code']) {
                            $("#flowerForm #shipping_method_title").after("<span class='error'>" +
                            json['error']['delInfo']['shipping_method']['code'] + "</span>");
                        }
                        if (json['error']['delInfo']['shipping_method']['addr']) {
                            codeValue = json['error']['delInfo']['shipping_method']['codeValue'];
                            for (field in json['error']['delInfo']['shipping_method']['addr']) {
                                inputItem = $("#flowerForm #ship_" + codeValue + " *[name='delInfo[shipping_method][" + codeValue + "][" + field + "]'");
                                if (field == 'date') {
                                    inputItem = inputItem.parent().parent().parent();
                                }
                                inputItem.after("<span class='error'>" + json['error']['delInfo']['shipping_method']['addr'][field] + "</span>");

                            }
                        }
                    }
                }
                //alert($('#cartForm .error').offset().top);
                $('html, body').animate({scrollTop: $('#cartForm .error').offset().top - 200}, 'slow');

                if (json['totals']) {
                    $('#cartBlock').html(json['totals']);
                }
            }

            if (json['success']) {
                location = 'index.php?route=checkout/checkout';
            }
        }
    });

}

function copyFlowerInfo(blockKey) {

    var blockName = '#delInfo' + blockKey;

    var deliverer = $(blockName + " input:checked[name='delInfo[" + blockKey + "][deliverer]'").val();
    if (deliverer == 'ELSE') {
        var deliver_name = $(blockName + " input[name='delInfo[" + blockKey + "][deliver][name]").val();
        var deliver_phone = $(blockName + " input[name='delInfo[" + blockKey + "][deliver][phone]'").val();
        var deliver_surprize = $(blockName + " input[name='delInfo[" + blockKey + "][deliver][surprize]'").is(':checked');
    }

    var message = $('#message_' + blockKey).val();

    var shipping_method = $(blockName + " input:checked[name='delInfo[" + blockKey + "][shipping_method][code]'");
    if (shipping_method.length > 0) {
        var shipping_code = shipping_method.val();
        var shippBlock = '#ship_' + blockKey + '_' + shipping_method.attr('rev');

        var shipCity = $(shippBlock + " input[name$='[city]'").val();
        var shipAddr = $(shippBlock + " textarea[name$='[address]'").val();
        var shipDate = $(shippBlock + " input[name$='[date]'").val();
        var shipTime = $(shippBlock + " select[name$='[time]'").val();
    }

    $("#cartForm .delInfo").each(function () {
        currKey = $(this).attr('rel');
        currBlockName = '#delInfo' + currKey;
        if (currKey != blockKey) {
            $(currBlockName + " input[name='delInfo[" + currKey + "][deliverer]'").filter('[value=' + deliverer + ']').trigger('click');
            if (deliverer == 'ELSE') {
                $(currBlockName + " input[name='delInfo[" + currKey + "][deliver][name]'").val(deliver_name);
                $(currBlockName + " input[name='delInfo[" + currKey + "][deliver][phone]'").val(deliver_phone);
                $(currBlockName + " input[name='delInfo[" + currKey + "][deliver][surprize]'").prop('checked', deliver_surprize);
            }

            if (shipping_method.length > 0) {
                $(currBlockName + " input[name='delInfo[" + currKey + "][shipping_method][code]'").filter('[value="' + shipping_code + '"]').trigger('click');

                currShippBlock = '#ship_' + currKey + '_' + shipping_method.attr('rev');
                $(currShippBlock + " input[name$='[city]'").val(shipCity);
                $(currShippBlock + " textarea[name$='[address]'").val(shipAddr);
                $(currShippBlock + " input[name$='[date]'").val(shipDate);
                $(currShippBlock + " select[name$='[time]'").val(shipTime);
            }

            $('#message_' + currKey).val(message);
        }
    });
}

function updateProductQuantity(selectItem, cartId, quantity) {
    $.ajax({
        url: 'index.php?route=checkout/cart/editQuantity',
        type: 'post',
        data: 'cartId=' + cartId + '&quantity=' + (typeof(quantity) != 'undefined' ? quantity : 1),
        dataType: 'json',
        beforeSend: function () {
            $(selectItem).after('<i class="fa fa-spinner fa-spin"></i>');
        },
        complete: function () {
            $(selectItem).next('i.fa-spinner').remove();
        },
        success: function (json) {
            $('#cartProduct' + cartId + ' .price').text(json['price']);
            $('#cartBlock').html(json['totals']);
        }
    });
}

function updateDelivererBlockStatus(itemValue) {
    if (itemValue == "ELSE") {
        $("#flowerForm #deliverer").removeClass("disabled");
        $("#flowerForm #deliverer fieldset > input").removeAttr("readonly");
    } else {
        $("#flowerForm #deliverer").addClass("disabled");
        $("#flowerForm #deliverer fieldset > input").attr("readonly", true);
    }
}
function updateCompanyBlockStatus(item) {
    if ($(item).prop( "checked" )) {
        $("#flowerForm #is_company_block").removeClass("disabled");
        $("#flowerForm #is_company_block fieldset > *").removeAttr("readonly");
    } else {
        $("#flowerForm #is_company_block").addClass("disabled");
        $("#flowerForm #is_company_block fieldset > *").attr("readonly", true);
    }
}
