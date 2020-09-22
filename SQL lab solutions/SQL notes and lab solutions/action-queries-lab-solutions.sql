-- Action Queries Lab:

-- 1. create new table: total_royalties which for each author contains their author ID, last name, first name, number of total titles and the sum of royalties they have received

CREATE TABLE publications.total_royalties
SELECT authors.au_id AS AuthID, authors.au_lname AS LastName, authors.au_fname AS FirstName, COUNT(titleauthor.title_id) AS TotalTitles, SUM(titleauthor.royaltyper) AS TotalRoyalties
FROM publications.authors
INNER JOIN publications.titleauthor ON authors.au_id = titleauthor.au_id
GROUP BY AuthID;

SELECT * FROM publications.total_royalties;

-- 2. Delete every author which has received total royalties of less than 100.

DELETE FROM publications.total_royalties
WHERE TotalRoyalties < 100;

SELECT * FROM publications.total_royalties; 

-- 3. Create a new column of type float called AvgRoyalty (this is an ALTER TABLE statement)

ALTER TABLE publications.total_royalties
ADD AvgRoyalty FLOAT;  -- here you need to already define the column name and specify the DATA TYPE!

SELECT * FROM publications.total_royalties; 

-- 4. Update the new column AvgRoyalty to equal the average royalty per title for each author.
UPDATE publications.total_royalties
SET AvgRoyalty = TotalRoyalties/TotalTitles; 

SELECT * FROM publications.total_royalties; 

-- 5. Empty all of the values in the table.

DELETE FROM publications.total_royalties;

SELECT * FROM publications.total_royalties; 

-- 6. Repopulate the table to contain the same values as it did after step (4), in one single query (you have to use a subquery here)!

SELECT AuthID, LastName,  FirstName, TotalTitles, TotalRoyalties, AvgRoyalty
FROM
(SELECT authors.au_id AS AuthID, authors.au_lname AS LastName, authors.au_fname AS FirstName, COUNT(titleauthor.title_id) AS TotalTitles, SUM(titleauthor.royaltyper) AS TotalRoyalties, SUM(titleauthor.royaltyper)/COUNT(titleauthor.title_id) AS AvgRoyalty
FROM publications.authors
INNER JOIN publications.titleauthor ON authors.au_id = titleauthor.au_id
GROUP BY AuthID) AS Royalites_Summary; 

-- 7. Delete the table total_royalties

DROP TABLE publications.total_royalties;
