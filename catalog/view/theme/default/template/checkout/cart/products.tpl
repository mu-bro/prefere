<tr id="cartProduct<?php echo $product['cart_id']; ?>">
    <td class="cartProductInfo">
        <?php if ($product['thumb']) { ?>
            <div class="image">
                <a href="<?php echo $product['href']; ?>">
                    <img src="<?php echo $product['thumb']; ?>"
                         alt="<?php echo $product['name']; ?>"
                         title="<?php echo $product['name']; ?>"/>
                </a>
            </div>
        <?php } ?>
    </td>
    <td class="title">
        <a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
        <?php if (!$product['stock']) { ?>
            <span class="stock">***</span>
        <?php } ?>
        <div>
            <?php foreach ($product['option'] as $option) { ?>
                <small><?php echo $option['name']; ?>
                    : <?php echo $option['value']; ?></small>
                <br/>
            <?php } ?>
        </div>
    </td>
    <td class="price">
        <?php echo $product['total']; ?>
    </td>
    <td class="quantity">
        <select name="quantity[<?php echo $product['cart_id']; ?>]"
                class="form-control"
                rel="<?php echo $product['cart_id']; ?>">
            <?php for ($i = 1; $i <= 10; $i++) { ?>
                <option value="<?php echo $i; ?>" <?php if ($i == $product['quantity']) echo 'selected="selected"';
                ?>><?php echo $i; ?></option>
            <?php } ?>
        </select>
    </td>
    <td class="price">
        <?php echo $product['total']; ?>
    </td>
    <td>
        <div class="removeBlock">
            <a class="removeButton" href="javascript:void(0);"
               title="<?php echo $button_remove; ?>"
               onclick="cart.remove('<?php echo $product['cart_id']; ?>',<?php echo ($k == 0) ? 'true' : 'false'; ?>);"><i
                    class="fa fa-2 fa-times"></i></a>
        </div>
    </td>
</tr>