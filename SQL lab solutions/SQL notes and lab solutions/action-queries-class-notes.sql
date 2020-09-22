
-- syntax for temp. table changed to perm. table
CREATE  TABLE publications.store_sales_summary
SELECT stores.stor_name AS Store, COUNT(DISTINCT ord_num) AS Orders, COUNT(title_id) AS TitleCount, SUM(qty) AS Quantity # NOTE that for the sales table, you can refer to just the column names, because they are unique to the sales table. 
FROM publications.stores
INNER JOIN publications.sales ON stores.stor_id = sales.stor_id
GROUP BY Store;

-- drop rows by condition: 
-- note that dropping ROWS does not affect schema so much. Dropping columns however does. 

DELETE FROM publications.store_sales_summary
WHERE Quantity < 100; 

-- delete all rows unconditionatlly:

DELETE FROM publications.store_sales_summary; 

-- deleting the whole table:
DROP TABLE publications.store_sales_summary; 

DROP TABLE publications.authors_titlesales_summary; -- drop the table I accidentally made! 

CREATE TABLE publications.store_sales_summary
SELECT stores.stor_name AS Store, COUNT(DISTINCT ord_num) AS Orders, COUNT(title_id) AS TitleCount, SUM(qty) AS Quantity # NOTE that for the sales table, you can refer to just the column names, because they are unique to the sales table. 
FROM publications.stores
INNER JOIN publications.sales ON stores.stor_id = sales.stor_id
GROUP BY Store


-- Deleting only specific columns:
-- Be careful when doing this. This is a big change to the schema. The script might not run well because somewhere you may reference a column that now no longer exists. Any pre-written queries 
-- that use column Quantity will now no longer run. 
ALTER TABLE publications.store_sales_summary
DROP COLUMN Quantity;

DROP TABLE publications.store_sales_summary; 

CREATE TABLE publications.store_sales_summary
SELECT stores.stor_name AS Store, COUNT(DISTINCT ord_num) AS Orders, COUNT(title_id) AS TitleCount, SUM(qty) AS Quantity # NOTE that for the sales table, you can refer to just the column names, because they are unique to the sales table. 
FROM publications.stores
INNER JOIN publications.sales ON stores.stor_id = sales.stor_id
GROUP BY Store
ORDER BY Store;

-- First, for the sake of teaching, empty the table to repopulate it:
DELETE FROM publications.store_sales_summary; 

-- Repopulating it! 
-- when you insert data into a table, you need to RESPECT the structure of the table. This means you cant just add a 5th column to this table that you just emptied. 
INSERT INTO publications.store_sales_summary
SELECT stores.stor_name AS Store, COUNT(DISTINCT ord_num) AS Orders, COUNT(title_id) AS TitleCount, SUM(qty) AS Quantity # NOTE that for the sales table, you can refer to just the column names, because they are unique to the sales table. 
FROM publications.stores
INNER JOIN publications.sales ON stores.stor_id = sales.stor_id
GROUP BY Store;

SELECT * FROM publications.store_sales_summary;
-- you can do this 5 times, and it would just duplicate the rows of data 5 times since there is no primary key to complain about having duplicates!

-- updating data in the table:
UPDATE publications.store_sales_summary
SET Quantity = Quantity*2; 
-- similarly, if you run this again, it will make it times 2 again (so I"ve run it twice so now its actually *4) 

SELECT * FROM publications.store_sales_summary; 

-- ALL of these action queries have permanent results so they should be used with CAUTION! 


