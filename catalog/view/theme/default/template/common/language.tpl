<?php if (count($languages) > 1) { ?>
    <div class="headMenu dropdown col-lg-3 col-md-4 col-sm-12 col-xs-12">
        <form action="<?php echo $action; ?>" method="post" id="language_form">
            <table cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <span><?php echo $text_language; ?>:</span>
                    </td>
                    <td>
                        <button class="btn-link dropdown-toggle" data-toggle="dropdown">
                            <?php echo $currentLanguage; ?>
                        </button>
                        <ul class="dropdown-menu pull-right">
                            <?php foreach ($languages as $language) { ?>
                                <li><a href="<?php echo $language['code']; ?>">
                                        <img src="image/flags/<?php echo $language['image']; ?>"
                                             alt="<?php echo $language['name']; ?>"
                                             title="<?php echo $language['name']; ?>"/> <?php echo $language['name']; ?>
                                    </a></li>
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