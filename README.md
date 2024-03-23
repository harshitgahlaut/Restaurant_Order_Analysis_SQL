# Restaurant Order Analysis

![proj](https://github.com/harshitgahlaut/Restaurant_Order_Analysis_SQL/assets/142779836/190aca75-921a-4234-8f64-00d16e584a09)


This is a guided project by [Maven Analytics](https://www.mavenanalytics.io/guided-projects#projects-list) whose primary objective is to conduct a basic level analysis of restaurant data using SQL.

## Tech Stack Used

![J5Yt92WW_400x400](https://github.com/harshitgahlaut/Restaurant_Order_Analysis_SQL/assets/142779836/6086e1fe-3899-4f8b-a2de-645f90e57d55)

## Situation

You have been hired as a Data Analyst for the "Taste of World Cafe". The restaurant has debuted a new menu and you have been asked to analyse the data and get some informtion

## Data Set

Dataset can be found at [Maven Analytics](https://www.mavenanalytics.io/guided-projects#projects-list) . A profound gratitude is extended to Maven Analytics for offering this exceptional opportunity for practice through this project. 

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
![1](https://github.com/harshitgahlaut/Restaurant_Order_Analysis_SQL/assets/142779836/b77055cf-7608-449a-836d-71f1181711e8)

``` sql
SELECT COUNT(*) AS 'Number of Items'
FROM menu_items;
```
![2](https://github.com/harshitgahlaut/Restaurant_Order_Analysis_SQL/assets/142779836/97f8ff46-b9ae-4266-8695-6b7cbf7a3254)

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
![3](https://github.com/harshitgahlaut/Restaurant_Order_Analysis_SQL/assets/142779836/c206d635-113e-4771-813a-319e8266bf86)

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
![4](https://github.com/harshitgahlaut/Restaurant_Order_Analysis_SQL/assets/142779836/5cb09aaf-733b-44c6-b009-f33f94f9ed12)


- How many Italian dishes are on the menu? What are the least and most expensive Italian dishes on the menu?
```sql
SELECT COUNT(*) AS 'Number of Italian Dishes'
FROM menu_items
WHERE category = 'Italian';
```
![5](https://github.com/harshitgahlaut/Restaurant_Order_Analysis_SQL/assets/142779836/1f07c847-6862-4d80-b0b8-483dac1f86b7)


``` sql
SELECT *
FROM menu_items
WHERE category = 'Italian'
ORDER BY price
LIMIT 1;
```
![6](https://github.com/harshitgahlaut/Restaurant_Order_Analysis_SQL/assets/142779836/045cbf2c-5d35-4057-936d-7eed7f5461d4)

```sql
SELECT *
FROM menu_items
WHERE category = 'Italian'
ORDER BY price DESC
LIMIT 1;
```
![7](https://github.com/harshitgahlaut/Restaurant_Order_Analysis_SQL/assets/142779836/859f680b-ba5e-4e2f-bc67-13fd34b4e27c)


- How many dishes are in each category? What is the average dish price within each category?
```sql
SELECT category,COUNT(menu_item_id) AS 'Number of dishes'
FROM menu_items
GROUP BY category;
```
![8](https://github.com/harshitgahlaut/Restaurant_Order_Analysis_SQL/assets/142779836/25fe4dff-4421-424b-a060-3b79c1174233)

```sql
SELECT category, AVG(price) AS 'Average price'
FROM menu_items
GROUP BY category;
```
![9](https://github.com/harshitgahlaut/Restaurant_Order_Analysis_SQL/assets/142779836/900d5085-20ce-467c-842f-7400d87dc21b)


### Objective 2 : Explore the orders table

- View the order_details table. What is the date range of the table?
```sql
SELECT * FROM order_details
LIMIT 5;
```
![10](https://github.com/harshitgahlaut/Restaurant_Order_Analysis_SQL/assets/142779836/0b6b8aad-4567-4535-9a13-727bb133e468)

```sql
SELECT MIN(order_date), MAX(order_date) 
FROM order_details;
```
![11](https://github.com/harshitgahlaut/Restaurant_Order_Analysis_SQL/assets/142779836/42426440-1515-41cd-9a36-c7ca9f380c07)

	
- How many orders were made within this date range? How many items were ordered within this date range?	
```sql
SELECT COUNT(DISTINCT order_id) AS 'Number of orders'
FROM order_details;
```
![12](https://github.com/harshitgahlaut/Restaurant_Order_Analysis_SQL/assets/142779836/20787beb-1365-45f3-b9e3-22d3f17e4932)


```sql
SELECT COUNT(order_details_id) AS 'Number of items ordered'
FROM order_details;
```
![13](https://github.com/harshitgahlaut/Restaurant_Order_Analysis_SQL/assets/142779836/52f35c7d-9315-4466-b5cf-5b55a5949eb4)

- Which orders had the most number of items?	
```sql
SELECT order_id, COUNT(item_id) AS 'Number of items'
FROM order_details
GROUP BY order_id
ORDER BY 2 DESC;
```
![14](https://github.com/harshitgahlaut/Restaurant_Order_Analysis_SQL/assets/142779836/be778408-d89a-4cf3-88f7-1b38fb4fa21b)

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
![15](https://github.com/harshitgahlaut/Restaurant_Order_Analysis_SQL/assets/142779836/de49b301-9f61-41e5-86ea-51c393db2c8e)


### Objective 3 : Analyze customer behaviour

- Combine the menu_items and order_details tables into a single table	
```sql
SELECT *
FROM order_details od
INNER JOIN menu_items mi on od.item_id = mi.menu_item_id;
```
![16](https://github.com/harshitgahlaut/Restaurant_Order_Analysis_SQL/assets/142779836/b9e456fb-9ab0-405e-8f0a-5dbe62dbf795)


- What were the least and most ordered items? What categories were they in?
```sql
SELECT item_name, category, COUNT(item_name) AS 'Number of purchases'
FROM order_details od
INNER JOIN menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY item_name, category
ORDER BY 3
LIMIT 1;
```
![17](https://github.com/harshitgahlaut/Restaurant_Order_Analysis_SQL/assets/142779836/254f2b97-e745-4929-971b-6cdebcf541c2)

```sql
SELECT item_name, category, COUNT(item_name) AS 'Number of purchases'
FROM order_details od
INNER JOIN menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY item_name, category
ORDER BY 3 DESC
LIMIT 1;
```
![18](https://github.com/harshitgahlaut/Restaurant_Order_Analysis_SQL/assets/142779836/f83cf997-1ad1-4493-89db-43bfa2b75e32)

	
- What were the top 5 orders that spent the most money?	
```sql
SELECT order_id, SUM(price) AS 'Total amount'
FROM order_details od
INNER JOIN menu_items mi on od.item_id = mi.menu_item_id
GROUP BY order_id
ORDER BY 2 DESC
LIMIT 5;
```
![19](https://github.com/harshitgahlaut/Restaurant_Order_Analysis_SQL/assets/142779836/d85cbea3-c259-432c-8a57-9436de02aefc)

- View the details of the highest spend order. Which specific items were purchased?	
```sql
SELECT *
FROM order_details od
INNER JOIN menu_items mi on od.item_id = mi.menu_item_id
WHERE order_id = 440;
```
![20](https://github.com/harshitgahlaut/Restaurant_Order_Analysis_SQL/assets/142779836/f0eb796a-2e8d-4d41-875b-3ce3ede16ee9)

```sql
SELECT category, COUNT(item_id) AS 'Number of items'
FROM order_details od
INNER JOIN menu_items mi on od.item_id = mi.menu_item_id
WHERE order_id = 440
GROUP BY category;
```
![21](https://github.com/harshitgahlaut/Restaurant_Order_Analysis_SQL/assets/142779836/b8ac682c-b994-4710-a753-e8c82277aa7b)

- BONUS: View the details of the top 5 highest spend orders
```sql
SELECT category, COUNT(item_id) AS 'Number of items'
FROM order_details od
INNER JOIN menu_items mi on od.item_id = mi.menu_item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY category;
```
![22](https://github.com/harshitgahlaut/Restaurant_Order_Analysis_SQL/assets/142779836/7d9517e7-3ed1-41bf-8f57-8f3788afac6c)

```sql
SELECT order_id, category, COUNT(item_id) AS 'Number of items'
FROM order_details od
INNER JOIN menu_items mi on od.item_id = mi.menu_item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY order_id, category;
```
![23](https://github.com/harshitgahlaut/Restaurant_Order_Analysis_SQL/assets/142779836/3df50185-2973-44b4-98be-2a935f758bc9)

## End

Thank you for your interest and time. Feel free to give your valuable suggestions and connect with me on https://www.linkedin.com/in/harshitt-gahlaut/

