<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-gopay" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
    <?php if (!empty($error_warning)) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $heading_title; ?></h3>
      </div>
      <div class="panel-body">
	    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-gopay" class="form-horizontal">
		  <div class="tab-content">
            <div class="tab-pane active in" id="tab-data">
			  <div class="row">
                <div class="col-sm-2">
                  <ul class="nav nav-pills nav-stacked">
				    <li><a href="#tab-data-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
				    <li><a href="#tab-data-default" data-toggle="tab"><?php echo $tab_default; ?></a></li>
					<?php foreach ($stores as $store) { ?>
					<li><a href="#tab-data-<?php echo $store['store_id']; ?>" data-toggle="tab"><?php echo $store['name']; ?></a></li>
					<?php } ?>
                  </ul>
                </div>
                <div class="col-sm-10">
                  <div class="tab-content">
				    <div class="tab-pane" id="tab-data-general">
					  <div class="form-group">
					    <label class="col-sm-2 control-label" for="input-callback"><?php echo $entry_callback; ?></label>
						<div class="col-sm-10">
						  <input type="text" value="<?php echo $callback; ?>" readonly="readonly" class="form-control" id="input-callback" />
						</div>
					  </div>
					  <div class="form-group">
					    <label class="col-sm-2 control-label" for="input-order-confirm"><?php echo $entry_order_confirm; ?></label>
						<div class="col-sm-10">
						  <select name="gopay_order_confirm" class="form-control" id="input-order-confirm">
						    <option value="0"<?php if (!$gopay_order_confirm) echo ' selected="selected"'; ?>><?php echo $text_order_confirm_callback; ?></option>
				            <option value="1"<?php if ($gopay_order_confirm) echo ' selected="selected"'; ?>><?php echo $text_order_confirm_redirect; ?></option>
					      </select>
						</div>
					  </div>
					  <div class="form-group">
					    <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
						<div class="col-sm-10">
						  <select name="gopay_status" class="form-control" id="input-status">
						    <option value="0"<?php if (!$gopay_status) echo ' selected="selected"'; ?>><?php echo $text_disabled; ?></option>
				            <option value="1"<?php if ($gopay_status) echo ' selected="selected"'; ?>><?php echo $text_enabled; ?></option>
					      </select>
						</div>
					  </div>
					  <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
                        <div class="col-sm-10">
                          <input type="text" name="gopay_sort_order" value="<?php echo $gopay_sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order" class="form-control" />
                        </div>
                      </div>
					</div>
					<div class="tab-pane" id="tab-data-default">
					  <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab-store-default-data" data-toggle="tab"><?php echo $tab_data; ?></a></li>
                        <li><a href="#tab-store-default-payment-method" data-toggle="tab"><?php echo $tab_payment_method; ?></a></li>
                      </ul>
					  <div class="tab-content">
                        <div class="tab-pane active in" id="tab-store-default-data">
						  <fieldset>
						    <legend><?php echo $text_credentials; ?></legend>
							<div class="form-group required">
							  <label class="col-sm-2 control-label" for="input-goid"><?php echo $entry_goid; ?></label>
							  <div class="col-sm-10">
							    <input type="text" name="gopay[default][goid]" value="<?php if (!empty($gopay['default']['goid'])) echo $gopay['default']['goid']; ?>" placeholder="<?php echo $entry_goid; ?>" id="input-goid" class="form-control" />
								<?php if (!empty($error['goid']['default'])) { ?>
                                <div class="text-danger"><?php echo $error['goid']['default']; ?></div>
                                <?php } ?>
							  </div>
						    </div>
							<div class="form-group required">
							  <label class="col-sm-2 control-label" for="input-secret"><?php echo $entry_secret; ?></label>
							  <div class="col-sm-10">
							    <input type="text" name="gopay[default][secret]" value="<?php if (!empty($gopay['default']['secret'])) echo $gopay['default']['secret']; ?>" placeholder="<?php echo $entry_secret; ?>" id="input-secret" class="form-control" />
								<?php if (!empty($error['secret']['default'])) { ?>
                                <div class="text-danger"><?php echo $error['secret']['default']; ?></div>
                                <?php } ?>
							  </div>
						    </div>
						  </fieldset>
						  <fieldset>
						    <legend><?php echo $text_restrictions; ?></legend>
							<div class="form-group">
							  <label class="col-sm-2 control-label" for="input-total"><?php echo $entry_total; ?></label>
							  <div class="col-sm-10">
							    <input type="text" name="gopay[default][total]" value="<?php if (!empty($gopay['default']['total'])) echo $gopay['default']['total']; ?>" placeholder="<?php echo strip_tags($entry_total); ?>" id="input-total" class="form-control" />
							  </div>
						    </div>
							<div class="form-group">
							  <label class="col-sm-2 control-label" for="input-geo-zone"><?php echo $entry_geo_zone; ?></label>
							  <div class="col-sm-10">
							    <select name="gopay[default][geo_zone_id]" id="input-geo-zone" class="form-control">
								  <option value="0"><?php echo $text_all_zones; ?></option>
                                  <?php foreach ($geo_zones as $geo_zone) { ?>
                                  <option value="<?php echo $geo_zone['geo_zone_id']; ?>"<?php if (isset($gopay['default']['geo_zone_id']) && $geo_zone['geo_zone_id'] == $gopay['default']['geo_zone_id']) echo ' selected="selected"'; ?>><?php echo $geo_zone['name']; ?></option>
                                  <?php } ?>
								</select>
							  </div>
						    </div>
							<div class="form-group">
							  <label class="col-sm-2 control-label" for="input-display"><?php echo $entry_separate_method; ?></label>
							  <div class="col-sm-10">
							    <select name="gopay[default][display]" id="input-display" class="form-control">
								  <option value="0"<?php if (empty($gopay['default']['display'])) echo ' selected="selected"'; ?>><?php echo $text_no; ?></option>
				                  <option value="1"<?php if (!empty($gopay['default']['display'])) echo ' selected="selected"'; ?>><?php echo $text_yes; ?></option>
								</select>
							  </div>
						    </div>
							<div class="form-group">
							  <label class="col-sm-2 control-label" for="input-test"><?php echo $entry_test; ?></label>
							  <div class="col-sm-10">
							    <select name="gopay[default][test]" id="input-test" class="form-control">
								  <option value="1"<?php if (!empty($gopay['default']['test'])) echo ' selected="selected"'; ?>><?php echo $text_enabled; ?></option>
                  	              <option value="0"<?php if (empty($gopay['default']['test'])) echo ' selected="selected"'; ?>><?php echo $text_disabled; ?></option>
								</select>
							  </div>
						    </div>
						  </fieldset>
						  <fieldset>
						    <legend><?php echo $text_order_statuses; ?></legend>
							<div class="form-group">
							  <label class="col-sm-2 control-label" for="input-order-status"><?php echo $entry_order_status; ?></label>
							  <div class="col-sm-10">
							    <select name="gopay[default][order_status_id]" id="input-order-status" class="form-control">
								  <?php foreach ($order_statuses as $order_status) { ?>
                                  <option value="<?php echo $order_status['order_status_id']; ?>"<?php if (isset($gopay['default']['order_status_id']) && $order_status['order_status_id'] == $gopay['default']['order_status_id']) echo ' selected="selected"'; ?>><?php echo $order_status['name']; ?></option>
                                  <?php } ?>
								</select>
							  </div>
						    </div>
							<div class="form-group">
							  <label class="col-sm-2 control-label" for="input-order-status-success"><?php echo $entry_order_status_success; ?></label>
							  <div class="col-sm-10">
							    <select name="gopay[default][order_status_id_success]" id="input-order-status-success" class="form-control">
								  <?php foreach ($order_statuses as $order_status) { ?>
                                  <option value="<?php echo $order_status['order_status_id']; ?>"<?php if (isset($gopay['default']['order_status_id_success']) && $order_status['order_status_id'] == $gopay['default']['order_status_id_success']) echo ' selected="selected"'; ?>><?php echo $order_status['name']; ?></option>
                                  <?php } ?>
								</select>
							  </div>
						    </div>
							<div class="form-group">
							  <label class="col-sm-2 control-label" for="input-order-status-failed"><?php echo $entry_order_status_failed; ?></label>
							  <div class="col-sm-10">
							    <select name="gopay[default][order_status_id_failed]" id="input-order-status-failed" class="form-control">
								  <?php foreach ($order_statuses as $order_status) { ?>
                                  <option value="<?php echo $order_status['order_status_id']; ?>"<?php if (isset($gopay['default']['order_status_id_failed']) && $order_status['order_status_id'] == $gopay['default']['order_status_id_failed']) echo ' selected="selected"'; ?>><?php echo $order_status['name']; ?></option>
                                  <?php } ?>
								</select>
							  </div>
						    </div>
						  </fieldset>
						</div>
						<div class="tab-pane" id="tab-store-default-payment-method">
						  <?php if (empty($payment_methods['default'])) { ?>
			              <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_no_payment_methods; ?></div>
			              <?php } else { ?>
						  <div class="table-responsive">
                            <table class="table table-bordered table-hover">
							  <thead>
				                <tr>
				                  <td class="text-center" style="width:1px;"><?php echo $entry_disable; ?></td>
				                  <td class="text-right"><?php echo $entry_sort_order; ?></td>
				                  <td class="text-left"><?php echo $entry_image; ?></td>
				                  <td class="text-left"><?php echo $entry_title; ?></td>
				                  <td class="text-right"><?php echo $entry_total_min; ?></td>
				                  <td class="text-right"><?php echo $entry_total_max; ?></td>
				                  <td class="text-right"><?php echo $entry_cost; ?></td>
				                  <td class="text-right"><?php echo $entry_offline; ?></td>
				                </tr>
				              </thead>
				              <tbody>
				                <?php foreach ($payment_methods['default'] as $method) { ?>
				                <?php $method_data = (isset($gopay['default']['method'][$method->code]) ? $gopay['default']['method'][$method->code] : array()); ?>
				                <tr><td class="text-left" colspan="8"><b><?php echo $method->paymentMethod; ?></b></td></tr>
				                <tr>
				                  <td class="text-center"><input type="checkbox" name="gopay[default][method][<?php echo $method->code; ?>][disabled]" value="1" class="method-disable"<?php if (!empty($method_data['disabled'])) echo ' checked="checked"'; ?> /></td>
					              <td class="text-right"><input type="text" name="gopay[default][method][<?php echo $method->code; ?>][sort_order]" value="<?php if (isset($method_data['sort_order'])) echo $method_data['sort_order']; ?>" size="1" /></td>
                                  <td class="text-left">
								    <a href="" id="method-<?php echo $method->code; ?>-default-thumb" data-toggle="image" class="img-thumbnail"><img src="<?php echo (!empty($method_data['image']) && file_exists(DIR_IMAGE . $method_data['image']) ? HTTPS_CATALOG . 'image/' . $method_data['image'] : $method->logo); ?>" alt="" title="" data-placeholder="<?php echo $method->logo; ?>" /></a>
                                    <input type="hidden" name="gopay[default][method][<?php echo $method->code; ?>][image]" value="<?php if (isset($method_data['image'])) echo $method_data['image']; ?>" id="method-<?php echo $method->code; ?>-default-image" />
					                <input type="hidden" name="gopay[default][method][<?php echo $method->code; ?>][image_orig]" value="<?php echo $method->logo; ?>" />
								  </td>
				                  <td class="text-left">
				                    <?php foreach ($languages as $language) { ?>
					                <div><input type="text" name="gopay[default][method][<?php echo $method->code; ?>][title][<?php echo $language['language_id']; ?>]" value="<?php if (isset($method_data['title'][$language['language_id']])) echo $method_data['title'][$language['language_id']]; ?>" />&nbsp;<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></div>
					                <?php } ?>
					                <input type="hidden" name="gopay[default][method][<?php echo $method->code; ?>][title_orig]" value="<?php echo $method->paymentMethod; ?>" />
				                  </td>
				                  <td class="text-right">
				                    <input type="text" name="gopay[default][method][<?php echo $method->code; ?>][min]" value="<?php if (isset($method_data['min'])) echo $method_data['min']; ?>" />
				                  </td>
				                  <td class="text-right">
				                    <input type="text" name="gopay[default][method][<?php echo $method->code; ?>][max]" value="<?php if (isset($method_data['max'])) echo $method_data['max']; ?>" />
				                  </td>
					              <td class="text-right">
				                    <input type="text" name="gopay[default][method][<?php echo $method->code; ?>][cost]" value="<?php if (isset($method_data['cost'])) echo $method_data['cost']; ?>" size="2" />%
				                  </td>
					              <td class="text-right"><?php echo ($method->offline ? $text_yes : $text_no); ?></td>
				                </tr>
				                <?php } ?>
				              </tbody>
							</table>
						  </div>
						  <?php } ?>
						</div>
					  </div>
					</div>
					<?php foreach ($stores as $store) { ?>
					<div class="tab-pane" id="tab-data-<?php echo $store['store_id']; ?>">
					  <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab-store-<?php echo $store['store_id']; ?>-data" data-toggle="tab"><?php echo $tab_data; ?></a></li>
                        <li><a href="#tab-store-<?php echo $store['store_id']; ?>-payment-method" data-toggle="tab"><?php echo $tab_payment_method; ?></a></li>
                      </ul>
					  <div class="tab-content">
                        <div class="tab-pane active in" id="tab-store-<?php echo $store['store_id']; ?>-data">
						  <fieldset>
						    <legend><?php echo $text_credentials; ?></legend>
					        <label><input type="checkbox" name="gopay[<?php echo $store['store_id']; ?>][default][credential]" value="1" class="as_default" id="as_default_credential_<?php echo $store['store_id']; ?>"<?php if (empty($gopay[$store['store_id']]) || !empty($gopay[$store['store_id']]['default']['credential'])) echo ' checked="checked"'; ?> /> <?php echo $text_same_as_default; ?></label>
							<div class="form-group required as_default_credential_<?php echo $store['store_id']; ?>">
							  <label class="col-sm-2 control-label" for="input-goid-<?php echo $store['store_id']; ?>"><?php echo $entry_goid; ?></label>
							  <div class="col-sm-10">
							    <input type="text" name="gopay[<?php echo $store['store_id']; ?>][goid]" value="<?php if (!empty($gopay[$store['store_id']]['goid'])) echo $gopay[$store['store_id']]['goid']; ?>" placeholder="<?php echo $entry_goid; ?>" id="input-goid-<?php echo $store['store_id']; ?>" class="form-control" />
								<?php if (!empty($error['goid'][$store['store_id']])) { ?>
                                <div class="text-danger"><?php echo $error['goid'][$store['store_id']]; ?></div>
                                <?php } ?>
							  </div>
						    </div>
							<div class="form-group required as_default_credential_<?php echo $store['store_id']; ?>">
							  <label class="col-sm-2 control-label" for="input-secret-<?php echo $store['store_id']; ?>"><?php echo $entry_secret; ?></label>
							  <div class="col-sm-10">
							    <input type="text" name="gopay[<?php echo $store['store_id']; ?>][secret]" value="<?php if (!empty($gopay[$store['store_id']]['secret'])) echo $gopay[$store['store_id']]['secret']; ?>" placeholder="<?php echo $entry_secret; ?>" id="input-secret-<?php echo $store['store_id']; ?>" class="form-control" />
								<?php if (!empty($error['secret'][$store['store_id']])) { ?>
                                <div class="text-danger"><?php echo $error['secret'][$store['store_id']]; ?></div>
                                <?php } ?>
							  </div>
							</div>
						  </fieldset>
						  <fieldset>
						    <legend><?php echo $text_restrictions; ?></legend>
							<label><input type="checkbox" name="gopay[<?php echo $store['store_id']; ?>][default][restriction]" value="1" class="as_default" id="as_default_restriction_<?php echo $store['store_id']; ?>"<?php if (empty($gopay[$store['store_id']]) || !empty($gopay[$store['store_id']][$store['store_id']]['restriction'])) echo ' checked="checked"'; ?> /> <?php echo $text_same_as_default; ?></label>
							<div class="form-group as_default_restriction_<?php echo $store['store_id']; ?>">
							  <label class="col-sm-2 control-label" for="input-total-<?php echo $store['store_id']; ?>"><?php echo $entry_total; ?></label>
							  <div class="col-sm-10">
							    <input type="text" name="gopay[<?php echo $store['store_id']; ?>][total]" value="<?php if (!empty($gopay[$store['store_id']]['total'])) echo $gopay[$store['store_id']]['total']; ?>" placeholder="<?php echo strip_tags($entry_total); ?>" id="input-total-<?php echo $store['store_id']; ?>" class="form-control" />
							  </div>
						    </div>
							<div class="form-group as_default_restriction_<?php echo $store['store_id']; ?>">
							  <label class="col-sm-2 control-label" for="input-geo-zone-<?php echo $store['store_id']; ?>"><?php echo $entry_geo_zone; ?></label>
							  <div class="col-sm-10">
							    <select name="gopay[<?php echo $store['store_id']; ?>][geo_zone_id]" id="input-geo-zone-<?php echo $store['store_id']; ?>" class="form-control">
								  <option value="0"><?php echo $text_all_zones; ?></option>
                                  <?php foreach ($geo_zones as $geo_zone) { ?>
                                  <option value="<?php echo $geo_zone['geo_zone_id']; ?>"<?php if (isset($gopay[$store['store_id']]['geo_zone_id']) && $geo_zone['geo_zone_id'] == $gopay[$store['store_id']]['geo_zone_id']) echo ' selected="selected"'; ?>><?php echo $geo_zone['name']; ?></option>
                                  <?php } ?>
								</select>
							  </div>
						    </div>
							<div class="form-group as_default_restriction_<?php echo $store['store_id']; ?>">
							  <label class="col-sm-2 control-label" for="input-display-<?php echo $store['store_id']; ?>"><?php echo $entry_separate_method; ?></label>
							  <div class="col-sm-10">
							    <select name="gopay[<?php echo $store['store_id']; ?>][display]" id="input-display-<?php echo $store['store_id']; ?>" class="form-control">
								  <option value="0"<?php if (empty($gopay[$store['store_id']]['display'])) echo ' selected="selected"'; ?>><?php echo $text_no; ?></option>
				                  <option value="1"<?php if (!empty($gopay[$store['store_id']]['display'])) echo ' selected="selected"'; ?>><?php echo $text_yes; ?></option>
								</select>
							  </div>
						    </div>
							<div class="form-group as_default_restriction_<?php echo $store['store_id']; ?>">
							  <label class="col-sm-2 control-label" for="input-test-<?php echo $store['store_id']; ?>"><?php echo $entry_test; ?></label>
							  <div class="col-sm-10">
							    <select name="gopay[<?php echo $store['store_id']; ?>][test]" id="input-test-<?php echo $store['store_id']; ?>" class="form-control">
								  <option value="1"<?php if (!empty($gopay[$store['store_id']]['test'])) echo ' selected="selected"'; ?>><?php echo $text_enabled; ?></option>
                  	              <option value="0"<?php if (empty($gopay[$store['store_id']]['test'])) echo ' selected="selected"'; ?>><?php echo $text_disabled; ?></option>
								</select>
							  </div>
						    </div>
						  </fieldset>
						  <fieldset>
						    <legend><?php echo $text_order_statuses; ?></legend>
							<label><input type="checkbox" name="gopay[<?php echo $store['store_id']; ?>][default][order_status]" value="1" class="as_default" id="as_default_order_status_<?php echo $store['store_id']; ?>"<?php if (empty($gopay[$store['store_id']]) || !empty($gopay[$store['store_id']][$store['store_id']]['order_status'])) echo ' checked="checked"'; ?> /> <?php echo $text_same_as_default; ?></label>
							<div class="form-group as_default_order_status_<?php echo $store['store_id']; ?>">
							  <label class="col-sm-2 control-label" for="input-order-status"><?php echo $entry_order_status; ?></label>
							  <div class="col-sm-10">
							    <select name="gopay[<?php echo $store['store_id']; ?>][order_status_id]" id="input-order-status" class="form-control">
								  <?php foreach ($order_statuses as $order_status) { ?>
                                  <option value="<?php echo $order_status['order_status_id']; ?>"<?php if (isset($gopay[$store['store_id']]['order_status_id']) && $order_status['order_status_id'] == $gopay[$store['store_id']]['order_status_id']) echo ' selected="selected"'; ?>><?php echo $order_status['name']; ?></option>
                                  <?php } ?>
								</select>
							  </div>
						    </div>
							<div class="form-group as_default_order_status_<?php echo $store['store_id']; ?>">
							  <label class="col-sm-2 control-label" for="input-order-status-success"><?php echo $entry_order_status_success; ?></label>
							  <div class="col-sm-10">
							    <select name="gopay[<?php echo $store['store_id']; ?>][order_status_id_success]" id="input-order-status-success" class="form-control">
								  <?php foreach ($order_statuses as $order_status) { ?>
                                  <option value="<?php echo $order_status['order_status_id']; ?>"<?php if (isset($gopay[$store['store_id']]['order_status_id_success']) && $order_status['order_status_id'] == $gopay[$store['store_id']]['order_status_id_success']) echo ' selected="selected"'; ?>><?php echo $order_status['name']; ?></option>
                                  <?php } ?>
								</select>
							  </div>
						    </div>
							<div class="form-group as_default_order_status_<?php echo $store['store_id']; ?>">
							  <label class="col-sm-2 control-label" for="input-order-status-failed"><?php echo $entry_order_status_failed; ?></label>
							  <div class="col-sm-10">
							    <select name="gopay[<?php echo $store['store_id']; ?>][order_status_id_failed]" id="input-order-status-failed" class="form-control">
								  <?php foreach ($order_statuses as $order_status) { ?>
                                  <option value="<?php echo $order_status['order_status_id']; ?>"<?php if (isset($gopay[$store['store_id']]['order_status_id_failed']) && $order_status['order_status_id'] == $gopay[$store['store_id']]['order_status_id_failed']) echo ' selected="selected"'; ?>><?php echo $order_status['name']; ?></option>
                                  <?php } ?>
								</select>
							  </div>
						    </div>
						  </fieldset>
						</div>
						<div class="tab-pane" id="tab-store-<?php echo $store['store_id']; ?>-payment-method">
						  <?php if (empty($payment_methods[$store['store_id']])) { ?>
			              <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_no_payment_methods; ?></div>
			              <?php } else { ?>
						  <label><input type="checkbox" name="gopay[<?php echo $store['store_id']; ?>][default][method]" value="1" class="as_default" id="as_default_method_<?php echo $store['store_id']; ?>"<?php if (empty($gopay[$store['store_id']]) || !empty($gopay[$store['store_id']][$store['store_id']]['method'])) echo ' checked="checked"'; ?> /> <?php echo $text_same_as_default; ?></label>
						  <div class="table-responsive as_default_method_<?php echo $store['store_id']; ?>">
                            <table class="table table-bordered table-hover">
							  <thead>
				                <tr>
				                  <td class="text-center" style="width:1px;"><?php echo $entry_disable; ?></td>
				                  <td class="text-right"><?php echo $entry_sort_order; ?></td>
				                  <td class="text-left"><?php echo $entry_image; ?></td>
				                  <td class="text-left"><?php echo $entry_title; ?></td>
				                  <td class="text-right"><?php echo $entry_total_min; ?></td>
				                  <td class="text-right"><?php echo $entry_total_max; ?></td>
				                  <td class="text-right"><?php echo $entry_cost; ?></td>
				                  <td class="text-right"><?php echo $entry_offline; ?></td>
				                </tr>
				              </thead>
				              <tbody>
				                <?php foreach ($payment_methods[$store['store_id']] as $method) { ?>
				                <?php $method_data = (isset($gopay[$store['store_id']]['method'][$method->code]) ? $gopay[$store['store_id']]['method'][$method->code] : array()); ?>
				                <tr><td class="text-left" colspan="8"><b><?php echo $method->paymentMethod; ?></b></td></tr>
				                <tr>
				                  <td class="text-center"><input type="checkbox" name="gopay[<?php echo $store['store_id']; ?>][method][<?php echo $method->code; ?>][disabled]" value="1" class="method-disable"<?php if (!empty($method_data['disabled'])) echo ' checked="checked"'; ?> /></td>
					              <td class="text-right"><input type="text" name="gopay[<?php echo $store['store_id']; ?>][method][<?php echo $method->code; ?>][sort_order]" value="<?php if (isset($method_data['sort_order'])) echo $method_data['sort_order']; ?>" size="1" /></td>
                                  <td class="text-left">
								    <a href="" id="method-<?php echo $method->code; ?>-<?php echo $store['store_id']; ?>-thumb" data-toggle="image" class="img-thumbnail"><img src="<?php echo (!empty($method_data['image']) && file_exists(DIR_IMAGE . $method_data['image']) ? HTTPS_CATALOG . 'image/' . $method_data['image'] : $method->logo); ?>" alt="" title="" data-placeholder="<?php echo $method->logo; ?>" /></a>
                                    <input type="hidden" name="gopay[<?php echo $store['store_id']; ?>][method][<?php echo $method->code; ?>][image]" value="<?php if (isset($method_data['image'])) echo $method_data['image']; ?>" id="method-<?php echo $method->code; ?>-<?php echo $store['store_id']; ?>-image" />
					                <input type="hidden" name="gopay[<?php echo $store['store_id']; ?>][method][<?php echo $method->code; ?>][image_orig]" value="<?php echo $method->logo; ?>" />
				                  </td>
				                  <td class="text-left">
				                    <?php foreach ($languages as $language) { ?>
					                <div><input type="text" name="gopay[<?php echo $store['store_id']; ?>][method][<?php echo $method->code; ?>][title][<?php echo $language['language_id']; ?>]" value="<?php if (isset($method_data['title'][$language['language_id']])) echo $method_data['title'][$language['language_id']]; ?>" />&nbsp;<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></div>
					                <?php } ?>
					                <input type="hidden" name="gopay[<?php echo $store['store_id']; ?>][method][<?php echo $method->code; ?>][title_orig]" value="<?php echo $method->paymentMethod; ?>" />
				                  </td>
				                  <td class="text-right">
				                    <input type="text" name="gopay[<?php echo $store['store_id']; ?>][method][<?php echo $method->code; ?>][min]" value="<?php if (isset($method_data['min'])) echo $method_data['min']; ?>" />
				                  </td>
				                  <td class="text-right">
				                    <input type="text" name="gopay[<?php echo $store['store_id']; ?>][method][<?php echo $method->code; ?>][max]" value="<?php if (isset($method_data['max'])) echo $method_data['max']; ?>" />
				                  </td>
					              <td class="text-right">
				                    <input type="text" name="gopay[<?php echo $store['store_id']; ?>][method][<?php echo $method->code; ?>][cost]" value="<?php if (isset($method_data['cost'])) echo $method_data['cost']; ?>" size="2" />%
				                  </td>
					              <td class="text-right"><?php echo ($method->offline ? $text_yes : $text_no); ?></td>
				                </tr>
				                <?php } ?>
				              </tbody>
							</table>
						  </div>
						  <?php } ?>
						</div>
					  </div>
					</div>
					<?php } ?>
		          </div>
				</div>
			  </div>
			</div>
		  </div>
        </form>
	  </div>
    </div>
  </div>
</div>
<style>
table tr.disabled td {
	background-color: #FF0000;
	opacity: 0.5;
}
</style>
<script type="text/javascript"><!--
$().ready(function() {
	$('.as_default').change(function() {
		if ($(this).is(':checked')) {
			$('.' + $(this).attr('id')).fadeTo(200, 0.4);
		} else {
			$('.' + $(this).attr('id')).fadeTo(200, 1);
		}
	}).change();

	$('.method-disable').change(function() {
		if ($(this).is(':checked')) {
			$(this).closest('tr').addClass('disabled');
		} else {
			$(this).closest('tr').removeClass('disabled');
		}
	}).change();
});

$('.nav').each(function() {
	$('a:first', this).tab('show');
});
//--></script> 
<?php echo $footer; ?> 