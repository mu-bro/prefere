<?php if (count($currencies) > 1) { ?>
    <div class="headMenu dropdown col-lg-9 col-md-8 col-sm-12 col-xs-12">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="currency">
            <table cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <span><?php echo $text_currency; ?>:</span>
                    </td>
                    <td>
                        <button class="btn-link dropdown-toggle" data-toggle="dropdown">
                            <?php foreach ($currencies as $currency) { ?>
                                <?php if ($currency['code'] == $code) { ?>
                                    <?php echo $currency['title']; ?>
                                <?php } ?>
                            <?php } ?>
                        </button>
                        <ul class="dropdown-menu pull-right">
                            <?php foreach ($currencies as $currency) { ?>
                                <?php if ($currency['symbol_left']) { ?>
                                    <li>
                                        <button class="currency-select btn btn-link btn-block"
                                                type="button"
                                                name="<?php echo $currency['code']; ?>"><?php echo $currency['symbol_left']; ?> <?php echo $currency['title']; ?></button>
                                    </li>
                                <?php } else { ?>
                                    <li>
                                        <button class="currency-select btn btn-link btn-block"
                                                type="button"
                                                name="<?php echo $currency['code']; ?>"><?php echo $currency['symbol_right']; ?> <?php echo $currency['title']; ?></button>
                                    </li>
                                <?php } ?>
                            <?php } ?>
                        </ul>
                    </td>
                </tr>
            </table>




            <input type="hidden" name="code" value=""/>
            <input type="hidden" name="redirect" value="<?php echo $redirect; ?>"/>
        </form>
    </div>
<?php } ?>
