<?php echo $header; ?>
<?php echo $column_left; ?>

<div id="content">
<div id="emailtemplate">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
			</div>

			<h1><i class="fa fa-language"></i> <?php echo $language_files_count; ?> <?php echo $text_language_files; ?></h1>

			<ul class="breadcrumb">
        		<?php $i=1; foreach ($breadcrumbs as $breadcrumb) { ?>
        		<?php if ($i == count($breadcrumbs)) { ?>
        			<li class="active"><?php echo $breadcrumb['text']; ?></li>
        		<?php } else { ?>
        			<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        		<?php } ?>
        		<?php $i++; } ?>
      		</ul>
		</div>
	</div>

	<div id="form-emailtemplate" class="container-fluid">
	    <?php if (isset($error_warning) && $error_warning) { ?>
	    	<div class="alert alert-danger">
				<i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
	      		<button type="button" class="close" data-dismiss="alert">&times;</button>
			</div>
	    <?php } ?>

	    <?php if (isset($error_attention) && $error_attention) { ?>
	    	<div class="alert alert-warning">
				<i class="fa fa-exclamation-circle"></i> <?php echo $error_attention; ?>
	      		<button type="button" class="close" data-dismiss="alert">&times;</button>
			</div>
	    <?php } ?>

	    <?php if (isset($success) && $success) { ?>
	    	<div class="alert alert-success">
				<i class="fa fa-exclamation-circle"></i> <?php echo $success; ?>
	      		<button type="button" class="close" data-dismiss="alert">&times;</button>
			</div>
	    <?php } ?>

	    <div id="form-filter" class="well">
			<div class="row">
            	<div class="col-xs-12 col-sm-6">
              		<div class="form-group">
                		<div class="input-group">
							<input class="form-control" type="text" id="filter_search" name="filter_search" value="<?php echo $filter_search; ?>" placeholder="<?php echo $text_search; ?>..." />
							<span class="input-group-addon">
				                <label><input name="filter_admin" type="checkbox" value="1"<?php if ($type == 'admin') echo ' checked="checked"'; ?> /> <?php echo $text_admin; ?></label>
						    </span>
						</div>
              		</div>
              	</div>
              	<div class="col-xs-10 col-sm-4">
              		<div class="form-group">
                		<select name="filter_language" class="form-control">
							<?php foreach($languages as $language) { ?>
							<option value="<?php echo $language['language_id']; ?>"<?php if ($language_id == $language['language_id']) echo ' selected="selected"'; ?>><?php echo $language['name']; ?></option>
							<?php } ?>
						</select>
					</div>
              	</div>
              	<div class="col-xs-2">
              		<button class="btn btn-primary" id="form-filter-btn" type="button"><i class="fa fa-search"></i> <?php echo $button_filter; ?></button>
              	</div>
			</div>
        </div>

		<div class="row" id="language-files">
			<div class="col-xs-3">
				<ul class="nav nav-tabs tabs-left">
				<?php foreach($language_files as $i => $file) { ?>
					<?php if (!empty($file['files'])) { ?>
						<li<?php if ($i==1) echo ' class="active"'; ?>><a href="javascript:void(0)" data-toggle="tab" data-target="#tab-<?php echo $i; ?>"><?php echo $file['path']; ?></a></li>
					<?php } ?>
				<?php } ?>
				</ul>
			</div>

			<div class="col-xs-9">
    			<div class="tab-content well well-sm">
					<?php $i = 1; foreach($language_files as $key => $file) { ?>
					<?php if (!empty($file['files'])) { ?>
						<div class="tab-pane fade<?php if ($i==1) echo ' in active'; ?>" id="tab-<?php echo $key; ?>">
							<div class="table-responsive">
					           	<table class="table table-hover">
					            	<tbody>
										<?php foreach($file['files'] as $filename) { ?>
										<tr>
											<td>
												<a href="<?php echo $filename['action']; ?>" class="btn-block"><i class="fa fa-pencil pull-right"></i> <?php echo html_entity_decode($filename['file'], ENT_QUOTES, 'UTF-8'); ?></a>
											</td>
										</tr>
										<?php } ?>
									</tbody>
								</table>
							</div>
						</div>
					<?php $i++; } ?>
					<?php } ?>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
<?php echo $footer; ?>