<?php foreach ($options as $option) { ?>
    <div class="col-lg-6 col-md-12 col-sm-12 col-xs-12 optionBlock">
        <?php if ($option['type'] == 'select') { ?>
            <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                <label class="control-label"
                       for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?>:</label>
                <select name="option[<?php echo $option['product_option_id']; ?>]"
                        id="input-option<?php echo $option['product_option_id']; ?>"
                        class="form-control optionInput">
                    <option value=""><?php echo $text_select; ?></option>
                    <?php foreach ($option['product_option_value'] as $option_value) { ?>
                        <option value="<?php echo $option_value['product_option_value_id']; ?>" rel="<?php echo $option_value['price_plane']; ?>">
                            <?php echo $option_value['name']; ?>
                            <?php if (false && $option_value['price']) { ?>
                                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                            <?php } ?>
                        </option>
                    <?php } ?>
                </select>
            </div>
        <?php } ?>
        <?php if ($option['type'] == 'radio') { ?>
            <?php if (false && $option['special_type'] == 'size') { ?>
                <div class="row sizeOptions" id="input-option<?php echo $option['product_option_id']; ?>">
                    <?php
                    $columns = ceil(12 / count($option['product_option_value']));
                    $columns = ($columns > 4) ? 4 : $columns;
                    foreach ($option['product_option_value'] as $option_value) { ?>
                        <div class="<?php echo "col-lg-$columns col-md-$columns col-sm-$columns col-xs-6"; ?>">
                            <div class="sizeOption">
                                <div class="checkIcon"></div>
                                <img src="<?php echo $option_value['image']; ?>"/>

                                <div class="title">
                                    <?php echo $text_size_title; ?><br/>
                                    <?php echo $option_value['name']; ?>
                                </div>
                                <div class="price">
                                    <?php echo $option_value['price']; ?>
                                </div>

                                <div class="descr">
                                    <?php echo ${'text_option_descr_' . $option_value['option_value_id']}; ?>
                                </div>
                                <input rev="<?php echo $option_value['value_image_thumb']; ?>"
                                       rel="<?php echo $option_value['value_image_popup']; ?>"
                                       type="radio"
                                       name="option[<?php echo $option['product_option_id']; ?>]"
                                       value="<?php echo $option_value['product_option_value_id']; ?>"/>
                            </div>
                        </div>
                    <?php } ?>
                </div>

            <?php } elseif (false && $option['special_type'] == 'color') { ?>
                <div class=" row colorOptions">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <label class="control-label"
                               for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $text_choose_color; ?></label>
                        <select class="selectpicker"
                                name="option[<?php echo $option['product_option_id']; ?>]"
                                id="input-option<?php echo $option['product_option_id']; ?>"
                                class="form-control">
                            <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                <option rev="<?php echo $option_value['value_image_thumb']; ?>"
                                        rel="<?php echo $option_value['value_image_popup']; ?>"
                                        value="<?php echo $option_value['product_option_value_id']; ?>"
                                        data-content="<img src='<?php echo $option_value['image']; ?>' />"></option>
                            <?php } ?>
                        </select>
                    </div>
                </div>
            <?php } else { ?>
                <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label"><?php echo $option['name']; ?>:</label>
                    <div class="optionInput" id="input-option<?php echo $option['product_option_id']; ?>">
                        <?php foreach ($option['product_option_value'] as $option_value) { ?>
                            <div class="radio">
                                <label>
                                    <input type="radio"
                                           name="option[<?php echo $option['product_option_id']; ?>]"
                                           rel="<?php echo $option_value['price_plane']; ?>"
                                           value="<?php echo $option_value['product_option_value_id']; ?>"
                                        />
                                    <?php echo $option_value['name']; ?>
                                    <?php if (false && $option_value['price']) { ?>
                                        (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                    <?php } ?>
                                </label>
                            </div>
                        <?php } ?>
                    </div>
                </div>
            <?php } ?>
        <?php } ?>
        <?php if ($option['type'] == 'checkbox') { ?>
            <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                <label class="control-label"><?php echo $option['name']; ?>:</label>
                <div class="optionInput" id="input-option<?php echo $option['product_option_id']; ?>">
                    <?php foreach ($option['product_option_value'] as $option_value) { ?>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox"
                                       name="option[<?php echo $option['product_option_id']; ?>][]"
                                       rel="<?php echo $option_value['price_plane']; ?>"
                                       value="<?php echo $option_value['product_option_value_id']; ?>"
                                    />
                                <?php echo $option_value['name']; ?>
                                <?php if (false && $option_value['price']) { ?>
                                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                <?php } ?>
                            </label>
                        </div>
                    <?php } ?>
                </div>
            </div>
        <?php } ?>
        <?php if ($option['type'] == 'image') { ?>
            <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                <label class="control-label"><?php echo $option['name']; ?></label>

                <div id="input-option<?php echo $option['product_option_id']; ?>">
                    <?php foreach ($option['product_option_value'] as $option_value) { ?>
                        <div class="radio">
                            <label>
                                <input type="radio"
                                       name="option[<?php echo $option['product_option_id']; ?>]"
                                       value="<?php echo $option_value['product_option_value_id']; ?>"/>
                                <img src="<?php echo $option_value['image']; ?>"
                                     alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>"
                                     class="img-thumbnail"/> <?php echo $option_value['name']; ?>
                                <?php if (false && $option_value['price']) { ?>
                                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                <?php } ?>
                            </label>
                        </div>
                    <?php } ?>
                </div>
            </div>
        <?php } ?>
        <?php if ($option['type'] == 'text') { ?>
            <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                <label class="control-label"
                       for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                <input type="text"
                       name="option[<?php echo $option['product_option_id']; ?>]"
                       value="<?php echo $option['value']; ?>"
                       placeholder="<?php echo $option['name']; ?>"
                       id="input-option<?php echo $option['product_option_id']; ?>"
                       class="form-control"/>
            </div>
        <?php } ?>
        <?php if ($option['type'] == 'textarea') { ?>
            <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                <label class="control-label"
                       for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                        <textarea name="option[<?php echo $option['product_option_id']; ?>]"
                                                  rows="5"
                                                  placeholder="<?php echo $option['name']; ?>"
                                                  id="input-option<?php echo $option['product_option_id']; ?>"
                                                  class="form-control"><?php echo $option['value']; ?></textarea>
            </div>
        <?php } ?>
        <?php if ($option['type'] == 'file') { ?>
            <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                <label class="control-label"><?php echo $option['name']; ?></label>
                <button type="button"
                        id="button-upload<?php echo $option['product_option_id']; ?>"
                        data-loading-text="<?php echo $text_loading; ?>"
                        class="btn btn-default btn-block">
                    <i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
                <input type="hidden"
                       name="option[<?php echo $option['product_option_id']; ?>]"
                       value=""
                       id="input-option<?php echo $option['product_option_id']; ?>"/>
            </div>
        <?php } ?>
        <?php if ($option['type'] == 'date') { ?>
            <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                <label class="control-label"
                       for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>

                <div class="input-group date">
                    <input type="text"
                           name="option[<?php echo $option['product_option_id']; ?>]"
                           value="<?php echo $option['value']; ?>"
                           data-date-format="YYYY-MM-DD"
                           id="input-option<?php echo $option['product_option_id']; ?>"
                           class="form-control"/>
                <span class="input-group-btn">
                <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                </span></div>
            </div>
        <?php } ?>
        <?php if ($option['type'] == 'datetime') { ?>
            <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                <label class="control-label"
                       for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>

                <div class="input-group datetime">
                    <input type="text"
                           name="option[<?php echo $option['product_option_id']; ?>]"
                           value="<?php echo $option['value']; ?>"
                           data-date-format="YYYY-MM-DD HH:mm"
                           id="input-option<?php echo $option['product_option_id']; ?>"
                           class="form-control"/>
                <span class="input-group-btn">
                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                </span></div>
            </div>
        <?php } ?>
        <?php if ($option['type'] == 'time') { ?>
            <div class="form-group<?php echo($option['required'] ? ' required' : ''); ?>">
                <label class="control-label"
                       for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>

                <div class="input-group time">
                    <input type="text"
                           name="option[<?php echo $option['product_option_id']; ?>]"
                           value="<?php echo $option['value']; ?>"
                           data-date-format="HH:mm"
                           id="input-option<?php echo $option['product_option_id']; ?>"
                           class="form-control"/>
                                            <span class="input-group-btn">
                                            <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                            </span>
                </div>
            </div>
        <?php } ?>
    </div>
<?php } ?>
<script type="text/javascript"><!--
    $(document).ready(function () {
        $('.optionBlock .optionInput').on('change', function () {
            $.ajax({
                url: 'index.php?route=product/product/price&product_id=<?php echo $product_id; ?>',
                type: 'post',
                dataType: 'json',
                data: $('#product input[type=\'text\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
                success: function (json) {
                    $('#price').text(json['price']);
                    $('#points').text(json['points']);
                }
            });
        });
        $('input[type=radio]').on('change', function() {
            elemName = $(this).attr('name');
            $("#product input[name='" + elemName + "']").parent().removeClass('active');
            $(this).parent().addClass('active');
        });
        $('input[type=checkbox]').on('change', function() {
           $(this).parent().toggleClass('active');
        });

    });
    //--></script>