<?php echo $header; ?>
<?php echo $column_left; ?>

<div id="content">
<div id="emailtemplate">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<button id="submit_form_button" type="submit" form="form-language" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-success"><i class="fa fa-save"></i></button>

				<?php if (isset($language_has_custom)) { ?>
				<a href="<?php echo $action; ?>&action=delete" onclick="return confirm('<?php echo $text_confirm; ?>');" class="btn btn-danger" data-toggle="tooltip" title="<?php echo $button_delete; ?>"><i class="fa fa-trash-o"></i></a>
				<?php } ?>

				<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
			</div>

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

	<form action="<?php echo $action; ?>" method="post" id="form-language" class="container-fluid form-horizontal">
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

	    <?php if (!empty($manual)) { ?>
		<table class="form">
			<tr>
				<td style="border:none; padding-bottom:0"><?php echo $manual['info']; ?></td>
			</tr>
			<tr>
				<td><textarea style="width:100%; height:200px;"><?php echo $manual['contents']; ?></textarea></td>
			</tr>
		</table>
		<?php } ?>

		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-language"></i> <?php echo $language_file; ?></h3>

				<div class="pull-right">
					<a href="<?php echo $action_sort; ?>"><i class="fa <?php if($sort == 'asc'){ ?>fa-sort-alpha-asc<?php } else { ?>fa-random<?php } ?>"></i></a>
				</div>
			</div>

			<div class="panel-body">
				<?php foreach($language_vars as $langVar) { ?>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="field_<?php echo $langVar['key']; ?>"><?php echo $langVar['key']; ?></label>
					<div class="col-sm-10">
						<?php if ($langVar['hasHtml']) { ?>
							<textarea class="wysiwyg_editor form-control" name="vars[<?php echo $langVar['key'] ?>]" id="field_<?php echo $langVar['key']; ?>"><?php echo $langVar['value']; ?></textarea>
						<?php } elseif (strlen($langVar['value']) > 50) { ?>
							<div class="input-group">
							    <textarea class="form-control" name="vars[<?php echo $langVar['key'] ?>]" id="field_<?php echo $langVar['key']; ?>" style="resize:vertical"><?php echo $langVar['value']; ?></textarea>
							    <a href="javascript:void(0)" class="input-group-addon show-editor"><i class="fa fa-pencil-square-o"></i></a>
							</div>
						<?php } else { ?>
							<div class="input-group">
								<input type="text" class="form-control" id="field_<?php echo $langVar['key']; ?>" name="vars[<?php echo $langVar['key'] ?>]" value="<?php echo $langVar['value']; ?>" />
								<a href="javascript:void(0)" class="input-group-addon show-editor"><i class="fa fa-pencil-square-o"></i></a>
							</div>
						<?php } ?>
					</div>
				</div>
				<?php } ?>
			</div>
		</div>
    </form>
</div>
</div>

<?php echo $footer; ?>