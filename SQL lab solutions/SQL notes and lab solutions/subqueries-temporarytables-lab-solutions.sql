-- LAB on subqueries and temporary tables:

-- First with TempTable

-- In this challenge, please create a table which for each author contains their author ID, last name, first name, number of total titles and the sum of royalties they have received,

CREATE TEMPORARY TABLE publications.authors_titlesales_summary
SELECT authors.au_id as AuthID, authors.au_lname as AuthLast, authors.au_fname as AuthFirst, COUNT(titleauthor.title_id) as TotalTitles, SUM(titleauthor.royaltyper) as Royalties
FROM publications.authors
LEFT JOIN publications.titleauthor ON authors.au_id = titleauthor.au_id
GROUP BY AuthID;

SELECT * FROM publications.authors_titlesales_summary;

-- In a second step, we from this table would then like to calculate the average royalty per title each author has received. 
-- The final table should contain for each author their author ID, last name, first name and average royalty calculated as sum of royalties divided by title count.

SELECT AuthID, AuthLast, AuthFirst, Royalties/TotalTitles AS AvgRoyalty
FROM publications.authors_titlesales_summary;

-- Now do this with a subquery: 

SELECT AuthID, AuthLast, AuthFirst, Royalties/TotalTitles AS AvgRoyalty
FROM 
(SELECT authors.au_id as AuthID, authors.au_lname as AuthLast, authors.au_fname as AuthFirst, COUNT(titleauthor.title_id) as TotalTitles, SUM(titleauthor.royaltyper) as Royalties
FROM publications.authors
LEFT JOIN publications.titleauthor ON authors.au_id = titleauthor.au_id
GROUP BY AuthID) AS AuthTitleSalesSummary;
