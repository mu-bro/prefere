<?php
// Heading
$_['heading_title']              = 'GoPay';

// Text
$_['text_gopay']                 = '<a onclick="window.open(\'https://www.gopay.cz/\');"><img src="view/image/payment/gopay.png" alt="GoPay" title="GoPay" style="border: 1px solid #EEEEEE;" /></a>';
$_['text_payment']               = 'Payment';
$_['text_success']               = 'Success: You have modified GoPay account details!';
$_['text_image_manager']         = 'Image Manager';
$_['text_browse']                = 'Browse Files';
$_['text_clear']                 = 'Clear Image';
$_['text_original']              = 'Original Image';
$_['text_content_top']           = 'Content Top';
$_['text_content_bottom']        = 'Content Bottom';
$_['text_column_left']           = 'Column Left';
$_['text_column_right']          = 'Column Right';
$_['text_image_link']            = 'Images can be created using <a href="%s" target="_blank">this configuration tool</a>.';
$_['text_credentials']           = 'Login Data';
$_['text_restrictions']          = 'Restrictions';
$_['text_order_statuses']        = 'Order Statuses';
$_['text_same_as_default']       = 'same as default';
$_['text_order_confirm_redirect']= 'after order confirmation';
$_['text_order_confirm_callback']= 'after message from GoPay';

// Entry
$_['entry_goid']                 = 'GoPay ID';
$_['entry_secret']               = 'GoPay Secret';
$_['entry_separate_method']      = '<span data-toggle="tooltip" title="Customer will choose payment method in checkout. If disabled, customer will choose payment method on GoPay page.">Show Payment Methods Separately</span>';
$_['entry_callback']             = '<span data-toggle="tooltip" title="This has to be sent to the GoPay service.">HTTP notification URL</span>';
$_['entry_total']                = '<span data-toggle="tooltip" title="The checkout total the order must reach before this payment method becomes active.">Total</span>';
$_['entry_order_status']         = '<span data-toggle="tooltip" title="After order confirmation.">Order Status</span>';
$_['entry_order_status_success'] = '<span data-toggle="tooltip" title="After payment has been received.">Order Status</span>';
$_['entry_order_status_failed']  = '<span data-toggle="tooltip" title="After payment has been cancelled.">Order Status</span>';
$_['entry_geo_zone']             = 'Geo Zone';
$_['entry_status']               = 'Status';
$_['entry_sort_order']           = 'Sort Order';
$_['entry_test']                 = 'Test Operation';
$_['entry_image']                = 'Image';
$_['entry_layout']               = 'Layout';
$_['entry_position']             = 'Position';
$_['entry_disable']              = 'Disable';
$_['entry_title']                = 'Title';
$_['entry_total_min']            = 'Minumal Total';
$_['entry_total_max']            = 'Maximal Total';
$_['entry_offline']              = 'Offline';
$_['entry_order_confirm']        = 'Submit order';

// Tab
$_['tab_payment_method']         = 'Payment Methods';
$_['tab_presentation']           = 'Presentation';
$_['tab_default']                = 'Default';

// Error
$_['error_permission']           = 'Warning: You do not have permission to modify payment GoPay!';
$_['error_goid']                 = 'GoPay ID is required!';
$_['error_secret']               = 'GoPay Secret is required!';
$_['error_module_required']      = 'Warning: At least one presentation module is required!';
$_['error_module']               = 'Image is required!';
$_['error_no_payment_methods']   = 'Warning: Could not load payment methods!';