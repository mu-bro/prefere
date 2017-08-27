<?php echo $header; ?>
<div class="container">
    <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
    </ul>
    <div class="row"><?php echo $column_left; ?>
        <?php if ($column_left && $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
        <?php $class = 'col-sm-9'; ?>
        <?php } else { ?>
        <?php $class = 'col-sm-12'; ?>
        <?php } ?>

        <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
            <h1><?php echo $heading_title; ?></h1>
            <?php if ($invoice['status'] == 'CREATED') {?>
            <?php if ($invoice['system'] == 'payanyway_post') {?>
            <p><?php echo str_replace(
            array('%operation%', '%payment_url%', '%ctid%'),
            array($invoice['operation'], $invoice['payment_url'], $invoice['ctid']),
            $text_message); ?></p>
            <?php } else if ($invoice['system'] == 'payanyway_banktransfer'){?>
            <p><?php echo str_replace(
            array('%operation%', '%payment_url%', '%unitid%', '%ctid%'),
            array($invoice['operation'], $invoice['payment_url'], $invoice['unitid'], $invoice['ctid']),
            $text_message); ?></p>
            <?php } else if ($invoice['system'] == 'payanyway_sberbank'){?>
            <h3><?php echo $text_message[1].' '.$invoice['transaction']; ?></h3>
            <p><?php echo $text_message[2]; ?></p>
            <p><?php echo $invoice['transaction']; ?></p>
            <p><?php echo $text_message[6]; ?></p>
            <p><?php echo $text_message[3].' '.$invoice['amount']; ?></p>
            <p><?php echo $text_message[4].' '.$invoice['fee']; ?></p>
            <p><?php echo $text_message[5].' '.$invoice['payerAmount']; ?></p>
            <?php } else {?>
            <h3><?php echo $text_message[1].' '.$invoice['transaction']; ?></h3>
            <p><?php echo $text_message[2]; ?></p>
            <p><?php echo $invoice['transaction']; ?></p>
            <p><?php echo $text_message[3].' '.$invoice['amount']; ?></p>
            <p><?php echo $text_message[4].' '.$invoice['fee']; ?></p>
            <p><?php echo $text_message[5].' '.$invoice['payerAmount']; ?></p>
            <?php }?>
            <?php } else {?>
            <p><?php echo $invoice['error_message'];?></p>
            <?php }?>
            <div class="buttons">
                <div class="pull-right">
                    <a href="<?php echo $continue; ?>" class="btn btn-primary"><span><?php echo $button_continue; ?></span></a>
                </div>
            </div>
            <?php echo $content_bottom; ?></div>
        <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>