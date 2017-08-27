<h3><span><?php echo $heading_title; ?></span></h3>

<div class="delInfo cartBlock">
    <div class="row">
        <div class="col-lg-5">
            <h2 class="order-details-title"><?php echo $text_order_detail; ?></h2>
            <table class="table order-details">
                <tr>
                    <?php if ($invoice_no) { ?>
                        <td>
                            <b><?php echo $text_invoice_no; ?></b>
                        </td>
                        <td>
                            <?php echo $invoice_no; ?>
                        </td>
                    <?php } ?>
                </tr>
                <tr>
                    <td>
                        <b><?php echo $text_order_id; ?></b>
                    </td>
                    <td>
                        <?php echo $order_id; ?>
                    </td>
                </tr>
                <tr>
                    <?php if ($payment_method) { ?>
                        <td>
                            <b><?php echo $text_payment_method; ?></b>
                        </td>
                        <td>
                            <?php echo $payment_method; ?>
                        </td>
                    <?php } ?>
                </tr>
                <tr>
                    <td>
                        <b><?php echo $text_date_added; ?></b>
                    </td>
                    <td>
                        <?php echo $date_added; ?>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b><?php echo $column_status; ?></b>
                    </td>
                    <td>
                        <?php echo $status; ?>
                    </td>
                </tr>

                <?php if ($comment) { ?>
                    <tr>
                        <td colspan="2" class="text-left">
                            <h3><?php echo $text_comment; ?></h3>

                            <div class="infoText"><?php echo $comment; ?></div>
                        </td>
                    </tr>
                <?php } ?>
            </table>
        </div>
        <div class="col-lg-7">
            <h2 class="order-details-title"><?php echo $text_total_title; ?></h2>
            <table class="table order-details">
                <?php foreach ($totals as $total) { ?>
                    <tr <?php if (isset($total['last'])) echo 'class="last"'; ?> >
                        <td class="text-right"><b><?php echo $total['title']; ?>:</b></td>
                        <td class="text-right total"><?php echo $total['text']; ?></td>
                    </tr>
                <?php } ?>
            </table>
        </div>
    </div>
</div>
<div class="table-responsive cartBlock">
    <table class="table">
        <?php foreach ($products as $k => $product) {
            $delInfo = $product["delInfo"]; ?>
            <tbody>
            <tr>
                <td>
                    <div class="row">
                        <div class="col-lg-5 cartProductInfo">
                            <?php if ($product['thumb']) { ?>
                                <div class="image">
                                    <a href="<?php echo $product['href']; ?>">
                                        <img src="<?php echo $product['thumb']; ?>"
                                             alt="<?php echo $product['name']; ?>"
                                             title="<?php echo $product['name']; ?>"/>
                                    </a>
                                </div>
                            <?php } ?>
                            <div class="title">
                                <a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>

                                <div>
                                    <?php foreach ($product['option'] as $option) { ?>
                                        <small><?php echo $option['name']; ?>
                                            : <?php echo $option['value']; ?></small>
                                        <br/>
                                    <?php } ?>
                                </div>
                                <div class="price">
                                    <?php echo $product['total']; ?>
                                </div>
                            </div>
                            <div class="clear"></div>
                            <h3><?php echo $text_flower_message; ?></h3>

                            <div class="infoText"><?php echo $delInfo['message']; ?></div>

                        </div>
                        <div class="col-lg-7">
                            <?php
                            $index = $k;
                            include "catalog/view/theme/default/template/checkout/flowerFormInvoice.tpl"; ?>
                        </div>
                    </div>
                </td>
            </tr>
            </tbody>
        <?php } ?>
    </table>
</div>
