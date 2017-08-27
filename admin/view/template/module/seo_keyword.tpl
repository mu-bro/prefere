<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
       <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><i class="fa fa-link"></i> <?php echo $heading_title; ?><div class="dev-name">by vanstudio</div></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <div id="seo_keyword_notification" class="alert alert-info">
      <div id="seo_keyword_loading"><i class="fa fa-spinner"> </i> <?php echo $text_load_message; ?></div>
    </div>
  </div>
  <script type="text/javascript"><!--

            function getNotifications() {
              $('#seo_keyword_loading').empty().html('<div id="seo_keyword_loading"><i class="fa fa-spinner"> <?php echo $text_load_message; ?></div>');
              setTimeout(
                      function(){
                        $.ajax({
                          type: 'GET',
                          url: 'index.php?route=module/seo_keyword/getNotifications&token=<?php echo $token; ?>',
                          dataType: 'json',
                          success: function(json) {
                            if (json['error']) {
                              $('#seo_keyword_loading').empty().html(json['error']+' <span style="cursor:pointer;float:right;" onclick="getNotifications();"><i class="fa fa-refresh"></i> <?php echo $text_retry; ?></span>');
                            } else if (json['message']) {
                              $('#seo_keyword_loading').html(json['message']);
                            } else {
                              $('#seo_keyword_loading').html('<?php echo $error_no_message; ?>');
                            }
                          },
                          failure: function(){
                            $('#seo_keyword_loading').html('<?php echo $error_message; ?> <span style="cursor:pointer;float:right;" onclick="getNotifications();"><i class="fa fa-refresh"></i> <?php echo $text_retry; ?></span>');
                          },
                          error: function() {
                            $('#seo_keyword_loading').html('<?php echo $error_message; ?> <span style="cursor:pointer;float:right;" onclick="getNotifications();"><i class="fa fa-refresh"></i> <?php echo $text_retry; ?></span>');
                          }
                        });
                      },
                      500
              );
            }

    $(document).ready(function() {
      getNotifications();
    });
    //--></script>
  <style>
    .fa-link {
      color:#00BFFF;
      font-size: 28px;
    }
    .dev-name{
      position: absolute;
      margin-top: 3px;
      margin-left: 196px;
      font-size: 12px;
    }
  </style>
</div>
<?php echo $footer; ?>
