<table class="table cartTotals" id="cartBlock">
    <?php foreach ($totals as $total) { ?>
        <tr>
            <td class="text-right"><?php echo $total['title']; ?>:</td>
            <td class="text-right total"><?php echo $total['text']; ?></td>
        </tr>
    <?php } ?>
</table>