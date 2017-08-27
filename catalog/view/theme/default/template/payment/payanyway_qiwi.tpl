<form action="<?php echo $action; ?>" method="post" id="payment">
	<input type="hidden" name="MNT_ID" value="<?php echo $mnt_id; ?>" />
	<input type="hidden" name="MNT_TRANSACTION_ID" value="<?php echo $order_id; ?>" />
	<input type="hidden" name="MNT_CURRENCY_CODE" value="<?php echo $currency; ?>" />
	<input type="hidden" name="MNT_AMOUNT" value="<?php echo $amount; ?>" />
	<input type="hidden" name="MNT_TEST_MODE" value="<?php echo $mnt_test_mode; ?>" />
	<input type="hidden" name="MNT_SIGNATURE" value="<?php echo $mnt_signature; ?>" />
	<input type="hidden" name="paymentSystem.unitId" value="<?php echo $paymentSystemUnitId; ?>" />
	<input type="hidden" name="MNT_SUCCESS_URL" value="<?php echo $mnt_success_url; ?>" />
	<input type="hidden" name="MNT_FAIL_URL" value="<?php echo $mnt_fail_url; ?>" />
	<input type="hidden" name="followup" value="true" />
	<input type="hidden" name="javascriptEnabled" value="true" />

	<h2><?php echo $entry_additionalParameters; ?></h2>
	<div class="content">
	  <table class="form">
		<tr>
			<td><span class="required">*</span><?php echo $entry_qiwiUser; ?></td>
			<td>
				<input type="text" class="large-field" id="qiwiUser" name="additionalParameters.qiwiUser" value="">
				<small><?php echo $entry_qiwiUserHelp?></small>
			</td>
		</tr>
		<tr>
			<td><?php echo $entry_qiwiComment; ?></td>
			<td>
				<input type="text" class="large-field" id="qiwiComment" name="additionalParameters.qiwiComment" value="">
			</td>
		</tr>
	  </table>
	</div>
  
	<div class="buttons">
		<div class="pull-right"><input type="button" value="<?php echo $button_confirm; ?>" id="button-confirm" class="btn btn-primary" /></div>
	</div>
</form>

<script type="text/javascript">
$('#button-confirm').bind('click', function() {
	
	if ($('#qiwiUser').val() == '' || !/^[\d]{10}$/.test($('#qiwiUser').val()))
	{
		alert("<?php echo $entry_qiwiUserError ?>");
	} else {
		$('#payment').submit();
	}
});
</script> 
