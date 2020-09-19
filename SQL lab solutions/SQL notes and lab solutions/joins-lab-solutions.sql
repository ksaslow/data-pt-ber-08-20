# Lab 5: (Week 4, Saturday)

# Challenge 0: 
# a) Create a table which for each author contains their author id, first name, last name, and the total number of titles they have written according to the titleauthor table.
#  Give each variable an alias, such that the table output is easy to read and interpret.
SELECT  au_id AS AuthorID, au_lname AS AuthorLastName, au_fname AS AuthorFirstName, COUNT(title_id) AS NumTitles
FROM publications.authors
LEFT JOIN publications.titleauthor
USING(au_id)  # here, USING works, beacuse the columns have the same name in BOTH tables. with the ON command, you can use 2 different columns even if they have DIFFERENT names! 
GROUP BY AuthorID; 

# b)  Create a table which for each job description contains the first hire date (i.e. the first employee with this job id was hired). 
# Again, name the columns properly to have a nice return table. Sort the results from the job description with the first hire to the one with the last hire.
SELECT jobs.job_id AS JobID, jobs.job_desc AS JobDescription, employee.hire_date AS HireDate
FROM publications.jobs
LEFT JOIN publications.employee
USING(job_id)
ORDER BY HireDate;

# Challenge 1:
# start with authors table, the titleauthor table, and the publishers table (problem is no conncetion between titleauthor and publishers. need to use 4th table!)
# join authors and titleauthor tables with au_id
# join the titelauthor table to titles table with title_id and THEN join it to publishers table with pub_id:
SELECT  authors.au_lname AS AuthLastName, authors.au_fname AS AuthFirstName, titleauthor.au_id AS AuthorID, titles.title AS Title, publishers.pub_name AS Publisher
FROM publications.authors
LEFT JOIN publications.titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN publications.titles ON titleauthor.title_id = titles.title_id
LEFT JOIN publications.publishers ON titles.pub_id = publishers.pub_id
WHERE Title is not null  # This is to ensure that youre not returning authors who have no titles. 
ORDER BY AuthLastName;

# Challenge 2:
SELECT  authors.au_lname AS AuthLastName, authors.au_fname AS AuthFirstName, titleauthor.au_id AS AuthorID, COUNT(titles.title_id) AS TitleCount, publishers.pub_name AS Publisher
FROM publications.authors
INNER JOIN publications.titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN publications.titles ON titleauthor.title_id = titles.title_id
INNER JOIN publications.publishers ON titles.pub_id = publishers.pub_id
GROUP BY AuthorID, Publisher
ORDER BY TitleCount; 

# Challenge 3:
# Who are the top 3 authors who have sold the highest number of titles? Write a query to find out. 
SELECT authors.au_id AS AuthID, authors.au_lname AS AuthLastName, authors.au_fname AS AuthFirstName, SUM(sales.qty) as TotalSold
FROM publications.authors
LEFT JOIN publications.titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN publications.sales ON titleauthor.title_id = sales.title_id
GROUP BY AuthID
ORDER BY TotalSold DESC
LIMIT 3;

# Challenge 4:
SELECT authors.au_id AS AuthID, authors.au_lname AS AuthLastName, authors.au_fname AS AuthFirstName, SUM(sales.qty) as TotalSold
FROM publications.authors
LEFT JOIN publications.titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN publications.sales ON titleauthor.title_id = sales.title_id
GROUP BY AuthID
ORDER BY TotalSold DESC;