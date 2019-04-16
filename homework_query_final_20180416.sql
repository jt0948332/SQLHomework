Use sakila;
-- 1a
select first_name, last_name from actor;
-- 1b
SELECT upper(CONCAT(first_name, ' ', last_name)) AS 'ACTOR NAME' FROM actor;
-- 2a
select actor_id, first_name, last_name from actor
where UPPER(first_name)  LIKE '%JOE%';
-- 2B
select actor_id, first_name, last_name from actor
where UPPER(LAST_NAME)  LIKE '%GEN%';
-- 2C
select actor_id, first_name, last_name from actor
where UPPER(LAST_NAME)  LIKE '%li%'
ORDER BY LAST_NAME, FIRST_NAME;
-- 2D
select country_id, country from country 
where country in('Afghanistan', 'Bangladesh','China');

-- 3a
ALTER TABLE actor
ADD COLUMN description BLOB AFTER last_update;

-- 3b
ALTER TABLE actor
DROP description;
-- 4a;
select last_name, count(last_name) as lcount from actor
group by last_name;

-- 4b
select last_name, count(last_name) as lcount from actor
group by last_name
HAVING count(last_name) >1;

-- 4c
select * from actor;
UPDATE actor 
SET 
    first_name = REPLACE(first_name,
        'GROUCHO',
        'HARPO');
-- 4d
UPDATE actor 
SET 
    first_name = REPLACE(first_name,
        'HARPO',
        'GROUCHO');

-- 5a
Create View Address_Schema as
select actor_id, first_name, last_name, last_update
from actor;

-- 6 a
select s.first_name, s.last_name, a.address, a.address2,a.district,a.postal_code from staff as s, address as a
where a.address_id = s.address_id;
-- 6b;
select b.first_name as "First", b.last_name as "Last", sum(a.amount),DATE_FORMAT(a.payment_date, '%m/%Y')
from payment as a
left join staff as b on a.staff_id = b.staff_id
where DATE_FORMAT(a.payment_date, '%m/%Y') = '08/2005'
group by a.staff_id;

 SELECT DATE_FORMAT(payment_date, '%m/%Y') FROM payment;

-- 6C
select a.title, count(b.actor_id) from film as a
inner join film_actor as b on a.film_id = b.film_id
group by a.title
;
select * from film_actor;
-- 6D
SELECT COUNT(f.title) AS 'HUNCHBACK IMPOSSIBLE COUNT' from film_text as f, inventory as i
where f.title='HUNCHBACK IMPOSSIBLE' 
AND F.FILM_ID = I.FILM_ID;

-- 6e
select p.customer_id, sum(p.amount), c.first_name, c.last_name from payment as p inner join customer as c on
p.customer_id= c.customer_id
group by p.customer_id
order by 4 asc;

-- 7 a
select title from (
select f.title, lng.name from language as lng, film as f
where lng.language_id = f.language_id) as second
where title like 'K%' or title like 'Q%';
;
-- 7b;

select first_name, last_name from actor
where actor_id  in (select actor_id from film_actor
where film_id = (select film_id from film
where title = 'Alone Trip'));

-- 7c Needcustomer table and addres table joind on address_id
select first_name, last_name,email, ctry.country
from customer as cust
left join address as addy on cust.address_id = addy.address_id
left join city as city on addy.city_id
left join country as ctry on city.country_id
where ctry.country = "CANADA";


-- 7 d
select a.title,c.name
from film as a
left join film_category as b on a.film_id = b.film_id
left join category c on b.category_id = c.category_id
where c.name = 'Family';

-- 7e
select * from renta
group by inventory_id
ORDER BY inventory_id Desc
;

-- 7 f
select a.store_id, sum(b.amount)
from staff as a
left join payment as b on a.staff_id = b.staff_id
group by a.store_id
;

-- 7 g

select a.store_id, b.address, c.city, d.country
from store as a
left join address as b on a.address_id= b.address_id
left join city as c on b.city_id = c.city_id
left join country as d on c.country_id = d.country_id;

-- 7 H
select a.name, sum(e.amount) from category as a
left join film_category as b on a.category_id = b.category_id
left join inventory as c on b.film_id = c.film_id
left join rental as d on c.inventory_id = d.inventory_id
left join payment as e on d.rental_id = e.rental_id
group by a.name
order by sum(e.amount) desc
limit 5;

-- 8 a
CREATE VIEW `TOP 5 Genres` as
select a.name, sum(e.amount) from category as a
left join film_category as b on a.category_id = b.category_id
left join inventory as c on b.film_id = c.film_id
left join rental as d on c.inventory_id = d.inventory_id
left join payment as e on d.rental_id = e.rental_id
group by a.name
order by sum(e.amount) desc
limit 5;

-- 8 b 
select * from `TOP 5 Genres`;


-- 8 c
drop view `TOP 5 Genres`;
-- WOW look its goooooone
select * from `TOP 5 Genres`;
