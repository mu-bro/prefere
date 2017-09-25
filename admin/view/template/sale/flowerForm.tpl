<div class="row">
    <div class="col-md-4">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-shopping-cart"></i> <?php echo $text_order_detail; ?></h3>
            </div>
            <table class="table">
                <tbody>
                <tr>
                    <td style="width: 1%;">
                        <button data-toggle="tooltip" title="<?php echo $text_store; ?>" class="btn btn-info btn-xs"><i
                                class="fa fa-shopping-cart fa-fw"></i></button>
                    </td>
                    <td><a href="<?php echo $store_url; ?>" target="_blank"><?php echo $store_name; ?></a></td>
                </tr>
                <tr>
                    <td>
                        <button data-toggle="tooltip" title="<?php echo $text_date_added; ?>" class="btn btn-info btn-xs">
                            <i class="fa fa-calendar fa-fw"></i></button>
                    </td>
                    <td><?php echo $date_added; ?></td>
                </tr>
                <tr>
                    <td>
                        <button data-toggle="tooltip" title="<?php echo $text_payment_method; ?>"
                                class="btn btn-info btn-xs"><i class="fa fa-credit-card fa-fw"></i></button>
                    </td>
                    <td><?php echo $payment_method; ?></td>
                </tr>
                <?php if ($shipping_method) { ?>
                    <tr>
                        <td>
                            <button data-toggle="tooltip" title="<?php echo $text_shipping_method; ?>"
                                    class="btn btn-info btn-xs"><i class="fa fa-truck fa-fw"></i></button>
                        </td>
                        <td><?php echo $shipping_method; ?></td>
                    </tr>
                <?php } ?>
                </tbody>
            </table>
        </div>
    </div>
    <div class="col-md-4">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-user"></i> <?php echo $text_customer_detail; ?></h3>
            </div>
            <table class="table">
                <tr>
                    <td style="width: 1%;">
                        <button data-toggle="tooltip" title="<?php echo $text_customer; ?>" class="btn btn-info btn-xs"><i
                                class="fa fa-user fa-fw"></i></button>
                    </td>
                    <td><?php if ($customer) { ?>
                            <a href="<?php echo $customer; ?>"
                               target="_blank"><?php echo $firstname; ?> <?php echo $lastname; ?></a>
                        <?php } else { ?>
                            <?php echo $firstname; ?> <?php echo $lastname; ?>
                        <?php } ?></td>
                </tr>
                <tr>
                    <td>
                        <button data-toggle="tooltip" title="<?php echo $text_email; ?>" class="btn btn-info btn-xs"><i
                                class="fa fa-envelope-o fa-fw"></i></button>
                    </td>
                    <td><a href="mailto:<?php echo $email; ?>"><?php echo $email; ?></a></td>
                </tr>
                <tr>
                    <td>
                        <button data-toggle="tooltip" title="<?php echo $text_telephone; ?>" class="btn btn-info btn-xs">
                            <i class="fa fa-phone fa-fw"></i></button>
                    </td>
                    <td><?php echo $telephone; ?></td>
                </tr>
            </table>
        </div>
    </div>
    <div class="col-md-4">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-cog"></i> <?php echo $text_option; ?></h3>
            </div>
            <table class="table">
                <tbody>
                <tr>
                    <td><?php echo $text_invoice; ?></td>
                    <td id="invoice" class="text-right"><?php echo $invoice_no; ?></td>
                    <td style="width: 1%;" class="text-center"><?php if (!$invoice_no) { ?>
                            <button id="button-invoice" data-loading-text="<?php echo $text_loading; ?>"
                                    data-toggle="tooltip" title="<?php echo $button_generate; ?>"
                                    class="btn btn-success btn-xs"><i class="fa fa-cog"></i></button>
                        <?php } else { ?>
                            <button disabled="disabled" class="btn btn-success btn-xs"><i class="fa fa-refresh"></i>
                            </button>
                        <?php } ?></td>
                </tr>
                <tr>
                    <td><?php echo $text_reward; ?></td>
                    <td class="text-right"><?php echo $reward; ?></td>
                    <td class="text-center"><?php if ($customer && $reward) { ?>
                            <?php if (!$reward_total) { ?>
                                <button id="button-reward-add" data-loading-text="<?php echo $text_loading; ?>"
                                        data-toggle="tooltip" title="<?php echo $button_reward_add; ?>"
                                        class="btn btn-success btn-xs"><i class="fa fa-plus-circle"></i></button>
                            <?php } else { ?>
                                <button id="button-reward-remove" data-loading-text="<?php echo $text_loading; ?>"
                                        data-toggle="tooltip" title="<?php echo $button_reward_remove; ?>"
                                        class="btn btn-danger btn-xs"><i class="fa fa-minus-circle"></i></button>
                            <?php } ?>
                        <?php } else { ?>
                            <button disabled="disabled" class="btn btn-success btn-xs"><i class="fa fa-plus-circle"></i>
                            </button>
                        <?php } ?></td>
                </tr>
                <tr>
                    <td><?php echo $text_affiliate; ?>
                        <?php if ($affiliate) { ?>
                            (
                            <a href="<?php echo $affiliate; ?>"><?php echo $affiliate_firstname; ?> <?php echo $affiliate_lastname; ?></a>)
                        <?php } ?></td>
                    <td class="text-right"><?php echo $commission; ?></td>
                    <td class="text-center"><?php if ($affiliate) { ?>
                            <?php if (!$commission_total) { ?>
                                <button id="button-commission-add" data-loading-text="<?php echo $text_loading; ?>"
                                        data-toggle="tooltip" title="<?php echo $button_commission_add; ?>"
                                        class="btn btn-success btn-xs"><i class="fa fa-plus-circle"></i></button>
                            <?php } else { ?>
                                <button id="button-commission-remove" data-loading-text="<?php echo $text_loading; ?>"
                                        data-toggle="tooltip" title="<?php echo $button_commission_remove; ?>"
                                        class="btn btn-danger btn-xs"><i class="fa fa-minus-circle"></i></button>
                            <?php } ?>
                        <?php } else { ?>
                            <button disabled="disabled" class="btn btn-success btn-xs"><i class="fa fa-plus-circle"></i>
                            </button>
                        <?php } ?></td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-4">
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
                    <tr>
                        <td>
                            <?php echo $text_is_anonymous; ?>:
                        </td>
                        <td>
                            <?php if (isset($delInfo['deliver']['anonymous'])) { ?>
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
    </div>
    <div class="col-md-4">
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

                </tr>
                <tr>
                    <td colspan="2">
                        <table cellpadding="0" cellspacing="0" width="100%">
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
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <?php if (!empty($delInfo['message'])) { ?>
        <div class="col-md-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="fa fa-envelope-o"></i> <?php echo $text_message; ?></h3>
                </div>
                <div class="message">
                    <?php echo $delInfo['message']; ?>
                </div>
            </div>
        </div>
    <?php } ?>
</div>
<div class="row">
    <?php if (isset($delInfo['company']) && isset($delInfo['company']['is_company'])) { ?>
        <div class="col-md-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="fa fa-user"></i> <?php echo $text_company_info; ?></h3>
                </div>
                <table class="table first-bold">
                    <tr>
                        <td style="width: 1%;">
                            <?php if ($invoice) { ?>
                                <?php echo $text_company_name; ?>:
                            <?php } else { ?>
                                <button data-toggle="tooltip" title="<?php echo $text_company_name; ?>"
                                        class="btn btn-info btn-xs">
                                    <i class="fa fa-users"></i></button>
                            <?php } ?>
                        </td>
                        <td><?php echo $delInfo['company']['name']; ?></td>
                    </tr>
                    <tr>
                        <td>
                            <?php if ($invoice) { ?>
                                <?php echo $text_company_inn; ?>:
                            <?php } else { ?>
                                <button data-toggle="tooltip" title="<?php echo $text_company_inn; ?>"
                                        class="btn btn-info btn-xs">
                                    <i class="fa fa-bank"></i></button>
                            <?php } ?>
                        </td>
                        <td><?php echo $delInfo['company']['inn']; ?></td>
                    </tr>
                    <tr>
                        <td style="width: 1%;">
                            <?php if ($invoice) { ?>
                                <?php echo $text_company_inn2; ?>:
                            <?php } else { ?>
                                <button data-toggle="tooltip" title="<?php echo $text_company_inn2; ?>"
                                        class="btn btn-info btn-xs">
                                    <i class="fa fa-university"></i></button>
                            <?php } ?>
                        </td>
                        <td><?php echo $delInfo['company']['inn2']; ?></td>
                    </tr>
                    <tr>
                        <td>
                            <?php if ($invoice) { ?>
                                <?php echo $text_company_address; ?>:
                            <?php } else { ?>
                                <button data-toggle="tooltip" title="<?php echo $text_company_address; ?>"
                                        class="btn btn-info btn-xs">
                                    <i class="fa fa-address-card-o"></i></button>
                            <?php } ?>
                        </td>
                        <td><?php echo $delInfo['company']['address']; ?></td>
                    </tr>
                </table>
            </div>
        </div>
    <?php } ?>
</div>