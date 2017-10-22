<div class="row">
    <div class="col-lg-12">
        <div class="centralBlock">
            <h3><span><?php echo $heading_title; ?></span></h3>

            <div class="row">
                <?php
                $column_class = "col-lg-15 col-md-15 col-sm-15 col-xs-6";
                include 'catalog/view/theme/' . $config_template . '/template/product/product_list.tpl'; ?>
            </div>

            <div class="seeAllProducts">
                <a class="linkButton" href="<?php echo $catalog_link; ?>">
                    <span><?php echo $text_see_all; ?></span>
                </a>
            </div>
        </div>
    </div>
</div>