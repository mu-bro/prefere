<div class="delInfo" id="delInfo<?php echo $key; ?>">
    <table width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <td class="vtop" style="width:50%;">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title"><i class="fa fa-user"></i> <?php echo $text_deliverer_info; ?></h3>
                    </div>
                    <table class="table first-bold">
                        <tr>
                            <td style="width: 1%;">
                                <?php echo $title_deliverer; ?>:
                            </td>
                            <td><?php echo ($delInfo['deliverer'] == "ME") ? $text_me : $text_other_deliverer; ?></td>
                        </tr>
                        <?php if ($delInfo['deliverer'] != "ME") { ?>
                            <tr>
                                <td style="width: 1%;">
                                    <?php echo $text_deliver; ?>:
                                </td>
                                <td><?php echo $delInfo['deliver']['name']; ?></td>
                            </tr>
                            <tr>
                                <td>
                                    <?php echo $text_phone; ?>:
                                </td>
                                <td><?php echo $delInfo['deliver']['phone']; ?></td>
                            </tr>
                            <tr>
                                <td>
                                    <?php echo $text_make_suprize; ?>:
                                </td>
                                <td>
                                    <?php if (isset($delInfo['deliver']['surprize'])) { ?>
                                        <i class="fa fa-check-square-o"></i>
                                        <?php echo $text_yes; ?>
                                    <?php } else { ?>
                                        <i class="fa fa-square-o"></i>
                                        <?php echo $text_no; ?>
                                    <?php } ?>
                                </td>
                            </tr>
                        <?php } ?>
                    </table>
                </div>
            </td>
            <td class="vtop">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title"><i class="fa fa-user"></i> <?php echo $text_delivery; ?></h3>
                    </div>

                    <table class="table <?php if ($invoice) echo ' first-bold'; ?>">
                        <tr>
                            <td style="width: 1%;">
                                <?php if ($invoice) { ?>
                                    <?php echo $text_delivery_type; ?>:
                                <?php } else { ?>
                                    <button data-toggle="tooltip" title="<?php echo $text_delivery_type; ?>" class="btn btn-info
                                btn-xs"><i class="fa fa-truck"></i></button>
                                <?php } ?>
                            </td>
                            <td><?php echo $delInfo['shipping_method']['name']; ?></td>
                        </tr>
                        <?php if (isset($delInfo['shipping_method']['info']['city'])) { ?>
                            <tr>
                                <td>
                                    <?php if ($invoice) { ?>
                                        <?php echo $text_city; ?>:
                                    <?php } else { ?>
                                        <button data-toggle="tooltip" title="<?php echo $text_city; ?>"
                                                class="btn btn-info btn-xs">
                                            <i class="fa fa-map-marker"></i></button>
                                    <?php } ?>
                                </td>
                                <td><?php echo $delInfo['shipping_method']['info']['city']; ?></td>
                            </tr>
                        <?php } ?>
                        <?php if (isset($delInfo['shipping_method']['info']['address'])) { ?>
                            <tr>
                                <td>
                                    <?php if ($invoice) { ?>
                                        <?php echo $text_addres; ?>:
                                    <?php } else { ?>
                                        <button data-toggle="tooltip" title="<?php echo $text_addres; ?>"
                                                class="btn btn-info btn-xs">
                                            <i class="fa fa-map-signs"></i></button>
                                    <?php } ?>
                                </td>
                                <td><?php echo $delInfo['shipping_method']['info']['address']; ?></td>
                            </tr>
                        <?php } ?>
                        <tr>
                            <td>
                                <?php if ($invoice) { ?>
                                    <?php echo $delivery_date; ?>:
                                <?php } else { ?>
                                    <button data-toggle="tooltip" title="<?php echo $delivery_date; ?>"
                                            class="btn btn-info btn-xs">
                                        <i class="fa fa-calendar"></i></button>
                                <?php } ?>
                            </td>
                            <td><?php echo $delInfo['shipping_method']['info']['date']; ?></td>
                        </tr>
                        <tr>
                            <td>
                                <?php if ($invoice) { ?>
                                    <?php echo $delivery_time; ?>:
                                <?php } else { ?>
                                    <button data-toggle="tooltip" title="<?php echo $delivery_time; ?>"
                                            class="btn btn-info btn-xs">
                                        <i class="fa fa-clock-o"></i></button>
                                <?php } ?>
                            </td>
                            <td><?php echo $delInfo['shipping_method']['info']['time']; ?></td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <?php if (!empty($delInfo['message'])) { ?>
        <tr>
            <td colspan="2">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title"><i class="fa fa-envelope-o"></i> <?php echo $text_message; ?></h3>
                    </div>
                    <div class="message">
                        <?php echo $delInfo['message']; ?>
                    </div>
                </div>
            </td>
        <tr>
        <?php } ?>

    </table>
</div>
