
-- Set search path for easy use
set search_path to portfolio;


-- Change the [Invoice Date] column to a proper date data type using excel's date formula
alter table adidas_us_sales
alter column "Invoice Date" type date
using '1900-01-01'::date +  ("Invoice Date" - 2);


-- Regarding sales methods, what was our most profitable sales method?
select "Sales Method", sum("Operating Profit") as total_profit
from adidas_us_sales
group by "Sales Method";


-- There was a sudden drop in sales when the pandemic hit, when did they rise again and why?
-- Also provide information about our sales methods and how they were affected during the pandemic
-- and after it.
select date_trunc('month',"Invoice Date") as month,
       sum("Units Sold") as monthly_units_sold
from adidas_us_sales
group by date_trunc('month',"Invoice Date")
order by month;
-- +
select date_trunc('month',"Invoice Date") as month,
       "Sales Method",
       sum("Units Sold") as monthly_units_sold
from adidas_us_sales
group by date_trunc('month',"Invoice Date"), "Sales Method"
order by month, "Sales Method";


-- Regarding each sales method that we use, how do our retailers rank in terms of profitability?
with grouped_retailers as (select "Sales Method", "retailer", sum("Operating Profit") as "Total Profit"
                           from adidas_us_sales
                           group by "Sales Method", "retailer")
select *, rank() over(partition by "Sales Method" order by "Total Profit" desc) as retailer_rank
from grouped_retailers
order by "Sales Method", retailer_rank;


-- Between our retailers,taking into account their operation city, how do they rank in terms of their operation margin?
with grouped_retailers_city as (select "retailer",
                                       "city",
                                       round(avg("Operating Margin")::numeric, 3) as "operating_margin"
                                from adidas_us_sales
                                group by "retailer", "city"
                                order by "retailer" asc, "operating_margin" desc)
select *, rank() over(partition by "retailer" order by "operating_margin" desc) as city_rank
from grouped_retailers_city;


-- What is our most sold product?
select "product", sum("Units Sold")
from adidas_us_sales
group by "product";


-- What is our most profitable product?
select "product", sum("Operating Profit")
from adidas_us_sales
group by "product";