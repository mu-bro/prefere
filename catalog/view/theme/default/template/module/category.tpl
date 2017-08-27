<div class="row">
    <div class="col-lg-12">
        <div class="row">
            <?php
            $col_num = ceil(12 / count($categories));
            foreach ($categories as $category) {
                if (empty($category['image'])) continue; ?>
                <div class="product-layout col-lg-<?php echo $col_num; ?> col-md-<?php echo $col_num; ?> col-sm-6 col-xs-6">
                    <div class="product-thumb transition category-thumb">
                        <div class="image">
                            <a href="<?php echo $category['href']; ?>"><img src="<?php echo $category['image']; ?>"
                                                                            alt="<?php echo $category['name']; ?>"
                                                                            title="<?php echo $category['name']; ?>"
                                                                            class="img-responsive"/></a></div>
                        <div class="caption">
                            <a class="productName" href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
                        </div>
                    </div>
                </div>
            <?php } ?>
        </div>
        <div class="row">
            <div class="col-lg-12 seeAllProducts category-seeAllProducts" style="margin-bottom:20px;">
                <a href="<?php echo $catalog_link; ?>">
                    <span><?php echo $text_see_all; ?></span>

                    <div></div>
                </a>
            </div>
        </div>
    </div>

</div>


