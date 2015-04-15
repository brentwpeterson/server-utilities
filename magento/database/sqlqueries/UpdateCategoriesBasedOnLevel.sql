
#ALWAYS BE SURE OF THE HARDCODED ATTRIBUTE IDS
#in this example we were upating the "include in menu" value to be NO for any 3rd level or lower category. 
select * from eav_entity_type;
select * from eav_attribute where attribute_code = 'name' and entity_type_id = 3;
select * from eav_attribute where attribute_code = 'include_in_menu' and entity_type_id = 3;

#will return the category name, with "tmpl" column being the level (0 is root, 1 is top level, 2 is second). 
select E.entity_id, (SELECT LENGTH(E.path)-LENGTH(REPLACE(E.path,'/','')) - 1) AS tmpl, V.value
from catalog_category_entity E
left join catalog_category_entity_varchar V on (E.entity_id = V.entity_id)
where V.attribute_id = 41 having tmpl > 2;

#return only the "include in menu" settings, using the same logic (3rd level and lower returned only). 
select I.entity_id, I.value from catalog_category_entity_int I
right join catalog_category_entity E on (E.entity_id = I.entity_id and (select LENGTH(E.path)-LENGTH(REPLACE(E.path,'/','')) - 1) > 2)
where E.entity_id is not null and I.attribute_id = 67

#if the above select works, this will update the values. 
update catalog_category_entity_int I
right join catalog_category_entity E on (E.entity_id = I.entity_id and (select LENGTH(E.path)-LENGTH(REPLACE(E.path,'/','')) - 1) > 2)
set I.value = 0
where E.entity_id is not null and I.attribute_id = 67