create database pizzahut;
use pizzahut;
select * from pizzahut.pizzas;
select * from pizzahut.pizza_types;
create table orders(order_id int not null, 
order_date date not null, order_time time not null,
primary key (order_id));

SELECT * FROM pizzahut.orders;

create table order_details(
order_details_id int not null,
order_id int not null,
pizza_id text not null,
quantity int not null,
primary key (order_details_id));


SELECT * FROM pizzahut.order_details;



-- retrive the total number of orders place
select * from orders;
select count(order_id) as total_orders from orders;

-- calculate the total revenue generated from pizza sales.
select * from order_details;
select round(sum(order_details.quantity*pizzas.price),2) as total_sales
from order_details join pizzas
on pizzas.pizza_id = order_details.pizza_id;

-- identfiy the heighest priced pizza
select pizza_types.name,pizzas.price
from pizza_types 
join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
order by pizzas.price desc limit 1;

-- identify the most common pizza size order
select * from pizzas;
select pizzas.size,count(order_details.order_details_id) as order_count
from pizzas join order_details
on pizzas.pizza_id = order_details.pizza_id
group by pizzas.size order by order_count desc;

-- list the top 5 most orderd pizza typr along with their quantityes
select * from order_details;
select pizza_types.name, sum(order_details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by quantity desc limit 5;

-- join the necessary tables to find the total quantity of each pizza category orderd
select pizza_types.category,
sum(order_details.quantity) as quantity 
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category order by quantity desc;


-- determine the distribution of orders by hour of the day 
select * from pizzahut.orders;
select hour(order_time) as hour,count(order_id) as order_count from orders
group by hour (order_time);

-- join relevent table to find the category _ wise distribution of pizzas
select * from pizza_types;
select category,count(name) from pizza_types
group by category;


-- group the orders by date and calculate the average number of pizzas orderd per day
select avg(quantity) from
(select orders.order_date,sum(order_details.quantity) as quantity
from orders join order_details
on orders.order_id = order_details.order_id
group by orders.order_date) as order_quantity;

-- determine the top 3 most orderd pizza types based on revenue
select pizza_types.name,
sum(order_details.quantity * pizzas.price)as revenue
from pizza_types join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by revenue desc limit 3;


