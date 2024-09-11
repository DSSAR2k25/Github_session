-- avg, count, min, max, sum

select * from payment;

select min(amount) as least_amount,
max(amount) as highest_amount,
avg(amount) as average_amount,
sum(amount) as total_amount,
count(Amount) as no_of_payments
from payment; -- for the entire amount column

-- customer wise total payment, min, max,avg and number of payments(include customer names)

select payment.customer_id, first_name,last_name, min(amount) as least_amount,
max(amount) as highest_amount,
avg(amount) as average_amount,
sum(amount) as total_amount,
count(Amount) as no_of_payments
from payment
inner join customer
on customer.customer_id = payment.customer_id
group by payment.customer_id;


-- customer wise total payment, min, max,avg and number of payments
-- include customer names and they should be indian customers only
-- for the customers who have paid more than 100 total amount 
select customer.customer_id, first_name,last_name, country,
min(amount) as least_amount,
max(amount) as highest_amount,
avg(amount) as average_amount,
sum(amount) as total_amount,
count(Amount) as no_of_payments
from payment
inner join customer
on customer.customer_id = payment.customer_id
inner join address
on customer.address_id = address.address_id
inner join city
on address.city_id = city.city_id
inner join country
on city.country_id = country.country_id
where country = 'India' 
group by customer.customer_id
having total_amount > 100;

-- how many customers does the mavenmovies business have in each city
select country,city,count(customer_id) from 
customer 
inner join address
on customer.address_id = address.address_id
inner join city
on address.city_id = city.city_id
inner join country
on city.country_id = country.country_id
group by country,city;

-- how many payments did each customer pay to each staff member
select customer_id, staff_id, count(amount)
from payment
group by customer_id,staff_id;

-- regular expressions
select * from address;

select customer_id, first_name, last_name, phone from address
inner join customer 
on customer.address_id = address.address_id
where phone regexp '^91[0-9]{10}';


/*
-- {} -- no of character or number of digits
-- [] -- including similar to membership operator
*/


-- email validation -- success@odinschool.com
select * from customer
where email regexp'[a-z A-Z 0-9 ._%+-]+@[a-z A-Z 0-9]+\\.[a-z A-Z]{3}'
or email regexp'[a-z A-Z 0-9 ._%+-]+@[a-z A-Z 0-9]+\\.[a-z A-Z]{2}+\\.[a-z A-Z]{2}';

create database practice1;
use practice1;

create table email_validate(
ID int,
URL varchar(255)
);

insert into email_validate(ID,URL)
values(1,'https://go.odinschool.com/');

select * from email_validate
where URL regexp
'https?://(?:www\\.)?[a-zA-Z0-9]+\\.[a-zA-Z]{2,}(?:/[a-zA-Z0-9-.#?%=&]+)*';



-- end with a dollar $
select character_1 from regex
where character_1 regexp '\\$$';

select * from regex
where character_1 regexp 's$';

-- starting with a caret
select character_1 from regex
where character_1 regexp '^\\^';


select * from regex;

-- \\ escape character 
-- $ is a metacharacter(if i want to use it as a normal character then \\$)
select character_1 from regex
where character_1 regexp '\\$$';


/* mavenmovies is running a promotional campaign
and wanted to reward the customers who have rented the most, for that
they want to categorise the customers into multiple groups
any customer who has rented more than 30 times are considered as platinum,
between 20 & 30 should be gold and between 10 and 20 are silver
rest as bronze

customername, numberoffilmsrented, customercategory
*/

select customer.customer_id, 
concat(first_name,space(1),last_name) as customername,
count(customer.customer_id) as rental_count,
case
when count(customer.customer_id) > 30 then 'Platinum Customers'
when count(customer.customer_id) between 21 and 30 then 'Gold Customers'
when count(customer.customer_id) between 11 and 20 then 'Silver Customers'
else 'Bronze Customers'
end as Customer_Category
from customer
inner join rental
on customer.customer_id = rental.customer_id
group by customer.customer_id
order by rental_count desc;


SELECT
  film.film_id,
  title,
  sum(case when month(rental_date) = 5 then 1 else 0 end) As May,
  sum(case when month(rental_date) = 6 then 1 else 0 end) As June
  FROM
  rental
  JOIN inventory ON rental.inventory_id = inventory.inventory_id
  JOIN film ON inventory.film_id = film.film_id
GROUP BY
  film_id, title
ORDER BY
  film_id;


select 
sum(case when month(rental_date) = 5 then 1 else 0 end) as may
from rental; 


select count(*) from rental
where month(Rental_date) = 5;

