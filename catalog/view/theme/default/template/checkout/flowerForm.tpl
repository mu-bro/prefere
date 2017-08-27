<div class="delInfo" id="delInfo<?php echo $key; ?>" rel="<?php echo $key; ?>">
    <h2><?php echo $title_deliver_info; ?></h2>

    <div class="row">
        <div class="col-lg-6">
            <h3><?php echo $title_deliverer; ?></h3>

            <div class="chooseBlock" id="chooseBlock_<?php echo $key; ?>" rel="<?php echo $key; ?>">
                <div>
                    <input type="radio" name="delInfo[<?php echo $key; ?>][deliverer]" value="ME"
                           id="deliverer_me_<?php echo $key; ?>"
                        <?php if (isset($delInfo['deliverer']) && $delInfo['deliverer'] == "ME") echo 'checked="checked"'; ?>
                        >
                    <label class="subTitle" for="deliverer_me_<?php echo $key; ?>"><?php echo $text_me; ?></label>
                </div>
                <div>
                    <input type="radio" name="delInfo[<?php echo $key; ?>][deliverer]" value="ELSE"
                           id="deliverer_else_<?php echo $key; ?>"
                        <?php if (isset($delInfo['deliverer']) && $delInfo['deliverer'] == "ELSE") echo 'checked="checked"'; ?>
                        />
                    <label class="subTitle"
                           for="deliverer_else_<?php echo $key; ?>"><?php echo $text_other_deliverer; ?></label>
                </div>
            </div>
            <?php if ($index == 0) { ?>
                <div id="customer_block">
                    <h3><?php echo $text_customer; ?></h3>
                    <input class="form-control" type="text" id="" name="customer[name]"
                           placeholder="* <?php echo $text_name; ?>"
                           value="<?php echo $customerInfo['name']; ?>"/>
                    <input class="form-control" type="text" name="customer[email]" placeholder="* <?php echo $text_email; ?>"
                           value="<?php echo $customerInfo['email']; ?>"/>
                    <input type="text" name="customer[phone]" placeholder="* <?php echo $text_phone; ?>"
                           value="<?php echo $customerInfo['phone']; ?>" class="telephone_form form-control"/>
                    <?php if (!$isLogged) { ?>
                        <input type="checkbox" name="customer[createAccount]" value="Y" id="create_account">
                        <label for="create_account"><?php echo $text_create_account; ?></label>
                        <div id="passwordBlock" class="hiddenBlock">
                            <input class="form-control" type="password" name="customer[password]"
                                   placeholder="<?php echo $text_password; ?>"/>
                            <input class="form-control" type="password" name="customer[confirm_password]"
                                   placeholder="<?php echo $text_confirm_password; ?>"/>
                        </div>
                    <?php } ?>
                </div>
            <?php } ?>
            <div class="deliverer <?php if (!isset($delInfo['deliverer']) || $delInfo['deliverer'] != "ELSE") echo
            'hiddenBlock'; ?>"
                 id="deliverer_<?php echo $key;
                 ?>">
                <h3><?php echo $text_deliver; ?></h3>
                <input class="form-control" type="text" name="delInfo[<?php echo $key; ?>][deliver][name]"
                       placeholder="* <?php echo $text_name; ?>"
                       value="<?php echo $delInfo['deliver']['name']; ?>"/>
                <input class="form-control telephone_form" type="text" name="delInfo[<?php echo $key; ?>][deliver][phone]"
                       placeholder="* <?php echo $text_phone; ?>"
                       value="<?php echo $delInfo['deliver']['phone']; ?>"/>
                <input type="checkbox" name="delInfo[<?php echo $key; ?>][deliver][surprize]" value="Y"
                       id="create_surprize_<?php echo $key; ?>"
                    <?php if (isset($delInfo['deliver']['surprize']) && $delInfo['deliver']['surprize'] == "Y") echo 'checked="checked"'; ?> />
                <label for="create_surprize_<?php echo $key; ?>"><?php echo $text_make_suprize; ?></label>
            </div>
        </div>
        <div class="col-lg-6">
            <h3 id="shipping_method_title_<?php echo $key; ?>"><?php echo $text_where_to_deliver; ?></h3>
            <table class="shipping_methods_choice" width="100%">
                <?php foreach ($shipping_methods as $shipCode => $shipping_method) { ?>
                    <?php if (!$shipping_method['error']) { ?>
                        <?php foreach ($shipping_method['quote'] as $quote) {
                            $shortCode = str_replace(".", "_", $quote['code']); ?>
                            <tr class="highlight">
                                <td>
                                    <input type="radio" rel="<?php echo $key; ?>"
                                           rev="<?php echo $shortCode; ?>"
                                           name="delInfo[<?php echo $key;
                                           ?>][shipping_method][code]"
                                           value="<?php echo $quote['code']; ?>"
                                           id="<?php echo $key; ?>_<?php echo $quote['code']; ?>"
                                        <?php if (isset($delInfo['shipping_method']['code']) && $delInfo['shipping_method']['code'] == $quote['code']) echo 'checked="checked"'; ?>
                                        />
                                </td>
                                <td><label class="subTitle"
                                           for="<?php echo $key; ?>_<?php echo $quote['code']; ?>"><?php echo $quote['title']; ?></label>
                                </td>
                                <td class="shipPrice"><label
                                        for="<?php echo $quote['code']; ?>"><?php echo $quote['text']; ?></label></td>
                            </tr>
                            <tbody>
                            <tr>
                                <td colspan="3">
                                    <div id="ship_<?php echo $key; ?>_<?php echo $shortCode; ?>"
                                         class="ship_<?php echo $key; ?> shippAdditionalInfo <?php if (isset($delInfo['shipping_method']['code']) && $delInfo['shipping_method']['code'] == $quote['code']) echo 'active'; ?>">
                                        <?php if ($quote['code'] != "pickup.pickup") { ?>
                                            <?php if ($quote['code'] != "citylink.citylink") { ?>
                                                <input class="form-control" type="text"
                                                       name="delInfo[<?php echo $key; ?>][shipping_method][<?php echo $shortCode; ?>][city]"
                                                       value="<?php if (isset
                                                       ($delInfo['shipping_method'][$shortCode]['city'])) echo $delInfo['shipping_method'][$shortCode]['city']; ?>"
                                                       placeholder="* <?php echo $text_city; ?>"/>
                                            <?php } ?>
                                            <textarea
                                                name="delInfo[<?php echo $key; ?>][shipping_method][<?php echo $shortCode; ?>][address]"
                                                class="form-control"
                                                placeholder="* <?php echo $text_addres; ?>"><?php if (isset
                                                ($delInfo['shipping_method'][$shortCode]['address'])) echo $delInfo['shipping_method'][$shortCode]['address']; ?></textarea>
                                        <?php } ?>
                                        <div class="row">
                                            <div class="col-lg-5">
                                                <label><?php echo $delivery_date; ?>:</label>
                                            </div>
                                            <div class="col-lg-7">
                                                <div class="input-group datePickerGroup">
                                                    <input class="form-control <?php echo $product['preorder'] ? "datePreOrder" : "date"; ?>" type="text"
                                                           name="delInfo[<?php echo $key; ?>][shipping_method][<?php echo $shortCode; ?>][date]"
                                                           data-date-format="DD.MM.YYYY"
                                                           value="<?php
                                                           echo (isset($delInfo['shipping_method'][$shortCode]['date'])) ? $delInfo['shipping_method'][$shortCode]['date'] : $defaultDate; ?>"
                                                           placeholder="DD.MM.YYYY"/>
                                                <span class="input-group-btn">
                                                    <button type="button" class="btn btn-default"><i class="fa
                                                    fa-calendar"></i></button>
                                                </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row <?php if ($quote['code'] == "flat.flat") echo "hidden"; ?>">
                                            <div class="col-lg-5">
                                                <label><?php echo $delivery_time; ?>:</label>
                                            </div>
                                            <div class="col-lg-7">
                                                <select class="form-control"
                                                        name="delInfo[<?php echo $key; ?>][shipping_method][<?php echo $shortCode; ?>][time]">
                                                    <?php foreach ($deliver_frames as $frame) { ?>
                                                        <option value="<?php echo $frame; ?>"><?php echo $frame; ?></option>
                                                    <?php } ?>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            </tbody>

                        <?php } ?>
                    <?php } else { ?>
                        <tr>
                            <td colspan="3">
                                <div class="error"><?php echo $shipping_method['error']; ?></div>
                            </td>
                        </tr>
                    <?php } ?>
                <?php } ?>
            </table>
        </div>
    </div>
    <?php if ($index == 0 && count($products) > 1) { ?>
        <div class="row copyInfo">
            <div class="col-lg-12">
                <span class="copyInfoBlock" onclick="copyFlowerInfo('<?php echo $key; ?>');">
                    <i class="fa fa-spinner fa-spin"></i>
                    <i class="fa fa-check-square-o"></i>
                    <i class="fa fa-square-o"></i>
                    <label for="copyInfoButton<?php echo $key; ?>"><?php echo $text_apply_for_all_flowers; ?></label>
                </span>
            </div>
        </div>
    <?php } ?>
</div>
