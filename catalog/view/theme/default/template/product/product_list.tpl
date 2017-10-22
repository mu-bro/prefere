<?php
    if (!isset($column_class)) $column_class = "col-lg-4 col-md-4 col-sm-6 col-xs-6";
    foreach ($products as $product) { ?>
    <div class="product-layout product-grid <?php echo $column_class; ?>">
        <div class="product-thumb">
            <div class="image"><a href="<?php echo $product['href']; ?>"><img
                        src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>"
                        title="<?php echo $product['name']; ?>" class="img-responsive"/></a></div>
            <div>
                <div class="caption">
                    <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
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
                    <?php if ($product['price']) { ?>
                        <p class="price">
                            <?php if (!$product['special']) { ?>
                                <?php echo $product['price']; ?>
                            <?php } else { ?>
                                <span class="price-new"><?php echo $product['special']; ?></span> <span
                                    class="price-old"><?php echo $product['price']; ?></span>
                            <?php } ?>
                            <?php if ($product['tax']) { ?>
                                <span
                                    class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
                            <?php } ?>
                        </p>
                    <?php } ?>
                </div>
            </div>
        </div>
    </div>
<?php } ?>
