<div class="row">
    <div class="col-lg-12">
        <div class="centralBlock">
            <h3><span><?php echo $heading_title; ?></span></h3>

            <div class="row">
                <?php foreach ($products as $product) { ?>
                    <div class="product-layout col-lg-15 col-md-15 col-sm-6 col-xs-12">
                        <div class="product-thumb transition">
                            <div class="image">
                                <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>"
                                                                               alt="<?php echo $product['name']; ?>"
                                                                               title="<?php echo $product['name']; ?>"
                                                                               class="img-responsive"/></a></div>
                            <div class="caption">
                                <a class="productName" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                                <?php if ($product['price']) { ?>
                                    <div class="price">
                                        <?php if (!$product['special']) { ?>
                                            <?php echo $product['price']; ?>
                                        <?php } else { ?>
                                            <span class="price-new"><?php echo $product['special']; ?></span> <span
                                                class="price-old"><?php echo $product['price']; ?></span>
                                        <?php } ?>
                                        <?php if ($product['tax']) { ?>
                                            <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
                                        <?php } ?>
                                    </div>
                                <?php } ?>
                                <div class="description"><?php echo $product['description']; ?></div>
                                <?php if ($product['rating']) { ?>
                                    <div class="rating">
                                        <?php for ($i = 1; $i <= 5; $i++) { ?>
                                            <?php if ($product['rating'] < $i) { ?>
                                                <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                                            <?php } else { ?>
                                                <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i
                                                        class="fa fa-star-o fa-stack-2x"></i></span>
                                            <?php } ?>
                                        <?php } ?>
                                    </div>
                                <?php } ?>
                            </div>
                        </div>
                    </div>
                <?php } ?>
            </div>

            <div class="seeAllProducts">
                <a href="<?php echo $catalog_link; ?>">
                    <span><?php echo $text_see_all; ?></span>

                    <div></div>
                </a>

            </div>
        </div>
    </div>
</div>