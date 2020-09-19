SELECT * 
FROM publications.publishers  # since we set it as default schema, you could also just call for publishers and not publications.publishers! 
INNER JOIN publications.titles
ON publishers.pub_id = titles.pub_id; 

SELECT *    # if you change the order (as in which is table a and which is table b), the output number of rows is the same since its an INNER JOIN, but the ORDER of columns will change
FROM publications.titles
INNER JOIN publications.publishers
ON titles.pub_id = publishers.pub_id;

SELECT * 
FROM publications.publishers
LEFT JOIN publications.titles  # you will get null values here, because if it is NOT an inner join, you will get empty values created. Here, the null values represent publishing houses that HAVE NOT published any titles. 
ON publishers.pub_id = titles.pub_id; 
# sometimes a left join is better than inner join, because say zB you want to know what each publishing house has published, it also an Ergebniss to know that some have not published ANY! And this would have been lost in an inner join. 

SELECT *
FROM publications.titles
LEFT JOIN publications.publishers
ON titles.pub_id = publishers.pub_id;
# in this case, ALL titles have a publisher. In other words, there are no titles that don't appear in the publishers table. 

# now instead of selecting, all, just select: pub_name, title_id, and title:
SELECT publishers.pub_name, titles.title_id, titles.title
FROM publications.publishers  
INNER JOIN publications.titles
ON publishers.pub_id = titles.pub_id; 

# see how many titles ONE publisher has published, e.g. combine JOIN with an AGGREGATION. 
SELECT publishers.pub_name, COUNT(titles.title_id)
FROM publications.publishers  
INNER JOIN publications.titles
ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_name;

# But this only has 3 publishers. (only if count > 0). To get ALL publishers you need a left join
SELECT publishers.pub_name, COUNT(titles.title_id)
FROM publications.publishers  
LEFT JOIN publications.titles
ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_name;

# Giving an ALIAS: 
SELECT publishers.pub_name, COUNT(titles.title_id) AS count_titles   # Here you are defining your alias. Generally, aliases are temporary and exist only in this single query! 
FROM publications.publishers  
LEFT JOIN publications.titles
ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_name
ORDER BY count_titles DESC;   # you can refer back to the alias here. Generally, it makes sense to use an alias when using aggregated queries. 

# You can also ALIAS you TABLES directly in the join:
SELECT p.pub_name, COUNT(t.title_id) AS count_titles   # Here you have to call the NEWLY named tables, not the old tables 
FROM publications.publishers AS  p   # here, you can rename your table DIRECTLY
LEFT JOIN publications.titles AS  t    # same here
ON p.pub_id = t.pub_id  # Here, you could also use the command USING(pub_id) to save yourself some typing and maybe even more logical 
GROUP BY p.pub_name
ORDER BY count_titles DESC; 
