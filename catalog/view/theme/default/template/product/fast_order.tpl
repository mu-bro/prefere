<script src="catalog/view/javascript/jquery/jqBootstrapValidation.js" type="text/javascript"></script>
<div class="modal fade" id="fastorder" tabindex="-1" role="dialog" aria-labelledby="fastorderLabel">
    <div class="modal-dialog modal-lg" role="document">

        <!-- StartModalContent -->
        <div class="modal-content">

            <!-- ModalHeadStart -->
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title text-overflow annabelle" id="fastorderLabel"><?php echo $heading_title; ?></h4>
            </div>
            <!-- ModalHeadEnd -->

            <!-- StartModalBody -->
            <div class="modal-body">

                <!-- FormStart -->
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="row">

                                    <!-- StartProductInfo -->
                                    <div class="col-md-6">
                                        <div class="row">
                                            <div class="col-md-12 fast-order-thumb">
                                                <img class="img-responsive" src="<?php echo $thumb; ?>">
                                            </div>
                                        </div>
                                        <div class="row">

                                            <!-- StartProductDesc -->
                                            <div class="col-md-12 fast-order-desc">
                                                <?php echo $description; ?>
                                            </div>
                                            <!-- EndProductDesc -->

                                        </div>
                                    </div>
                                    <!-- EndProductInfo -->
                                    <form name="sentMessage" id="contactForm" novalidate>
                                    <!-- StartFiedld -->
                                    <div class="col-md-6 well">
                                        <div class="control-group">
                                            <div class="controls">
                                                <input type="hidden"
                                                       class="form-control"
                                                       value="<?php echo $heading_title; ?>"
                                                       id="foproduct"/>
                                            </div>
                                        </div>

                                        <div class="control-group">
                                            <div class="controls">
                                                <input type="hidden"
                                                       class="form-control"
                                                       value="<?php echo $product_id; ?>"
                                                       id="foprouctid"/>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <div class="controls">
                                                <div class="input-group">
                                                    <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                                    <input type="text"
                                                           class="form-control"
                                                           placeholder="<?php echo $entry_fo_name; ?>"
                                                           value="<?php echo $customer['name']; ?>"
                                                           id="name"
                                                           required
                                                           data-validation-required-message="<?php echo $entry_fo_name_error; ?>"/>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="control-group">
                                            <div class="controls">
                                                <div class="input-group">
                                                    <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
                                                    <input type="email" class="form-control"
                                                           value="<?php echo $customer['email']; ?>"
                                                           placeholder="Email" id="email"/>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="control-group">
                                            <div class="controls">
                                                <div class="input-group">
                                                    <span class="input-group-addon"><i class="glyphicon glyphicon-phone"></i></span>
                                                    <input type="phone"
                                                           class="form-control telephone_form"
                                                           placeholder="<?php echo $entry_fo_phone; ?>"
                                                           value="<?php echo $customer['phone']; ?>"
                                                           id="phone"
                                                           required
                                                           data-validation-required-message="<?php echo $entry_fo_phone_error; ?>"/>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="control-group">
                                            <div class="controls">
                                                <textarea rows="10"
                                                          cols="100"
                                                          class="form-control"
                                                          placeholder="<?php echo $entry_fo_message; ?>"
                                                          id="message"
                                                          maxlength="999"
                                                          style="resize:none"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- EndField -->
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- StartModalFooter -->
                    <div class="modal-footer">
                        <div id="success"></div>
                        <button type="button" class="btn btn-primary" data-dismiss="modal"><?php echo $entry_fo_close; ?></button>
                        <button type="button" onclick="$('#contactForm').submit();" class="btn btn-primary pull-right"><?php echo $entry_fo_send;
                            ?></button>
                    </div>
                    <!-- EndModalFooter -->

                <!-- FormEnd -->

            </div>
            <!-- EndModalBody -->

        </div>
        <!-- EndModalContent -->

    </div>
</div>
<!-- Modal -->
<style type="text/css">
    .fast-order-thumb {
        text-align:center;
    }

    .fast-order-ul {
        text-align:center;
    }

    .text-overflow {
        overflow:hidden;
        white-space:nowrap;
        word-wrap:normal;
        text-overflow:ellipsis;
    }
</style>

<script type="text/javascript">
    $(function () {

        $("#fastorder input,#fastorder textarea").jqBootstrapValidation(
            {
                preventSubmit: true,
                submitSuccess: function ($form, event) {
                    event.preventDefault();
                    var foproduct = $("input#foproduct").val();
                    var foproductid = $("input#foprouctid").val();
                    var name = $("input#name").val();
                    var email = $("input#email").val();
                    var phone = $("input#phone").val();
                    var message = $("textarea#message").val();
                    var firstName = name;
                    if (firstName.indexOf(' ') >= 0) {
                        firstName = name.split(' ').slice(0, -1).join(' ');
                    }
                    $.ajax({
                        url: "index.php?route=product/product/fastorder",
                        type: "POST",
                        data: {
                            foproduct: foproduct,
                            foproductid: foproductid,
                            name: name,
                            email: email,
                            phone: phone,
                            message: message
                        },
                        dataType: 'json',
                        cache: false,
                        success: function (json) {
                            if (json['success']) {
                                $('#success').html("<div class='alert alert-success'>");
                                $('#success > .alert-success').html("<button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;")
                                    .append("</button>");
                                $('#success > .alert-success')
                                    .append("<?php echo $entry_fo_send_success; ?>");
                                $('#success > .alert-success')
                                    .append('</div>');

                         //       $('#contactForm').trigger("reset");
                            } else {
                                $('#success').html("<div class='alert alert-danger'>");
                                $('#success > .alert-danger').html("<button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;")
                                    .append("</button>");
                                $('#success > .alert-danger').append("<?php echo $entry_fo_send_error; ?>");
                                $('#success > .alert-danger').append('</div>');
                            }
                        },
                        error: function () {
                            $('#success').html("<div class='alert alert-danger'>");
                            $('#success > .alert-danger').html("<button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;")
                                .append("</button>");
                            $('#success > .alert-danger').append("<?php echo $entry_fo_send_error; ?>");
                            $('#success > .alert-danger').append('</div>');
                        }
                    })
                },
                filter: function () {
                    return $(this).is(":visible");
                }
            });

        $("a[data-toggle=\"tab\"]").click(function (e) {
            e.preventDefault();
            $(this).tab("show");
        });
    });
    $(function () {
        $.mask.definitions['x'] = '[0-9]';
        $('.telephone_form').mask("<?php echo $config_telephone_mask; ?>", {placeholder: "_"});
    });

    /*When clicking on Full hide fail/success boxes */
    $('#name').focus(function () {
        $('#success').html('');
    });
    </script>