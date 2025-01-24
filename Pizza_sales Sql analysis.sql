-- 1)Retrieve the total number of orders placed.
select count(order_id) as total_orders from orders;

-- 2)Calculate the total revenue generated from pizza sales.
select
sum(order_details.quantity * pizzas.price) as total_revenue
from order_details join pizzas
on pizzas.pizza_id = order_details.pizza_id;

select
round(sum(order_details.quantity * pizzas.price),2) as total_revenue
from order_details join pizzas
on pizzas.pizza_id = order_details.pizza_id;

-- 3)Identify the highest-priced pizza.
SELECT * FROM pizzahut.pizzas;
select pizza_type_id, price from pizzas
where price = (select max(price) from pizzas) ;

-- 4) Identify the most common pizza size ordered.
select pizzas.size, count(order_details.order_details_id)
from pizzas join order_details
on pizzas.pizza_id=order_details.pizza_id
group by pizzas.size
order by  count(order_details.order_details_id) desc limit 1;


-- 5)List the top 5 most ordered pizza types along with their quantities.
select pizza_types.name, sum(order_details.quantity) as quantity from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name
order by quantity desc limit 5;

-- 6) Join the necessary tables 
-- to find the total quantity of each pizza category ordered.
SELECT pizza_types.category,
sum(order_details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id= pizzas.pizza_id
group by pizza_types.category order by quantity desc limit 5;


-- 7)Determine the distribution of orders by hour of the day.
select hour(order_time) as hour, count(order_id) from orders
group by hour(order_time);


-- 8)Join relevant tables to find the category-wise distribution of pizzas.
select category, count(name) from pizza_types
group by category;


-- 9)Group the orders by date and calculate the average number of pizzas ordered per day.
select orders.order_date, sum(order_details.quantity) as quantity
from orders join order_details
on orders.order_id = order_details.order_id
group by orders.order_date;

select avg(quantity) from (select orders.order_date, sum(order_details.quantity) as quantity
from orders join order_details
on orders.order_id = order_details.order_id
group by orders.order_date) as order_quantity;

-- 10)Determine the top 3 most ordered pizza types based on revenue.
select pizza_types.name,
sum(order_details.quantity * pizzas.price) as revenue
from pizza_types join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by revenue desc limit 3;


-- 11) Calculate the percentage contribution of each pizza type to total revenue.
select pizza_types.category,
sum(order_details.quantity*pizzas.price)/ (select sum(order_details.quantity*pizzas.price) as total_sales
from
order_details
join pizzas on pizzas.pizza_id = order_details.pizza_id)*100 as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id= pizzas.pizza_type_id
join order_details
on order_details.pizza_id= pizzas.pizza_id
group by pizza_types.category order by revenue desc;


-- 12) Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select pizza_types.category, sum(order_details.quantity*pizzas.price)/ (select sum(order_details.quantity * pizzas.price) as total_sales
from 
order_details
join
pizzas on pizzas.pizza_id = order_details.pizza_id)*100 as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category order by revenue desc;



