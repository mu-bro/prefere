<div id="icons<?php echo $module; ?>" class="top_icons row hidden-sm hidden-xs">
    <?php foreach ($banners as $banner) { ?>
        <div class="t_icon <?php echo $columnClass; ?>" data-placement="top" title="<?php echo $banner['description']; ?>">
            <div class="t_img">
                <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" />
            </div>
            <div class="t_text"><?php echo $banner['title']; ?></div>
        </div>
    <?php } ?>
</div>

<script>
    $(document).ready(function(){
        $('.t_icon').tooltip();
    });
</script>