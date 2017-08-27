<?php if (!isset($redirect)) { ?>
    <div class="table-responsive">
        <table class="table confirmTable">
            <tbody>
            <?php foreach ($products as $product) { ?>
                <tr>
                    <td class="text-left">
                        <img src="<?php echo $product['thumb']; ?>"
                             title="<?php echo $product['name']; ?>"
                             alt="<?php echo $product['name']; ?>"/>
                    </td>
                    <td class="text-left"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                        <?php foreach ($product['option'] as $option) { ?>
                            <br/>
                            &nbsp;
                            <small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                        <?php } ?>
                        <?php if ($product['recurring']) { ?>
                            <br/>
                            <span class="label label-info"><?php echo $text_recurring_item; ?></span>
                            <small><?php echo $product['recurring']; ?></small>
                        <?php } ?></td>
                    <td class="text-right"><?php echo $product['price']; ?></td>
                    <td class="text-right">
                        <?php echo $text_delivery; ?>: <?php echo $product['shipping']['price']; ?><br/>
                        <?php echo $product['shipping']['title']; ?>
                    </td>
                </tr>
            <?php } ?>
            </tbody>
        </table>
        <table class="table cartTotals">
            <?php foreach ($totals as $total) { ?>
                <tr>
                    <td class="text-right"><?php echo $total['title']; ?>:</td>
                    <td class="text-right total"><?php echo $total['text']; ?></td>
                </tr>
            <?php } ?>
        </table>
    </div>
    <?php echo $payment; ?>
<?php } else { ?>
    <script type="text/javascript"><!--
        location = '<?php echo $redirect; ?>';
        //--></script>
<?php } ?>
