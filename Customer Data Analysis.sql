
use customers

-- data set
select * from Customers

-- total amount spend
select sum(cast(Amount as int)) as revenue from Customers

-- total amount spend by gender
select
Gender,
sum(cast(Amount as int)) as revenue
from
Customers
group by
Gender

-- total customers and revenue by category
select
Category,
count(Customer_ID) as total_customers,
sum(cast(Amount as int)) as revenue
from 
Customers
group by
Category
order by
revenue desc, 
total_customers desc

-- total customers and revenue by promo code used
select
Promo_Code_Used,
count(Customer_ID) as total_customers
from 
Customers
group by
Promo_Code_Used
order by
total_customers desc

-- total customers and revenue by discount applied
select
Discount_Applied,
count(Customer_ID) as total_customers
from 
Customers
group by
Discount_Applied
order by
total_customers desc

-- promo code and discount field is same

-- total customers and revenue by shipping method used
select
Shipping_Type,
count(Customer_ID) as total_customers,
sum(cast(Amount as int)) as revenue
from 
Customers
group by
Shipping_Type
order by
revenue desc, 
total_customers desc

-- total customers and revenue by payment method used
select
Payment_Method,
count(Customer_ID) as total_customers,
sum(cast(Amount as int)) as revenue
from 
Customers
group by
Payment_Method
order by
revenue desc, 
total_customers desc

-- discount is applied and spent is more than avg
select
Customer_ID,
cast(Amount as int) as revenue
From
Customers
where
Discount_Applied = 'Yes' and Amount >= (select AVG(cast(Amount as int)) from Customers)


-- top rated items
select Top 5
Item,
round(avg(cast(Review_Rating as float)),2) as average_review_rating
from 
Customers
group by
Item
order by
average_review_rating desc

-- total customers and avg revenue as per subsription status
select 
Subscription_Status,
count(Customer_ID) as total_customers,
sum(cast(Amount as int)) as avg_revenue
from 
Customers
group by
Subscription_Status

-- New, Recurring and loyal customers
with customer_type as (
select
Customer_ID,
Previous_Purchases,
case 
	when Previous_Purchases = 1 then 'New'
	when Previous_Purchases between 2 and 20 then 'recurring'
	else 'loyal'
	end as customer_category
from Customers)

select
customer_category,
count(*) as total_customers
from
customer_type
group by
customer_category

-- season wise revenue
select
Season,
sum(cast(Amount as int)) as revenue
from Customers
group by
Season
order by
revenue desc

-- top 1 category
select Top 1
Category,
sum(cast(Amount as int)) as revenue
from Customers
group by
Category
order by
revenue desc

-- Items in clothing (top category)
select
Item,
sum(cast(Amount as int)) as revenue
from 
Customers
where
Category = 'Clothing'
group by
Item
order by
revenue desc
 
-- Young, adult and senior customers analysis
with customer_group as (
select
Customer_ID,
Amount,
Age,
case
	when Age <= 20 then 'young'
	when Age between 21 and 50 then 'Adult'
	else 'senior'
	end as customer_age
from
Customers)

select 
customer_age,
count(Customer_ID) as total_customers,
sum(cast(Amount as int)) as revenue
from 
customer_group
group by
customer_age
order by
revenue desc


