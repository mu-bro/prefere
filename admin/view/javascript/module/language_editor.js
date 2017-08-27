(function($){
	
	/**
	 * Get URL param by name
	 */
	$.urlParam = function(name){
	    var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
	    return (results==null) ? null : (decodeURIComponent(results[1]) || 0); 
	}
	
	$(document).ready(function(){
		
		$('.wysiwyg_editor').summernote();
		
		/**
		 * Search Form
		 */
		$('#form-filter-btn').click(function(e){
			e.preventDefault();
			
			var url = 'index.php?route=module/language_editor&token=' + $.urlParam('token');
			
			var filter_language = $('select[name=\'filter_language\']').val();			
			if (filter_language) {
				url += '&filter_language=' + encodeURIComponent(filter_language);
			}
			
			var filter_admin = $('input[name=\'filter_admin\']').is(':checked');			
			if (filter_admin) {
				url += '&filter_admin=1';
			}

			var filter_search = $('input[name=\'filter_search\']').val();
			if (filter_search) {
				url += '&filter_search=' + encodeURIComponent(filter_search);
			}
						
			window.location.href = url;
		});
		
		/**
		 * Display HTML editor
		 */
		$('.show-editor').click(function(){
			var $field = $(this).parents('.input-group').find('.form-control'),
				 value = $field.val();
			
			// Remove input-group
			$field.parent().after($field).remove();
			
			var $editor = $(document.createElement('textarea')).attr({
				'id': $field.attr('id'),
				'name': $field.attr('name')				
			});
			
			// Replace with textarea for summernote
			$field.replaceWith($editor);
						
			$editor.summernote({ focus: true }).code(value);
			
			$(this).remove();
		});
				
	});//doc.ready
	
})(jQuery);