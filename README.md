# Restaurant Order Analysis

![Screenshot 2024-03-18 at 11-28-53 You earned a badge from Maven Analytics! - harshitgahlaut29@gmail com - Gmail](https://github.com/harshitgahlaut/Restaurant_Order_Analysis_SQL/assets/142779836/ed70d951-80ed-4612-b18b-4834aa66c22e)


This is a guided project by [Maven Analytics](https://www.mavenanalytics.io/guided-projects#projects-list) whose primary objective is to conduct a basic level analysis of restaurant data using SQL.

## Tech Stack Used

![J5Yt92WW_400x400](https://github.com/harshitgahlaut/Restaurant_Order_Analysis_SQL/assets/142779836/6086e1fe-3899-4f8b-a2de-645f90e57d55)

## Situation

You have been hired as a Data Analyst for the "Taste of World Cafe". The restaurant has debuted a new menu and you have been asked to analyse the data and get some informtion

## Data Set

Dataset can be found at [Maven Analytics](https://www.mavenanalytics.io/guided-projects#projects-list) . A profound gratitude is extended to Maven Analytis for offering this exceptional opportunity for practice through this project. 

## Skills showcased in this Project

- Use of SELECT and WHERE statements along with LIMIT and ORDER BY 
- Use of Aggreagte Functions such as SUM, MAX, MIN, COUNT
- Use of GROUP BY and JOINS
- Use of Subquery

## Queries

### Objective 1 : Explore the items table

- View the menu_items table and write a query to find the number of items on the menu
```sql
SELECT * FROM menu_items
LIMIT 5;
```

``` sql
SELECT COUNT(*) AS 'Number of Items'
FROM menu_items;
```
- What are the least and most expensive items on the menu?
```sql
SELECT * 
FROM menu_items
ORDER BY price
LIMIT 1;

-- OR
SELECT * 
FROM menu_items
WHERE price = (SELECT MIN(price) FROM menu_items);
```

```sql
SELECT * 
FROM menu_items
ORDER BY price DESC
LIMIT 1;
-- OR
SELECT * 
FROM menu_items
WHERE price = (SELECT MIN(price) FROM menu_items);
```

- How many Italian dishes are on the menu? What are the least and most expensive Italian dishes on the menu?
```sql
SELECT COUNT(*) AS 'Number of Italian Dishes'
FROM menu_items
WHERE category = 'Italian';
```

``` sql
SELECT *
FROM menu_items
WHERE category = 'Italian'
ORDER BY price
LIMIT 1;
```

```sql
SELECT *
FROM menu_items
WHERE category = 'Italian'
ORDER BY price DESC
LIMIT 1;
```

- How many dishes are in each category? What is the average dish price within each category?
```sql
SELECT category,COUNT(menu_item_id) AS 'Number of dishes'
FROM menu_items
GROUP BY category;
```

```sql
SELECT category, AVG(price) AS 'Average price'
FROM menu_items
GROUP BY category;
```

### Objective 2 : Explore the orders table

- View the order_details table. What is the date range of the table?
```sql
SELECT * FROM order_details
LIMIT 5;
```

```sql
SELECT MIN(order_date), MAX(order_date) 
FROM order_details;
```
	
- How many orders were made within this date range? How many items were ordered within this date range?	
```sql
SELECT COUNT(DISTINCT order_id) AS 'Number of orders'
FROM order_details;
```

```sql
SELECT COUNT(order_details_id) AS 'Number of items ordered'
FROM order_details;
```

- Which orders had the most number of items?	
```sql
SELECT order_id, COUNT(item_id) AS 'Number of items'
FROM order_details
GROUP BY order_id
ORDER BY 2 DESC;
```

- How many orders had more than 12 items?
```sql
SELECT COUNT(*)
FROM (
		SELECT order_id,COUNT(item_id) AS num_items
		FROM order_details
		GROUP BY order_id
		HAVING num_items > 12
) AS num_orders;
```

### Objective 3 : Analyze customer behaviour

- Combine the menu_items and order_details tables into a single table	
```sql
SELECT *
FROM order_details od
INNER JOIN menu_items mi on od.item_id = mi.menu_item_id;
```

- What were the least and most ordered items? What categories were they in?
```sql
SELECT item_name, category, COUNT(item_name) AS 'Number of purchases'
FROM order_details od
INNER JOIN menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY item_name, category
ORDER BY 3
LIMIT 1;
```

```sql
SELECT item_name, category, COUNT(item_name) AS 'Number of purchases'
FROM order_details od
INNER JOIN menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY item_name, category
ORDER BY 3 DESC
LIMIT 1;
```
	
- What were the top 5 orders that spent the most money?	
```sql
SELECT order_id, SUM(price) AS 'Total amount'
FROM order_details od
INNER JOIN menu_items mi on od.item_id = mi.menu_item_id
GROUP BY order_id
ORDER BY 2 DESC
LIMIT 5;
```

- View the details of the highest spend order. Which specific items were purchased?	
```sql
SELECT *
FROM order_details od
INNER JOIN menu_items mi on od.item_id = mi.menu_item_id
WHERE order_id = 440;
```

```sql
SELECT category, COUNT(item_id) AS 'Number of items'
FROM order_details od
INNER JOIN menu_items mi on od.item_id = mi.menu_item_id
WHERE order_id = 440
GROUP BY category;
```

- BONUS: View the details of the top 5 highest spend orders
```sql
SELECT category, COUNT(item_id) AS 'Number of items'
FROM order_details od
INNER JOIN menu_items mi on od.item_id = mi.menu_item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY category;
```

```sql
SELECT order_id, category, COUNT(item_id) AS 'Number of items'
FROM order_details od
INNER JOIN menu_items mi on od.item_id = mi.menu_item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY order_id, category;
```

## End

Thank you for your interest and time. Feel free to give your valuable suggestions and connect with me on https://www.linkedin.com/in/harshitt-gahlaut/

