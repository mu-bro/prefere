<h3 style="margin-top: -22px;
text-align: center;
font-style: italic;
font-weight: normal;
font-size: 20px;"><span style="display: inline-block;
background: #FFF;
padding: 0 7px;"><?php echo $title; ?></span></h3>

<table class="table order-details" style="width:100%;" cellpadding="0" cellspacing="0">
    <tr>
        <td style="width:40%;padding-bottom:10px;vertival-align:top;">

            <h2 style="font-size: 16px; text-align:left;color: #000; margin: 0px; padding: 0px; text-transform: uppercase;font-weight:normal;"><?php echo $text_order_detail; ?></h2>
            <table class="table order-details" style="width:100%;">
                <tr>
                    <?php if ($invoice_no) { ?>
                        <td>
                            <b style="font-weight: normal; color: #000;"><?php echo $text_invoice_no; ?></b>
                        </td>
                        <td>
                            <?php echo $invoice_no; ?>
                        </td>
                    <?php } ?>
                </tr>
                <tr>
                    <td>
                        <b style="font-weight: normal; color: #000;"><?php echo $text_order_id; ?></b>
                    </td>
                    <td>
                        <?php echo $order_id; ?>
                    </td>
                </tr>
                <tr>
                    <?php if ($payment_method) { ?>
                        <td>
                            <b style="font-weight: normal; color: #000;"><?php echo $text_payment_method; ?></b>
                        </td>
                        <td>
                            <?php echo $payment_method; ?>
                        </td>
                    <?php } ?>
                </tr>
                <tr>
                    <td>
                        <b style="font-weight: normal; color: #000;"><?php echo $text_date_added; ?></b>
                    </td>
                    <td>
                        <?php echo $date_added; ?>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b style="font-weight: normal; color: #000;"><?php echo $column_status; ?></b>
                    </td>
                    <td>
                        <?php echo $status; ?>
                    </td>
                </tr>

                <?php if ($comment) { ?>
                    <tr>
                        <td colspan="2" class="text-left">
                            <h2 style="font-size: 16px; text-align:left;color: #000; margin: 0px; padding: 0px; text-transform: uppercase;font-weight:normal;"><?php echo $text_comment; ?></h2>

                            <div class="infoText"><?php echo $comment; ?></div>
                        </td>
                    </tr>
                <?php } elseif ($order_comment) { ?>
                    <tr>
                        <td colspan="2" class="text-left">
                            <h3 style="font-size: 13px; text-align:left;color: #000; margin: 0px; padding: 0px; text-transform: uppercase;font-weight:normal;margin-top:10px;"><?php echo $text_comment; ?></h3>

                            <div class="infoText"><?php echo $order_comment; ?></div>
                        </td>
                    </tr>
                <?php } ?>
            </table>
        </td>
        <td style="width:60%;padding-bottom:10px;vertical-align:top">
            <h2 style="font-size: 16px; text-align:left;color: #000; margin: 0px; padding: 0px; text-transform: uppercase;font-weight:normal;"><?php echo $text_total_title; ?></h2>
            <table class="table order-details" style="width:100%;">
                <?php foreach ($totals as $total) { ?>
                    <tr <?php if (isset($total['last'])) echo 'class="last"'; ?> >
                        <td class="text-right"><b style="font-weight: normal; color: #000;"><?php echo $total['title']; ?>
                                :</b></td>
                        <td class="text-right total" style="white-space:nowrap;"><?php echo $total['text']; ?></td>
                    </tr>
                <?php } ?>
            </table>
        </td>
    </tr>
    <?php foreach ($products as $k => $product) {
        $delInfo = $product["delInfo"]; ?>
        <tbody>
        <tr>

            <td style="width:40%;border-top: <?php echo ($k == 0) ? '1px solid #000' : '2px solid #DDD'; ?>;padding-top:10px;vertical-align:top;" class="cartProductInfo">
                <table style="width:100%;">
                    <tr>
                        <td>
                            <?php if ($product['thumb']) { ?>
                                <div class="image">
                                    <a href="<?php echo $product['href']; ?>">
                                        <img style="border-radius: 80px;width: 60px;" src="<?php echo $product['thumb']; ?>"
                                             alt="<?php echo $product['name']; ?>"
                                             title="<?php echo $product['name']; ?>"/>
                                    </a>
                                </div>
                            <?php } ?>
                        </td>
                        <td style="vertical-align:top;">
                            <div class="title">
                                <a style="font-size: 13px;color: #000;text-decoration: none;" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>

                                <div>
                                    <?php foreach ($product['option'] as $option) { ?>
                                        <small><?php echo $option['name']; ?>
                                            : <?php echo $option['value']; ?></small>
                                        <br/>
                                    <?php } ?>
                                </div>
                                <div style="font-size: 13px;color: #000;margin-top:4px;" class="price">
                                    <?php echo $product['total']; ?>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="padding-bottom:10px;">
                            <h3 style="font-size: 13px; text-align:left;color: #000; margin: 0px; padding: 0px; text-transform: uppercase;font-weight:normal;margin-top:10px;"><?php echo $text_flower_message; ?></h3>
                            <div class="infoText"><?php echo $delInfo['message']; ?></div>
                        </td>
                    </tr>
                </table>


            </td>
            <td style="width:40%;border-top: <?php echo ($k == 0) ? '1px solid #000' : '2px solid #DDD'; ?>;padding-top:10px;vertical-align:top;" class="cartProductInfo">
                <?php
                $index = $k;
                include "catalog/view/theme/default/template/mail/flowerFormInvoice.tpl"; ?>
            </td>
        </tr>
        </tbody>
    <?php } ?>
</table>
</div>
