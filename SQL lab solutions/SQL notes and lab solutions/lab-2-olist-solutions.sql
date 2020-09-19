SELECT MIN(first_contact_date), MAX(first_contact_date) 
FROM olist.marketing_qualified_leads;

SELECT origin, COUNT(origin) 
FROM olist.marketing_qualified_leads
WHERE first_contact_date >= "2018-01-01"
GROUP BY origin
ORDER BY COUNT(origin) DESC
LIMIT 3; 

SELECT COUNT(mql_id), first_contact_date
FROM olist.marketing_qualified_leads
GROUP BY first_contact_date
ORDER BY COUNT(mql_id) DESC 
LIMIT 1;
SELECT product_category_name, COUNT(product_category_name)
FROM olist.products 
GROUP BY product_category_name
ORDER BY COUNT(product_category_name) DESC
LIMIT 2;
SELECT product_category_name, product_weight_g
FROM olist.products
ORDER BY product_weight_g DESC
LIMIT 1;
SELECT product_category_name, MAX(product_width_cm + product_length_cm + product_height_cm) as dimension
FROM olist.products
GROUP BY product_category_name
ORDER BY dimension DESC
LIMIT 20;










