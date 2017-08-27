<div class="row specialProductBlock">
    <?php foreach ($products as $product) { ?>
        <div class="product-layout col-lg-6 col-md-6 col-sm-6 col-xs-12">
            <div class="product-thumb transition">
                <div class="head">
                    <div class="icon">
                        <img src="<?php echo $product['icon']; ?>"/>
                    </div>
                    <div class="prodTitle">
                        <?php echo $product['title']; ?>
                    </div>
                    <div class="prodHelp">
                        <?php echo $product['help']; ?>
                    </div>
                </div>
                <div class="image">
                    <a href="<?php echo $product['href']; ?>">
                        <img src="<?php echo $product['thumb']; ?>"
                             alt="<?php echo $product['name']; ?>"
                             title="<?php echo $product['name']; ?>"
                             class="img-responsive"/>
                    </a>
                </div>
                <div class="caption">
                    <a class="productName" href="<?php echo $product['href']; ?>">
                        <?php echo $product['name']; ?>
                        <div class="twolineBorder"></div>
                    </a>
                    <?php if ($product['price']) { ?>
                        <div class="price">
                            <?php if (!$product['special']) { ?>
                                <?php echo $product['price']; ?>
                            <?php } else { ?>
                                <span class="price-new"><?php echo $product['special']; ?></span> <span
                                    class="price-old"><?php echo $product['price']; ?></span>
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
