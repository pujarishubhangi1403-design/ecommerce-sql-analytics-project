/*Find the total number of registered users*/

select count(distinct user_id) as total_user
from users


/*Find the Top 10 customers by total spending.*/

SELECT TOP 10
    u.user_id,
    u.name,  -- or u.name depending on your schema
    SUM(oi.item_total) AS total_spending
FROM users u
INNER JOIN orders o ON u.user_id = o.user_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
where o.order_status='completed'
GROUP BY 
    u.user_id, 
    u.name
ORDER BY total_spending DESC;

/*Monthly Revenue Trend*/
select FORMAT(cast(o1.order_date as date),'yyyy-MM') as month,
         sum( o.item_total) as revenue from order_items o
          inner join orders o1
          on o1.order_id=o.order_id
          group by FORMAT(cast(o1.order_date as date),'yyyy-MM')
          order by month desc

/*Which 10 customers generated the highest revenue for the business?*/
SELECT TOP 10
    u.user_id,
    u.name,
    SUM(oi.item_total) AS revenue
FROM users u
INNER JOIN orders o
    ON u.user_id = o.user_id
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY u.user_id, u.name
ORDER BY revenue DESC;

/*Which products generate the most revenue?*/
select top 10 p.product_name,
sum(o.item_total)as total_revenue from products p
inner join order_items o on p.product_id=o.product_id
group by p.product_name
order by total_revenue desc


/*Which products are popular but generate low revenue?*/
select p.product_name,
   count(p.product_id) as total_orders,
    sum(o.item_total) as total_revenue
    from products p
    inner join order_items o on p.product_id=o.product_id
    group by p.product_name,
          p.product_id
          order by total_orders desc

/*Who are our repeat customers?*/
          select u.user_id,
          count(o.order_id) as total_orders,
            u.name from users u
            inner join orders o
            on u.user_id=o.user_id
            where order_status='completed'
            group by u.user_id,
            u.name 
            having count(o.order_id)>1
          order by total_orders desc
/*What is the Average Order Value (AOV)?*/
	select 
	count(distinct o.order_id) as total_orders,
	sum(o1.item_total) as total_revenue,
	sum(o1.item_total)/count(distinct o.order_id) as average_value
	from orders o
	inner join order_items o1
	on o.order_id=o1.order_id
	where o.order_status='completed'

/*Find the Top 5 cities with the highest number of registered users.*/
SELECT TOP 5
    city,
    COUNT(user_id) AS total_user
FROM users
GROUP BY city
ORDER BY total_user DESC;

