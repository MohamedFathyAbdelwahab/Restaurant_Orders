--Analyzing restaurant_orders data which is composed of two tables.
--Seeing which items are doing well and which is not 
--What are the most ordered dishes and its category.
--Returning the most and least revenue by order.


----- View the menu table.
SELECT * 
FROM restaurant_db..menu_items


---Returning number of items.

SELECT COUNT(*) as number_of_items
FROM restaurant_db..menu_items

-- Maximum item price.

SELECT *
FROM restaurant_db..menu_items
ORDER BY price DESC
 
 
-- Minimum item price.

 SELECT *
 FROM restaurant_db..menu_items
 ORDER BY price 

 ----- OR------

SELECT category,MAX(price) as max_price,MIN(price) AS min_price
FROM restaurant_db..menu_items
GROUP BY category 
ORDER BY max_price DESC

SELECT item_name, MAX(price) as max_price
FROM restaurant_db..menu_items
WHERE category = 'italian'
GROUP BY item_name 
ORDER BY max_price DESC




SELECT item_name,MIN(price) as min_price 
FROM restaurant_db..menu_items
WHERE category = 'asian'
GROUP BY item_name
ORDER BY min_price ASC
-----------------------
-- Number of italian dishes in the menu.

SELECT COUNT(menu_item_id) 
FROM restaurant_db..menu_items
WHERE category = 'italian'

-- Least italian dish price.

SELECT *
FROM restaurant_db..menu_items
WHERE category = 'italian'
ORDER BY price ASC

--Most italian dish price.

SELECT *
FROM restaurant_db..menu_items
WHERE category = 'italian'
ORDER BY price DESC
---------Or---------

SELECT item_name, MAX(price) as max_price, MIN(price) as min_price 
FROM restaurant_db..menu_items
WHERE category = 'italian'
GROUP BY item_name
ORDER BY max_price DESC
-----------------------------------

-- Dishes number by category.

SELECT category, COUNT(*) as num_dishes
FROM restaurant_db..menu_items
GROUP BY category

--Average price of each category.

SELECT category,ROUND(AVG(price),2) as avg_price
FROM restaurant_db..menu_items
GROUP BY category

------------------------------------------------------------------------------------------------------------------------
-- View the order_details table.

SELECT *
FROM restaurant_db..order_details

-- Returning the date range.

SELECT MAX(order_date) as most_recent_date, MIN(order_date) as least_date
FROM restaurant_db..order_details

--Number of orders and items.

SELECT COUNT(DISTINCT order_id) as num_orders , COUNT(item_id) as num_items
FROM restaurant_db..order_details

--Maximum number of items by order

SELECT order_id, COUNT(item_id) as num_items
FROM restaurant_db..order_details
GROUP BY order_id
ORDER BY num_items DESC

-- Returning orders with more than 12 items.

SELECT COUNT(*) as num_orders 
FROM ( SELECT order_id , COUNT(item_id) as num_items 

    FROM restaurant_db..order_details 
	GROUP BY order_id
	HAVING  COUNT(item_id) > 12
	)
	as orders


 ------------------------------------------------------------------------------------------------------------------------
 -- Combining tables 

 SELECT *
 FROM restaurant_db..menu_items M
 FULL OUTER JOIN restaurant_db..order_details O
 ON m.menu_item_id = o.item_id


 -- Returning the least ordered item.

 SELECT menu_item_id ,item_name,m.category, COUNT(item_id) num_ordered_items
 FROM restaurant_db..order_details O 
 LEFT JOIN restaurant_db..menu_items M
 ON o.item_id = m.menu_item_id 
 GROUP BY menu_item_id,item_name,category
 ORDER BY num_ordered_items

 --Returning the most ordered item.

  SELECT menu_item_id ,item_name,m.category, COUNT(item_id) num_ordered_items
 FROM restaurant_db.. menu_items M
 LEFT JOIN restaurant_db.. order_details O
 ON m.menu_item_id  = o.item_id  
 GROUP BY menu_item_id,item_name,category
 ORDER BY num_ordered_items DESC

 --Finding top five orders spent the most money.

 SELECT TOP 5 order_id, SUM(price) as Pr
 FROM restaurant_db..order_details O
 LEFT JOIN restaurant_db.. menu_items M
 ON m.menu_item_id = o.item_id
 GROUP BY order_id
 ORDER BY Pr DESC
 

 -- Details of highest spend order 
  SELECT order_id,category, COUNT(item_id) num_items
 FROM restaurant_db..order_details O
 LEFT JOIN restaurant_db.. menu_items M
 ON   o.item_id = m.menu_item_id
 WHERE order_id IN (440 , 2075 , 1957, 330, 2675)
 GROUP BY order_id,category
 


