create database challenge1;
use challenge1;

CREATE TABLE cars (
car_id INT PRIMARY KEY,
make VARCHAR(50),
type VARCHAR(50),
style VARCHAR(50),
cost_$ INT
);
--------------------
INSERT INTO cars (car_id, make, type, style, cost_$)
VALUES (1, 'Honda', 'Civic', 'Sedan', 30000),
(2, 'Toyota', 'Corolla', 'Hatchback', 25000),
(3, 'Ford', 'Explorer', 'SUV', 40000),
(4, 'Chevrolet', 'Camaro', 'Coupe', 36000),
(5, 'BMW', 'X5', 'SUV', 55000),
(6, 'Audi', 'A4', 'Sedan', 48000),
(7, 'Mercedes', 'C-Class', 'Coupe', 60000),
(8, 'Nissan', 'Altima', 'Sedan', 26000);
--------------------
CREATE TABLE salespersons (
salesman_id INT PRIMARY KEY,
name VARCHAR(50),
age INT,
city VARCHAR(50)
);
--------------------
INSERT INTO salespersons (salesman_id, name, age, city)
VALUES (1, 'John Smith', 28, 'New York'),
(2, 'Emily Wong', 35, 'San Fran'),
(3, 'Tom Lee', 42, 'Seattle'),
(4, 'Lucy Chen', 31, 'LA');
--------------------
CREATE TABLE sales (
sale_id INT PRIMARY KEY,
car_id INT,
salesman_id INT,
purchase_date DATE,
FOREIGN KEY (car_id) REFERENCES cars(car_id),
FOREIGN KEY (salesman_id) REFERENCES salespersons(salesman_id)
);
--------------------
INSERT INTO sales (sale_id, car_id, salesman_id, purchase_date)
VALUES (1, 1, 1, '2021-01-01'),
(2, 3, 3, '2021-02-03'),
(3, 2, 2, '2021-02-10'),
(4, 5, 4, '2021-03-01'),
(5, 8, 1, '2021-04-02'),
(6, 2, 1, '2021-05-05'),
(7, 4, 2, '2021-06-07'),
(8, 5, 3, '2021-07-09'),
(9, 2, 4, '2022-01-01'),
(10, 1, 3, '2022-02-03'),
(11, 8, 2, '2022-02-10'),
(12, 7, 2, '2022-03-01'),
(13, 5, 3, '2022-04-02'),
(14, 3, 1, '2022-05-05'),
(15, 5, 4, '2022-06-07'),
(16, 1, 2, '2022-07-09'),
(17, 2, 3, '2023-01-01'),
(18, 6, 3, '2023-02-03'),
(19, 7, 1, '2023-02-10'),
(20, 4, 4, '2023-03-01');


-- Challeneg1
-- Steve's Car  Showroom Analysis 
-- SQL-CASE-STUDY-ANALYSIS

select * from sales;
select * from cars;
select * from salespersons; 

-- 1. WHAT ARE THE DETAILS OF ALL CARS PURCHASED IN THE YEAR 2022?

select C.*, S.sale_id, S.Salesman_id, S.purchase_date
from sales as S join cars as C
on C.car_id = S.car_id
where YEAR(S.Purchase_date) = 2022
order by purchase_date;


-- 2. WHAT IS THE TOTAL NUMBER OF CARS SOLD BY EACH SALESPERSON? 

select SP.*, count(S.sale_id) as Total, SP.salesman_id
from sales as S
join salespersons as SP on
SP.salesman_id = S.salesman_id
Group by SP.salesman_id;

-- 3. WHAT IS THE TOTAL REVENUE GENERATED BY EACH SALESPERSON? 

select S.salesman_id , SP.name ,SUM(C.cost_$) as revenue
from Sales as S
join salespersons as SP 
on SP.salesman_id = S.salesman_id
join cars as C
on C.car_id = S.car_id
group by SP.name, SP.salesman_id;  

-- 4. WHAT ARE THE DETAILS OF THE CARS SOLD BY EACH SALESPERSON? 

select S.salesman_id, SP.name, C.*
from sales as S
join salespersons as SP on
S.salesman_id = SP.salesman_id
join cars as C on C.car_id = S.car_id
order by S.salesman_id , C.car_id;


-- 5. WHAT IS THE TOTAL REVENUE GENERATED BY EACH CAR TYPE?

select C.type , S.car_id, sum(C.cost_$) as revenue
from cars as C
join sales as S on C.car_id = S.car_id
group by S.car_id;


-- 6. WHAT ARE THE DETAILS OF THE CARS SOLD IN THE YEAR 2021 BY SALESPERSON 'EMILY WONG'?

select C.make, C.type, C.style, C.cost_$ ,S.purchase_date, SP.name
from cars as C
join sales as S on C.car_id = S.car_id
join salespersons as SP on S.salesman_id = SP.salesman_id
where year(S.purchase_date) = 2021 and SP.name = "Emily Wong";


-- 7. WHAT IS THE TOTAL REVENUE GENERATED BY THE SALES OF HATCHBACK CARS?

select sum(C.cost_$) as revenue
from cars as C
join sales as S on C.car_id =S.car_id
where C.style ="Hatchback";

-- 8. WHAT IS THE TOTAL REVENUE GENERATED BY THE SALES OF SUV CARS IN THE YEAR 2022?

select sum(C.cost_$) as revenue
from cars as C
join sales as S on C.car_id =S.car_id
where C.style = "SUV" and year(purchase_date) =2022;

-- 9. WHAT IS THE NAME AND CITY OF THE SALESPERSON WHO SOLD THE MOST NUMBER OF CARS IN THE YEAR 2023?

select SP.name , SP.city, count(C.car_id)
from sales as S join cars as  C on C.car_id= S.car_id
join salespersons as SP on S.salesman_id = SP.salesman_id
where year(S.purchase_date) = 2023
group by SP.name , SP.city
order by count(C.car_id) DESC
LIMIT 1;

-- 10. WHAT IS THE NAME AND AGE OF THE SALESPERSON WHO GENERATED THE HIGHEST REVENUE IN THE YEAR 2022?

select SP.name, SP.age , sum(C.cost_$) as revenue
from salespersons as SP
join sales as S on SP.salesman_id = S.salesman_id
join cars as C on C.car_id = S.car_id
where year(purchase_date) = 2022
group by SP.name, SP.age
order by sum(C.cost_$) DESC
LIMIT 1;


------------------------------------------------------------------------------------------------------------------------------------------------------------------












