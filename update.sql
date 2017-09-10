ALTER TABLE  `order` ADD  `del_info` TEXT NOT NULL ;

UPDATE
	`order` o
	INNER JOIN `order_product` op ON o.order_id = op.order_id
		SET o.del_info = op.del_info
WHERE o.del_info = '' AND op.del_info != ''