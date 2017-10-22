<div class="row categoryBlockRow">
    <div class="col-lg-12">
        <div class="centralBlock">
            <h3><span><?php echo $heading_title; ?></span></h3>
            <div class="row">
                <?php
                foreach ($categories as $category) {
                    if (empty($category['image'])) continue; ?>
                    <div class="product-layout <?php echo $columnClass; ?>">
                        <div class="product-thumb transition category-thumb">
                            <div class="image">
                                <a href="<?php echo $category['href']; ?>">
                                    <img src="<?php echo $category['image']; ?>"
                                         alt="<?php echo $category['name']; ?>"
                                         title="<?php echo $category['name']; ?>"
                                         class="img-responsive"/>
                                </a>
                            </div>
                            <div class="caption">
                                <a class="productName" href="<?php echo $category['href']; ?>">
                                    <?php echo $category['name']; ?>
                                </a>
                            </div>
                        </div>
                    </div>
                <?php } ?>
            </div>
        </div>
    </div>
</div>


