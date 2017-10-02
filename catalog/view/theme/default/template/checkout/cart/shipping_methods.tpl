<table class="shipping_methods_choice" width="100%">
    <?php foreach ($shipping_methods as $shipCode => $shipping_method) { ?>
        <?php if (!$shipping_method['error']) { ?>
            <?php foreach ($shipping_method['quote'] as $quote) {
                $shortCode = str_replace(".", "_", $quote['code']); ?>
                <tr class="highlight">
                    <td>
                        <input type="radio"
                               rev="<?php echo $shortCode; ?>"
                               name="delInfo[shipping_method][code]"
                               value="<?php echo $quote['code']; ?>"
                               id="<?php echo $quote['code']; ?>"
                            <?php if (isset($delInfo['shipping_method']['code']) && $delInfo['shipping_method']['code'] == $quote['code']) echo 'checked="checked"'; ?>
                            />
                    </td>
                    <td><label class="subTitle"
                               for="<?php echo $quote['code']; ?>"><?php echo $quote['title']; ?></label>
                    </td>
                    <td class="shipPrice"><label
                            for="<?php echo $quote['code']; ?>"><?php echo $quote['text']; ?></label></td>
                </tr>
                <tbody>
                <tr>
                    <td colspan="3">
                        <div id="ship_<?php echo $shortCode; ?>"
                             class="ship shippAdditionalInfo <?php if (isset($delInfo['shipping_method']['code']) && $delInfo['shipping_method']['code'] == $quote['code']) echo 'active'; ?>">
                            <?php if ($quote['code'] != "pickup.pickup") { ?>
                                <?php if ($quote['code'] != "citylink.citylink") { ?>
                                    <input class="form-control" type="text"
                                           name="delInfo[shipping_method][<?php echo $shortCode; ?>][city]"
                                           value="<?php if (isset
                                           ($delInfo['shipping_method'][$shortCode]['city'])) echo $delInfo['shipping_method'][$shortCode]['city']; ?>"
                                           placeholder="* <?php echo $text_city; ?>"/>
                                <?php } ?>
                                <textarea
                                    name="delInfo[shipping_method][<?php echo $shortCode; ?>][address]"
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
                                        <input class="form-control <?php echo ($quote['outOfCity']) ? "outOfCityDate" : "date"; ?>"
                                               type="text"
                                               name="delInfo[shipping_method][<?php echo $shortCode; ?>][date]"
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
                                            name="delInfo[shipping_method][<?php echo $shortCode; ?>][time]">
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