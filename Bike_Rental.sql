SELECT * FROM order_items;
--what the most popular model, brand and category of bike was 
--from 2016-2018 as well as
--determining what product is the highest grossing for the company.

with highest_gross as (
select products.product_name, products.product_id, products.model_year, 
  brands.brand_name,categories.category_name from products inner JOIN
brands on products.brand_id = brands.brand_id inner join categories ON
products.category_id = categories.category_id )

select order_items.quantity, order_items.list_price,
order_items.discount,highest_gross.product_name,
highest_gross.brand_name, highest_gross.model_year,
highest_gross.category_name
from order_items inner join highest_gross on 
order_items.product_id = highest_gross.product_id
where model_year between 2016 and 2018 ;

--Discover each category of bicycle
select distinct category_name from categories
order by category_name;

--Determine the top 10 most sold product by model

select product_name,sum(quantity) as highest
from products inner join order_items on 
products.product_id = order_items.product_id
group by product_name
order by highest desc;

--Determine the top 10 highest grossing products by model

select round(sum(order_items.list_price * (1-discount)),2) as total_price, 
product_name,category_name from products
inner join categories on products.category_id = categories.category_id 
inner join order_items on order_items.product_id = products.product_id 
group by product_name
order by total_price desc;

--#Determine the most sold and highest grossing product by brand

select sum(quantity), round(sum(order_items.list_price * (1-discount)),2) as grossing,
brand_name from products inner join brands ON
products.brand_id = brands.brand_id inner join order_items 
on products.product_id = order_items.product_id 
group by brand_name
order by grossing desc;

--Determine the most sold and highest grossing product by category

select sum(quantity),category_name,
round(sum(order_items.list_price * (1-discount)),2) as total_price
from products inner join categories ON
products.category_id = categories.category_id inner JOIN
order_items on products.product_id = order_items.product_id
group by category_name
order by total_price desc;



