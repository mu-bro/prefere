<div class="source_found">
    <table cellpadding="0"  cellspacing="0">
        <tr>
            <td><?php echo $source_found_text; ?></td>
            <td><i class="fa fa-facebook-square" aria-hidden="true" title="Facebook"></i></td>
            <td><i class="fa fa-instagram" aria-hidden="true" title="Instagram"></i></td>
            <td><i class="fa fa-vk" aria-hidden="true" title="Vkontakte"></i></td>
        </tr>
    </table>
</div>
<script type="text/javascript"><!--
    $('.source_found td i').on('click', function () {
        if (!$(this).hasClass('active')) {
            $('.source_found td i').addClass('half-hidden').removeClass('active');
            $(this).removeClass('half-hidden').addClass('active');
            $('#source_found').val($(this).attr('title'));
        } else {
            $('.source_found td i').removeClass('half-hidden').removeClass('active');
            $('#source_found').val('');
        }

        $.ajax({
            url: 'index.php?route=checkout/cart/updatesource',
            type: 'post',
            data: 'source=' + encodeURIComponent($('#source_found').val()),
            dataType: 'json'
        });
    });
    //--></script>