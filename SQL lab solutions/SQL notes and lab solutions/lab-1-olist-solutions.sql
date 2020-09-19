SELECT price from olist.order_items LIMIT 10; 
SELECT max(price) from olist.order_items;
SELECT min(price) from olist.order_items;
SELECT DISTINCT customer_state  from olist.customers WHERE max(customer_id);
SELECT customer_id from olist.customers WHERE customer_state = "AC";
SELECT COUNT(customer_id) FROM olist.customers WHERE customer_state = "AL";
SELECT COUNT(customer_id), customer_state FROM olist.customers GROUP BY customer_state ORDER BY COUNT(customer_id) DESC LIMIT 3;
SELECT COUNT(customer_id), customer_city 
FROM olist.customers 
WHERE customer_state ="SP" 
GROUP BY customer_city 
ORDER BY COUNT(customer_id) DESC LIMIT 3;
SELECT DISTINCT business_segment 
FROM olist.closed_deals
WHERE business_segment IS NOT null;
SELECT business_segment, sum(declared_monthly_revenue)
FROM olist.closed_deals
GROUP BY business_segment
ORDER BY sum(declared_monthly_revenue) DESC LIMIT 3;
SELECT DISTINCT review_score FROM olist.order_reviews;
SELECT review_score, COUNT(review_score)
FROM olist.order_reviews
GROUP BY review_score
ORDER BY COUNT(review_score) DESC LIMIT 1;
SELECT MAX(shipping_limit_date), MIN(shipping_limit_date) FROM olist.order_items;
