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
            <?php } ?>
        </div>
    </td>
    <td class="price">
        <?php echo $product['total']; ?>
    </td>
    <td class="quantity">
        <div class="input-group">
            <input type="text"
                   name="quantity[<?php echo $product['cart_id']; ?>]"
                   value="<?php echo $product['quantity']; ?>"
                   class="form-control input-number"
                   rel="<?php echo $product['cart_id']; ?>"
                   min="1" max="50" />
        </div>
    </td>
    <td class="total">
        <?php echo $product['total']; ?>
    </td>
    <td>
        <div class="removeBlock">
            <a class="removeButton" href="javascript:void(0);"
               title="<?php echo $button_remove; ?>"
               onclick="cart.remove('<?php echo $product['cart_id']; ?>',<?php echo ($k == 0) ? 'true' : 'false'; ?>);">
                <img src="catalog/view/theme/default/image/remove-button.png" />
            </a>
        </div>
    </td>
</tr>