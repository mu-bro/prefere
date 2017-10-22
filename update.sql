ALTER TABLE  `order` ADD  `del_info` TEXT NOT NULL ;

UPDATE
	`order` o
	INNER JOIN `order_product` op ON o.order_id = op.order_id
		SET o.del_info = op.del_info
WHERE o.del_info = '' AND op.del_info != '';


update product set points = price;
DELETE FROM `product_reward`;
INSERT INTO product_reward (product_id, customer_group_id, points) SELECT product_id, 1, price/10 FROM product;

ALTER TABLE  `banner_image_description` CHANGE  `title`  `title` VARCHAR( 512 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ;


UPDATE  `product` SET  `manufacturer_id` =  '0';
