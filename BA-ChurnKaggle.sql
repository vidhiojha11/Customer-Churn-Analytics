create database BA_Churn;
use BA_Churn;
drop table customers;
create table customers( customer_id varchar(50), customer_unique_id varchar(50), customer_zip_code_prefix varchar(10), customer_city varchar(50), customer_state varchar(15));
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_customers_dataset.csv'
into table customers fields terminated by ',' enclosed by '"' lines terminated by '\n' ignore 1 rows;
show variables like 'secure_file_priv';
select * from customers limit 10;
create table orders (order_id varchar(50), customer_id varchar(50),	order_status varchar(20), order_purchase_timestamp datetime null, 
order_approved_at datetime null, order_delivered_carrier_date datetime null, 
order_delivered_customer_date datetime null, order_estimated_delivery_date datetime null);

drop table orders;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_orders_dataset.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    order_id,
    customer_id,
    order_status,
    @order_purchase_timestamp,
    @order_approved_at,
    @order_delivered_carrier_date,
    @order_delivered_customer_date,
    @order_estimated_delivery_date
)
SET
order_purchase_timestamp =
STR_TO_DATE(NULLIF(@order_purchase_timestamp,''), '%Y-%m-%d %H:%i:%s'),

order_approved_at =
STR_TO_DATE(NULLIF(@order_approved_at,''), '%Y-%m-%d %H:%i:%s'),

order_delivered_carrier_date =
STR_TO_DATE(NULLIF(@order_delivered_carrier_date,''), '%Y-%m-%d %H:%i:%s'),

order_delivered_customer_date =
STR_TO_DATE(NULLIF(@order_delivered_customer_date,''), '%Y-%m-%d %H:%i:%s'),

order_estimated_delivery_date =
STR_TO_DATE(NULLIF(@order_estimated_delivery_date,''), '%Y-%m-%d %H:%i:%s');
SELECT * FROM orders LIMIT 10;
create table order_items (order_id varchar(50), order_item_id varchar(50),product_id varchar(50),
 seller_id	varchar(50),shipping_limit_date datetime, price float, freight_value float);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_items_dataset.csv'
INTO TABLE order_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
create table payments (order_id	varchar(50),payment_sequential int, payment_type varchar(20), payment_installments varchar(5), payment_value float);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_payments_dataset.csv'
INTO TABLE payments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
create table reviews (review_id	varchar(50), order_id varchar(50), review_score int);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_reviews_dataset.csv'
INTO TABLE reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Table Inspection
SELECT * FROM orders LIMIT 10;
SELECT count(*) FROM orders;
SELECT count(*) FROM order_items;
SELECT count(*) FROM payments;

-- Check Null Values
Select 
sum(case when order_id is null then 1 else 0 end) as null_order_id,
sum(case when customer_id is null then 1 else 0 end) as null_customer_id,
sum(case when order_purchase_timestamp is null then 1 else 0 end) as null_order_purchase_timestamp,
sum(case when order_approved_at is null then 1 else 0 end) as null_order_approved_at,
sum(case when order_delivered_carrier_date is null then 1 else 0 end) as null_delivered_carrier_date,
sum(case when order_delivered_customer_date is null then 1 else 0 end) as null_order_delivered_customer_date,
sum(case when order_estimated_delivery_date is null then 1 else 0 end) as null_order_estimated_delivery_date
From orders;


-- Check for duplicates
Select order_id, count(*) from orders group by order_id having count(*)> 1;

-- Only keeping deliverd status orders (excluding - cancelled, shipped and other orders)
Select * From orders Where order_status = 'delivered' and order_delivered_customer_date is not null;

-- Creating a master view
Create view master_order as
select o.order_id, o.customer_id, date(o.order_purchase_timestamp) as order_date,
i.price + i.freight_value as order_value,
p.payment_value, c.customer_city, c.customer_state, r.review_score
From orders o 
Left join order_items i On o.order_id = i.order_id
Left join payments p On o.order_id = p.order_id
Left join customers c On o.customer_id = c.customer_id
Left join reviews r On o.order_id = r.order_id
Where o.order_status = 'delivered'
And o.order_delivered_customer_date is not null;

Select * from master_order ;


