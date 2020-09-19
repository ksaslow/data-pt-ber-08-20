### Subqueries_sql_class

# In the publications database, create a query which outputs the name of the store, 
# alongisde the number of orders (count of distinct order ids), the count of titles and the sum of the quantity from the sales table.

CREATE TEMPORARY TABLE publications.store_sales_summary
SELECT stores.stor_name AS Store, COUNT(DISTINCT ord_num) AS Orders, COUNT(title_id) AS TitleCount, SUM(qty) AS Quantity # NOTE that for the sales table, you can refer to just the column names, because they are unique to the sales table. 
FROM publications.stores
INNER JOIN publications.sales ON stores.stor_id = sales.stor_id
GROUP BY Store
ORDER BY Store;

# inspecting the temporary table
SELECT * FROM publications.store_sales_summary;

# Doing the calculations:
SELECT Store, TitleCount / Orders as AvgItems, Quantity / TitleCount AS AvgQtyItem   # because this is a simple SELECT statement, you dont need to specify which table youre calling the attribute from. 
FROM publications.store_sales_summary;


# SUBquery:

SELECT Store, TitleCount / Orders as AvgItems, Quantity / TitleCount AS AvgQtyItem   
FROM 
(SELECT stores.stor_name AS Store, COUNT(DISTINCT ord_num) AS Orders, COUNT(title_id) AS TitleCount, SUM(qty) AS Quantity 
FROM publications.stores
INNER JOIN publications.sales ON stores.stor_id = sales.stor_id
GROUP BY Store
ORDER BY Store) AS summary;
