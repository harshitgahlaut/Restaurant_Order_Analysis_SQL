use restaurant_db;

/* Objective 1 : Explore the items table */

-- View the menu_items table and write a query to find the number of items on the menu
SELECT * FROM menu_items
LIMIT 5;

SELECT COUNT(*) AS 'Number of Items'
FROM menu_items;

-- What are the least and most expensive items on the menu?
SELECT * 
FROM menu_items
ORDER BY price
LIMIT 1;
-- OR
SELECT * 
FROM menu_items
WHERE price = (SELECT MIN(price) FROM menu_items);


SELECT * 
FROM menu_items
ORDER BY price DESC
LIMIT 1;
-- OR
SELECT * 
FROM menu_items
WHERE price = (SELECT MIN(price) FROM menu_items);

-- How many Italian dishes are on the menu? What are the least and most expensive Italian dishes on the menu?
SELECT COUNT(*) AS 'Number of Italian Dishes'
FROM menu_items
WHERE category = 'Italian';

SELECT *
FROM menu_items
WHERE category = 'Italian'
ORDER BY price
LIMIT 1;

SELECT *
FROM menu_items
WHERE category = 'Italian'
ORDER BY price DESC
LIMIT 1;

-- How many dishes are in each category? What is the average dish price within each category?
SELECT category,COUNT(menu_item_id) AS 'Number of dishes'
FROM menu_items
GROUP BY category;

SELECT category, AVG(price) AS 'Average price'
FROM menu_items
GROUP BY category;

/* Objective 2 : Explore the orders table */

-- View the order_details table. What is the date range of the table?
SELECT * FROM order_details
LIMIT 5;

SELECT MIN(order_date), MAX(order_date) 
FROM order_details;
	
-- How many orders were made within this date range? How many items were ordered within this date range?	
SELECT COUNT(DISTINCT order_id) AS 'Number of orders'
FROM order_details;

SELECT COUNT(order_details_id) AS 'Number of items ordered'
FROM order_details;

-- Which orders had the most number of items?	
SELECT order_id, COUNT(item_id) AS 'Number of items'
FROM order_details
GROUP BY order_id
ORDER BY 2 DESC;

-- How many orders had more than 12 items?
SELECT COUNT(*)
FROM (
		SELECT order_id,COUNT(item_id) AS num_items
		FROM order_details
		GROUP BY order_id
		HAVING num_items > 12
) AS num_orders;

/* Objective 3 : Analyze customer behaviour */

-- Combine the menu_items and order_details tables into a single table	
SELECT *
FROM order_details od
INNER JOIN menu_items mi on od.item_id = mi.menu_item_id;

-- What were the least and most ordered items? What categories were they in?
SELECT item_name, category, COUNT(item_name) AS 'Number of purchases'
FROM order_details od
INNER JOIN menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY item_name, category
ORDER BY 3
LIMIT 1;

SELECT item_name, category, COUNT(item_name) AS 'Number of purchases'
FROM order_details od
INNER JOIN menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY item_name, category
ORDER BY 3 DESC
LIMIT 1;
	
-- What were the top 5 orders that spent the most money?	
SELECT order_id, SUM(price) AS 'Total amount'
FROM order_details od
INNER JOIN menu_items mi on od.item_id = mi.menu_item_id
GROUP BY order_id
ORDER BY 2 DESC
LIMIT 5;

-- View the details of the highest spend order. Which specific items were purchased?	
SELECT *
FROM order_details od
INNER JOIN menu_items mi on od.item_id = mi.menu_item_id
WHERE order_id = 440;

SELECT category, COUNT(item_id) AS 'Number of items'
FROM order_details od
INNER JOIN menu_items mi on od.item_id = mi.menu_item_id
WHERE order_id = 440
GROUP BY category;

-- BONUS: View the details of the top 5 highest spend orders
SELECT category, COUNT(item_id) AS 'Number of items'
FROM order_details od
INNER JOIN menu_items mi on od.item_id = mi.menu_item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY category;

SELECT order_id, category, COUNT(item_id) AS 'Number of items'
FROM order_details od
INNER JOIN menu_items mi on od.item_id = mi.menu_item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY order_id, category;
