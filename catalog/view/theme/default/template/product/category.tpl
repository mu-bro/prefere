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
        <div id="content" class="<?php echo $class; ?> centralBlock catalog">
            <h3 class="small"><span><?php echo $heading_title; ?></span></h3>
            <?php echo $content_top; ?>
<!--            --><?php //if ($thumb || $description) { ?>
<!--                <div class="row">-->
<!--                    --><?php //if ($thumb) { ?>
<!--                        <div class="col-sm-2"><img src="--><?php //echo $thumb; ?><!--" alt="--><?php //echo $heading_title; ?><!--"-->
<!--                                                   title="--><?php //echo $heading_title; ?><!--" class="img-thumbnail"/></div>-->
<!--                    --><?php //} ?>
<!--                    --><?php if ($description) { ?>
<!--                        <div class="col-sm---><?php //echo ($thumb) ? '10' : '12'; ?><!--">--><?php echo $description; ?><!--</div>-->
<!--                    --><?php } ?>
<!--                </div>-->
<!--                <hr>-->
<!--            --><?php //} ?>
            <?php if ($categories) { ?>
                <h3><?php echo $text_refine; ?></h3>
                <?php if (count($categories) <= 5) { ?>
                    <div class="row">
                        <div class="col-sm-3">
                            <ul>
                                <?php foreach ($categories as $category) { ?>
                                    <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
                                <?php } ?>
                            </ul>
                        </div>
                    </div>
                <?php } else { ?>
                    <div class="row">
                        <?php foreach (array_chunk($categories, ceil(count($categories) / 4)) as $categories) { ?>
                            <div class="col-sm-3">
                                <ul>
                                    <?php foreach ($categories as $category) { ?>
                                        <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
                                    <?php } ?>
                                </ul>
                            </div>
                        <?php } ?>
                    </div>
                <?php } ?>
            <?php } ?>
            <?php if ($products) { ?>
                <div class="btn-group">
                    <button type="button" id="list-view" class="btn btn-default" data-toggle="tooltip"
                            title="<?php echo $button_list; ?>"><i class="fa fa-th-list"></i></button>
                    <button type="button" id="grid-view" class="btn btn-default" data-toggle="tooltip"
                            title="<?php echo $button_grid; ?>"><i class="fa fa-th"></i></button>
                </div>
                <div class="row" id="productList">
                    <?php include 'catalog/view/theme/'. $config_template .'/template/product/product_list.tpl'; ?>
                    <div class="text-center loadingBlock" >
                        <i class="fa fa-refresh fa-spin"></i>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12 text-center"><?php echo $pagination; ?></div>
                </div>
            <?php } ?>
            <?php if (!$categories && !$products) { ?>
                <p><?php echo $text_empty; ?></p>
                <div class="buttons">
                    <div class="pull-right"><a href="<?php echo $continue; ?>"
                                               class="btn btn-primary"><?php echo $button_continue; ?></a></div>
                </div>
            <?php } ?>
            <?php echo $content_bottom; ?></div>

	    <div class="camera_text">
		    <?php if ($_SERVER['REQUEST_URI'] == "/nase-vazane-kytice") { echo html_entity_decode($camera_text['description']); } ?>
		</div>
        <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>
