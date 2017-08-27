<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-featured" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-featured" class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
            <div class="col-sm-10">
              <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
              <?php if ($error_name) { ?>
              <div class="text-danger"><?php echo $error_name; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-admin-limit"><span data-toggle="tooltip" title="<?php echo $help_day_product; ?>"><?php echo $title_day_product; ?></span></label>
            <div class="col-sm-10">
              <div class="input-group" >
                <input type="text" id="day_product_name" value="<?php echo $day_product_name; ?>" class="form-control" />
                                            <span class="input-group-btn">
                                                <button type="button" class="btn btn-default" onclick="$('#day_product_name, #day_product_id').val('');"><i class="fa fa-times remove"></i></button>
                                            </span>
              </div>
              <input type="hidden" name="day_product_id" id="day_product_id" value="<?php echo $day_product_id; ?>" placeholder="<?php echo $day_product_id; ?>" class="time form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-admin-limit"><span data-toggle="tooltip" title="<?php echo $help_charity_product; ?>"><?php echo $title_charity_product; ?></span></label>
            <div class="col-sm-10">
              <div class="input-group" >
                <input type="text" id="charity_product_name" value="<?php echo $charity_product_name; ?>" class="form-control" />
                                            <span class="input-group-btn">
                                                <button type="button" class="btn btn-default" onclick="$('#charity_product_name, #charity_product_id').val('');"><i class="fa fa-times remove"></i></button>
                                            </span>
              </div>
              <input type="hidden" name="charity_product_id" id="charity_product_id" value="<?php echo $charity_product_id; ?>" placeholder="<?php echo $charity_product_id; ?>" class="time form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="status" id="input-status" class="form-control">
                <?php if ($status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
  <script type="text/javascript"><!--
    $('#day_product_name').autocomplete({
      source: function (request, response) {
        $.ajax({
          url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request),
          dataType: 'json',
          success: function (json) {
            response($.map(json, function (item) {
              return {
                label: item['name'],
                price: item['priceText'],
                value: item['product_id'],
                image: item['image']
              }
            }));
          }
        });
      },
      select: function (item) {
        $('#day_product_name').val(item.label + ' (' + item.price + ')');
        $('#day_product_id').val(item.value);
      }
    });
    $('#charity_product_name').autocomplete({
      source: function (request, response) {
        $.ajax({
          url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request),
          dataType: 'json',
          success: function (json) {
            response($.map(json, function (item) {
              return {
                label: item['name'],
                price: item['priceText'],
                value: item['product_id'],
                image: item['image']
              }
            }));
          }
        });
      },
      select: function (item) {
        $('#charity_product_name').val(item.label + ' (' + item.price + ')');
        $('#charity_product_id').val(item.value);
      }
    });
    //--></script>
</div>
<?php echo $footer; ?>