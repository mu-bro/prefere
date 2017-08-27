<div class="tab-pane" id="tab-option">
    <div class="row">
        <div class="col-sm-2">
            <ul class="nav nav-pills nav-stacked" id="option">
                <?php $option_row = 0; ?>
                <?php foreach ($product_options as $product_option) { ?>
                    <li><a href="#tab-option<?php echo $option_row; ?>"
                           data-toggle="tab"><i class="fa fa-minus-circle"
                                                onclick="$('a[href=\'#tab-option<?php echo $option_row; ?>\']').parent().remove(); $('#tab-option<?php echo $option_row; ?>').remove(); $('#option a:first').tab('show');"></i> <?php echo $product_option['name']; ?>
                        </a></li>
                    <?php $option_row++; ?>
                <?php } ?>
                <li>
                    <input type="text"
                           name="option"
                           value=""
                           placeholder="<?php echo $entry_option; ?>"
                           id="input-option"
                           class="form-control"/>
                </li>
            </ul>
        </div>
        <div class="col-sm-10">
            <div class="tab-content">
                <?php $option_row = 0; ?>
                <?php $option_value_row = 0; ?>
                <?php foreach ($product_options as $product_option) { ?>
                    <div class="tab-pane" id="tab-option<?php echo $option_row; ?>">
                        <input type="hidden"
                               name="product_option[<?php echo $option_row; ?>][product_option_id]"
                               value="<?php echo $product_option['product_option_id']; ?>"/>
                        <input type="hidden"
                               name="product_option[<?php echo $option_row; ?>][name]"
                               value="<?php echo $product_option['name']; ?>"/>
                        <input type="hidden"
                               name="product_option[<?php echo $option_row; ?>][option_id]"
                               value="<?php echo $product_option['option_id']; ?>"/>
                        <input type="hidden"
                               name="product_option[<?php echo $option_row; ?>][type]"
                               value="<?php echo $product_option['type']; ?>"/>

                        <div class="form-group">
                            <label class="col-sm-2 control-label"
                                   for="input-required<?php echo $option_row; ?>"><?php echo $entry_required; ?></label>

                            <div class="col-sm-10">
                                <select name="product_option[<?php echo $option_row; ?>][required]"
                                        id="input-required<?php echo $option_row; ?>"
                                        class="form-control">
                                    <?php if ($product_option['required']) { ?>
                                        <option value="1"
                                                selected="selected"><?php echo $text_yes; ?></option>
                                        <option value="0"><?php echo $text_no; ?></option>
                                    <?php } else { ?>
                                        <option value="1"><?php echo $text_yes; ?></option>
                                        <option value="0"
                                                selected="selected"><?php echo $text_no; ?></option>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>
                        <?php if ($product_option['type'] == 'text') { ?>
                            <div class="form-group">
                                <label class="col-sm-2 control-label"
                                       for="input-value<?php echo $option_row; ?>"><?php echo $entry_option_value; ?></label>

                                <div class="col-sm-10">
                                    <input type="text"
                                           name="product_option[<?php echo $option_row; ?>][value]"
                                           value="<?php echo $product_option['value']; ?>"
                                           placeholder="<?php echo $entry_option_value; ?>"
                                           id="input-value<?php echo $option_row; ?>"
                                           class="form-control"/>
                                </div>
                            </div>
                        <?php } ?>
                        <?php if ($product_option['type'] == 'textarea') { ?>
                            <div class="form-group">
                                <label class="col-sm-2 control-label"
                                       for="input-value<?php echo $option_row; ?>"><?php echo $entry_option_value; ?></label>

                                <div class="col-sm-10">
                                                            <textarea name="product_option[<?php echo $option_row; ?>][value]"
                                                                      rows="5"
                                                                      placeholder="<?php echo $entry_option_value; ?>"
                                                                      id="input-value<?php echo $option_row; ?>"
                                                                      class="form-control"><?php echo $product_option['value']; ?></textarea>
                                </div>
                            </div>
                        <?php } ?>
                        <?php if ($product_option['type'] == 'file') { ?>
                            <div class="form-group" style="display: none;">
                                <label class="col-sm-2 control-label"
                                       for="input-value<?php echo $option_row; ?>"><?php echo $entry_option_value; ?></label>

                                <div class="col-sm-10">
                                    <input type="text"
                                           name="product_option[<?php echo $option_row; ?>][value]"
                                           value="<?php echo $product_option['value']; ?>"
                                           placeholder="<?php echo $entry_option_value; ?>"
                                           id="input-value<?php echo $option_row; ?>"
                                           class="form-control"/>
                                </div>
                            </div>
                        <?php } ?>
                        <?php if ($product_option['type'] == 'date') { ?>
                            <div class="form-group">
                                <label class="col-sm-2 control-label"
                                       for="input-value<?php echo $option_row; ?>"><?php echo $entry_option_value; ?></label>

                                <div class="col-sm-3">
                                    <div class="input-group date">
                                        <input type="text"
                                               name="product_option[<?php echo $option_row; ?>][value]"
                                               value="<?php echo $product_option['value']; ?>"
                                               placeholder="<?php echo $entry_option_value; ?>"
                                               data-date-format="YYYY-MM-DD"
                                               id="input-value<?php echo $option_row; ?>"
                                               class="form-control"/>
                            <span class="input-group-btn">
                            <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                            </span></div>
                                </div>
                            </div>
                        <?php } ?>
                        <?php if ($product_option['type'] == 'time') { ?>
                            <div class="form-group">
                                <label class="col-sm-2 control-label"
                                       for="input-value<?php echo $option_row; ?>"><?php echo $entry_option_value; ?></label>

                                <div class="col-sm-10">
                                    <div class="input-group time">
                                        <input type="text"
                                               name="product_option[<?php echo $option_row; ?>][value]"
                                               value="<?php echo $product_option['value']; ?>"
                                               placeholder="<?php echo $entry_option_value; ?>"
                                               data-date-format="HH:mm"
                                               id="input-value<?php echo $option_row; ?>"
                                               class="form-control"/>
                            <span class="input-group-btn">
                            <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                            </span></div>
                                </div>
                            </div>
                        <?php } ?>
                        <?php if ($product_option['type'] == 'datetime') { ?>
                            <div class="form-group">
                                <label class="col-sm-2 control-label"
                                       for="input-value<?php echo $option_row; ?>"><?php echo $entry_option_value; ?></label>

                                <div class="col-sm-10">
                                    <div class="input-group datetime">
                                        <input type="text"
                                               name="product_option[<?php echo $option_row; ?>][value]"
                                               value="<?php echo $product_option['value']; ?>"
                                               placeholder="<?php echo $entry_option_value; ?>"
                                               data-date-format="YYYY-MM-DD HH:mm"
                                               id="input-value<?php echo $option_row; ?>"
                                               class="form-control"/>
                            <span class="input-group-btn">
                            <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                            </span></div>
                                </div>
                            </div>
                        <?php } ?>
                        <?php if ($product_option['type'] == 'select' || $product_option['type'] == 'radio' || $product_option['type'] == 'checkbox' || $product_option['type'] == 'image') { ?>
                            <div class="table-responsive">
                                <table id="option-value<?php echo $option_row; ?>"
                                       class="table table-striped table-bordered table-hover">
                                    <thead>
                                    <tr>
                                        <td class="text-left"><?php echo $entry_option_value; ?></td>
                                        <td class="text-right"><?php echo $entry_quantity; ?></td>
                                        <td class="text-left"><?php echo $entry_subtract; ?></td>
                                        <td class="text-right"><?php echo $entry_price; ?></td>
                                        <td class="text-right"><?php echo $entry_image; ?></td>
                                        <td></td>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <?php foreach ($product_option['product_option_value'] as $product_option_value) { ?>
                                        <tr id="option-value-row<?php echo $option_value_row; ?>">
                                            <td class="text-left">
                                                <select name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][option_value_id]"
                                                        class="form-control">
                                                    <?php if (isset($option_values[$product_option['option_id']])) { ?>
                                                        <?php foreach ($option_values[$product_option['option_id']] as $option_value) { ?>
                                                            <?php if ($option_value['option_value_id'] == $product_option_value['option_value_id']) { ?>
                                                                <option value="<?php echo $option_value['option_value_id']; ?>"
                                                                        selected="selected"><?php echo $option_value['name']; ?></option>
                                                            <?php } else { ?>
                                                                <option value="<?php echo $option_value['option_value_id']; ?>"><?php echo $option_value['name']; ?></option>
                                                            <?php } ?>
                                                        <?php } ?>
                                                    <?php } ?>
                                                </select>
                                                <input type="hidden"
                                                       name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][product_option_value_id]"
                                                       value="<?php echo $product_option_value['product_option_value_id']; ?>"/>
                                            </td>
                                            <td class="text-right"><input type="text"
                                                                          name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][quantity]"
                                                                          value="<?php echo $product_option_value['quantity']; ?>"
                                                                          placeholder="<?php echo $entry_quantity; ?>"
                                                                          class="form-control"/></td>
                                            <td class="text-left">
                                                <select name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][subtract]"
                                                        class="form-control">
                                                    <?php if ($product_option_value['subtract']) { ?>
                                                        <option value="1"
                                                                selected="selected"><?php echo $text_yes; ?></option>
                                                        <option value="0"><?php echo $text_no; ?></option>
                                                    <?php } else { ?>
                                                        <option value="1"><?php echo $text_yes; ?></option>
                                                        <option value="0"
                                                                selected="selected"><?php echo $text_no; ?></option>
                                                    <?php } ?>
                                                </select></td>
                                            <td class="text-right">
                                                <select name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][price_prefix]"
                                                        class="form-control">
                                                    <?php if ($product_option_value['price_prefix'] == '+') { ?>
                                                        <option value="+" selected="selected">+</option>
                                                    <?php } else { ?>
                                                        <option value="+">+</option>
                                                    <?php } ?>
                                                    <?php if ($product_option_value['price_prefix'] == '-') { ?>
                                                        <option value="-" selected="selected">-</option>
                                                    <?php } else { ?>
                                                        <option value="-">-</option>
                                                    <?php } ?>
                                                </select>
                                                <input type="text"
                                                       name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][price]"
                                                       value="<?php echo $product_option_value['price']; ?>"
                                                       placeholder="<?php echo $entry_price; ?>"
                                                       class="form-control"/></td>
                                            <td class="text-left">
                                                <a href=""
                                                   id="thumb-image-po-<?php echo $option_value_row; ?>"
                                                   data-toggle="image"
                                                   class="img-thumbnail">
                                                    <img src="<?php echo $product_option_value['thumb']; ?>"
                                                         alt=""
                                                         title=""
                                                         data-placeholder="<?php echo $placeholder; ?>"/></a>
                                                <input
                                                    type="hidden"
                                                    name="product_option[<?php echo $option_row; ?>][product_option_value][<?php echo $option_value_row; ?>][image]"
                                                    value="<?php echo $product_option_value['image']; ?>"
                                                    id="input-image-po-<?php echo $option_value_row; ?>"/>
                                            </td>
                                            <td class="text-left">
                                                <button type="button"
                                                        onclick="$(this).tooltip('destroy');$('#option-value-row<?php echo $option_value_row; ?>').remove();"
                                                        data-toggle="tooltip"
                                                        title="<?php echo $button_remove; ?>"
                                                        class="btn btn-danger">
                                                    <i class="fa fa-minus-circle"></i></button>
                                            </td>
                                        </tr>
                                        <?php $option_value_row++; ?>
                                    <?php } ?>
                                    </tbody>
                                    <tfoot>
                                    <tr>
                                        <td colspan="5"></td>
                                        <td class="text-left">
                                            <button type="button"
                                                    onclick="addOptionValue('<?php echo $option_row; ?>');"
                                                    data-toggle="tooltip"
                                                    title="<?php echo $button_option_value_add; ?>"
                                                    class="btn btn-primary">
                                                <i class="fa fa-plus-circle"></i></button>
                                        </td>
                                    </tr>
                                    </tfoot>
                                </table>
                            </div>
                            <select id="option-values<?php echo $option_row; ?>" style="display: none;">
                                <?php if (isset($option_values[$product_option['option_id']])) { ?>
                                    <?php foreach ($option_values[$product_option['option_id']] as $option_value) { ?>
                                        <option value="<?php echo $option_value['option_value_id']; ?>"><?php echo $option_value['name']; ?></option>
                                    <?php } ?>
                                <?php } ?>
                            </select>
                        <?php } ?>
                    </div>
                    <?php $option_row++; ?>
                <?php } ?>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript"><!--
    var option_value_row = <?php echo $option_value_row; ?>;

    function addOptionValue(option_row) {
        html = '<tr id="option-value-row' + option_value_row + '">';
        html += '  <td class="text-left"><select name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][option_value_id]" class="form-control">';
        html += $('#option-values' + option_row).html();
        html += '  </select><input type="hidden" name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][product_option_value_id]" value="" /></td>';
        html += '  <td class="text-right"><input type="text" name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][quantity]" value="" placeholder="<?php echo $entry_quantity; ?>" class="form-control" /></td>';
        html += '  <td class="text-left"><select name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][subtract]" class="form-control">';
        html += '    <option value="1"><?php echo $text_yes; ?></option>';
        html += '    <option value="0"><?php echo $text_no; ?></option>';
        html += '  </select></td>';
        html += '  <td class="text-right"><select name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][price_prefix]" class="form-control">';
        html += '    <option value="+">+</option>';
        html += '    <option value="-">-</option>';
        html += '  </select>';
        html += '  <input type="text" name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][price]" value="" placeholder="<?php echo $entry_price; ?>" class="form-control" /></td>';

        html += '  <td class="text-left"><a href="" id="thumb-image-po-' + option_value_row + '"data-toggle="image" class="img-thumbnail"><img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /><input type="hidden" name="product_option[' + option_row + '][product_option_value][' + option_value_row + '][image]" value="" id="input-image-po-' + option_value_row + '" /></td>';


        html += '  <td class="text-left"><button type="button" onclick="$(this).tooltip(\'destroy\');$(\'#option-value-row' + option_value_row + '\').remove();" data-toggle="tooltip" rel="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
        html += '</tr>';

        $('#option-value' + option_row + ' tbody').append(html);
        $('[rel=tooltip]').tooltip();

        option_value_row++;
    }
    //--></script>