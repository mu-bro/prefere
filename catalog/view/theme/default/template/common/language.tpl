<?php if (count($languages) > 1) { ?>
    <div class="headMenu dropdown">
        <form action="<?php echo $action; ?>" method="post" id="language_form">
            <span><?php echo $text_language; ?>:</span>

            <button class="btn-link dropdown-toggle" data-toggle="dropdown">
                <?php echo $currentLanguage; ?>
                <span class="caret"></span>
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
            <input type="hidden" name="code" value=""/>
            <input type="hidden" name="redirect" value="<?php echo $redirect; ?>"/>
        </form>
    </div>
<?php } ?>