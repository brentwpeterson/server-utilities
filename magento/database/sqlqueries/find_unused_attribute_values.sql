#the query below can be used to find values in a multiselect/select attribute that 
#are not currently being used by any products (no product has that value assigned). 

#but the attribute_code you are interested in looking at in place of ATTRIBUTECODE


select o.*, v.*
      FROM `eav_attribute` a
INNER JOIN `eav_attribute_option` o ON a.`attribute_id` = o.`attribute_id`
INNER JOIN `eav_attribute_option_value` v ON v.`option_id` = o.`option_id`
INNER JOIN `eav_entity_type` t ON t.`entity_type_id` = a.`entity_type_id`
 LEFT JOIN `catalog_product_entity_int` pi ON o.`option_id` = pi.`value` AND o.`attribute_id` = pi.`attribute_id`
 LEFT JOIN `catalog_product_entity_varchar` pv ON o.`option_id` = pv.`value` AND o.`attribute_id` = pv.`attribute_id`
     WHERE pi.`entity_id` IS NULL
       AND pv.`entity_id` IS NULL
       AND t.`entity_type_code` = "catalog_product"
		AND a.`attribute_code` = 'ATTRIBUTECODE';
