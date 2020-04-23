/*
 Data types
 int - 1 3 -200
 number(p,s)  p - общее максимальное количество цифр; s - дробная часть; number(7,2)=12345,67; number(2)=54;
            максимальное к-во цифр на целую часть = p - s;

 char(length) - old type - fixed length
 varchar(length) - flexible length
 date - 11-Sep-19 23:17:18
 timestamp(f) f - length mili seconds
 NULL
 */
SHOW databases;

DESCRIBE sql_hr.countries;  # review schema.table_name
DESC sql_hr.countries;  # review schema.table_name


SELECT first_name, last_name, points p, points + 10 AS sum FROM sql_store.customers;

SELECT DISTINCT state, first_name FROM sql_store.customers; # unique values

SELECT name, unit_price, unit_price * 1.1 AS new_price FROM sql_store.products;

SELECT start_date, end_date, DATEDIFF(end_date, start_date) AS working_days FROM sql_hr.job_history; # diff
SELECT start_date, DATE_SUB(start_date, INTERVAL 7 DAY ) AS next_week FROM sql_hr.job_history; # minus
SELECT start_date, DATE_ADD(start_date, INTERVAL 7 DAY ) AS next_week FROM sql_hr.job_history; # plus

SELECT CONCAT(first_name, ' ',last_name) AS full_name FROM sql_hr.employees;
SELECT CONCAT(first_name, ' ',last_name) full_name FROM sql_hr.employees;
SELECT CONCAT(first_name, ' ',last_name) "Full name" FROM sql_hr.employees;
SELECT 'It''s my life' FROM sql_hr.employees;

/*
    Priority Operators
    ()
    * /
    + -
    = < > >= <=
    [NOT] LIKE, IS [NOT] NULL, [NOT] IN
    [NOT] BETWEEN
    != <>
    NOT
    AND
    OR
 */
SELECT * FROM sql_hr.employees WHERE employee_id = manager_id + 1;

SELECT *
FROM sql_hr.employees
WHERE CONCAT('Dr ', first_name, ' ' , last_name) = 'Dr Mindy Crissil';

SELECT * FROM sql_store.customers WHERE state <> 'va';  # all without state != 'va'

# >
SELECT * FROM sql_store.customers WHERE birth_date > '1990-01-01';

# AND
SELECT * FROM sql_store.orders WHERE order_date > '2018-01-01' AND order_date < '2018-12-31';

# OR
SELECT * FROM sql_store.customers WHERE birth_date > '1990-01-01' OR points > 1000;

# NOT
SELECT * FROM sql_store.order_items WHERE order_id = 6 AND (quantity * unit_price) > 30;
SELECT * FROM sql_store.order_items WHERE order_id = 6 AND NOT (quantity * unit_price) > 30;

# IN
SELECT * FROM sql_store.customers WHERE state IN ('va', 'fl', 'ga');
SELECT * FROM sql_store.customers WHERE state NOT IN ('va', 'fl', 'ga');

# BETWEEN
SELECT * FROM sql_store.customers WHERE points BETWEEN 1000 AND 2000;

# IS NULL
SELECT * FROM sql_hr.employees WHERE manager_id IS NULL;
SELECT * FROM sql_hr.employees WHERE manager_id IS NOT NULL;

# LIKE
SELECT * FROM sql_store.customers WHERE first_name LIKE 'b%';
SELECT * FROM sql_store.customers WHERE last_name LIKE '%y';
SELECT * FROM sql_store.customers WHERE last_name LIKE '%caf%';
SELECT * FROM sql_store.customers WHERE last_name LIKE '_____y';
SELECT * FROM sql_store.customers WHERE last_name LIKE 'b____y';
SELECT * FROM sql_store.customers WHERE last_name LIKE 'na$\%' ESCAPE '$'; # first char after '$' will be single char, not special
SELECT * FROM sql_store.customers WHERE address LIKE '%trail%' OR address LIKE '%avenue%';

# REGEXP
SELECT * FROM sql_store.customers WHERE last_name REGEXP 'field|mac';
SELECT * FROM sql_store.customers WHERE last_name REGEXP 'field$|mac';
SELECT * FROM sql_store.customers WHERE last_name REGEXP '[gim]e'; # front "e" available g or i or m (characters)
SELECT * FROM sql_store.customers WHERE last_name REGEXP '[a-h]e';

/*
 ^ - start string
 $ - end string
 | - OR
 [dfr] - match list of characters
 [-] - match range ([a-z][0-9])
 */

# IS NULL IS NOT NULL
SELECT * FROM sql_store.customers WHERE phone IS NULL;
SELECT * FROM sql_store.customers WHERE phone IS NOT NULL;

# ORDER BY
SELECT * FROM sql_store.customers ORDER BY first_name;
SELECT * FROM sql_store.customers ORDER BY first_name DESC;
SELECT * FROM sql_store.customers ORDER BY state, first_name;
SELECT * FROM sql_store.customers ORDER BY state DESC, first_name;
SELECT *, quantity * unit_price AS total_price FROM sql_store.order_items WHERE order_id = 2 ORDER BY total_price DESC;

# GROUP BY  Aggregations functions COUNT(), SUM(), AVG(), MAX(), MIN(),
SELECT department_id, COUNT(*) count, MIN(salary) min_salary
FROM sql_hr.employees
GROUP BY department_id
ORDER BY count DESC;

SELECT department_id, job_id, COUNT(*) count
FROM sql_hr.employees
GROUP BY department_id, job_id
ORDER BY department_id;

SELECT job_id, DATE_FORMAT(hire_date, '%Y') year, SUM(salary) sum_salary
FROM sql_hr.employees
WHERE job_id IN ('AD VP', 'SA REP', 'FI ACCOUNT')
GROUP BY job_id, year
ORDER BY year;


# HAVING only groups functions
SELECT department_id, COUNT(*) count
FROM sql_hr.employees
WHERE LENGTH(first_name) > 5
GROUP BY department_id
HAVING count >= 2
ORDER BY count DESC;


# LIMIT
SELECT * FROM sql_store.customers LIMIT 2;
SELECT * FROM sql_store.customers LIMIT 2 OFFSET 2;


# NATURAL JOIN - the same column name in two tables
SELECT c.country_id, c.country_name, r.region_name
FROM sql_hr.regions r
NATURAL JOIN sql_hr.countries c;

# JOIN USING - using union columns with the same column name
SELECT e.first_name, e.last_name, d.department_name, d.department_id
FROM sql_hr.employees e
JOIN sql_hr.departments d USING (department_id);

# JOIN ON - using union columns with the different column name
SELECT first_name, last_name, h.job_id, start_date, end_date
FROM sql_hr.employees e
JOIN sql_hr.job_history h
ON e.employee_id = h.employee_id;

# JOIN 3 tables
SELECT first_name, last_name, jh.job_id, start_date, end_date, department_name
FROM sql_hr.employees e
JOIN sql_hr.job_history jh
ON e.employee_id = jh.employee_id
JOIN departments d
ON jh.department_id = d.department_id;

SELECT
    o.order_id,
    o.order_date,
    c.first_name,
    c.last_name,
    s.name status
FROM sql_store.orders o
JOIN sql_store.customers c
ON o.customer_id = c.customer_id
JOIN sql_store.order_statuses s
ON o.status = s.order_status_id;



SELECT
    p.date,
    p.invoice_id,
    p.amount,
    c.name,
    pm.name
FROM sql_invoicing.payments p
JOIN sql_invoicing.clients c
ON p.client_id = p.client_id
JOIN sql_invoicing.payment_methods pm
ON p.payment_method = pm.payment_method_id;


# SELF JOIN
SELECT e1.first_name first_name, e1.last_name last_name, e2.first_name manager
FROM sql_hr.employees e1
JOIN sql_hr.employees e2
ON e1.manager_id = e2.employee_id;


# LEFT OUTER JOIN
SELECT first_name, last_name, salary, department_name
FROM sql_hr.employees e
LEFT JOIN sql_hr.departments d
ON e.department_id = d.department_id;

# RIGHT OUTER JOIN
SELECT first_name, last_name, salary, department_name
FROM sql_hr.employees e
RIGHT JOIN sql_hr.departments d
ON e.department_id = d.department_id;

# FULL OUTER JOIN in mysql not exist.
# this is imitation full outer join, should be the same column name in select list
SELECT first_name, last_name, salary, department_name, location_id
FROM sql_hr.employees e
LEFT JOIN sql_hr.departments d
ON e.department_id = d.department_id
UNION
SELECT first_name, last_name, salary, department_name, location_id
FROM sql_hr.employees e
RIGHT JOIN sql_hr.departments d
ON e.department_id = d.department_id;


# CROSS JOIN (перекресное обединение) каждая строка с одной таблици обединяется с каждой строкой другой таблици
SELECT *
FROM sql_hr.countries
CROSS JOIN sql_hr.regions;


# Tasks after joins

# 1. Count employees in each of regions
SELECT region_name, COUNT(*)
FROM sql_hr.employees e
JOIN sql_hr.departments d ON e.department_id = d.department_id
JOIN sql_hr.locations l ON d.location_id = l.location_id
JOIN sql_hr.countries c ON l.country_id = c.country_id
JOIN sql_hr.regions r ON c.region_id = r.region_id
GROUP BY region_name;

SELECT m.first_name, COUNT(*)
FROM sql_hr.employees e
JOIN sql_hr.employees m ON e.manager_id = m.employee_id
GROUP BY m.first_name
HAVING COUNT(*) >= 2;



# COMPOUND JOINS CONDITIONS (pair primary key)
SELECT *
FROM sql_store.order_items oi
JOIN sql_store.order_item_notes oin
ON oi.order_id = oin.order_Id
AND oi.product_id = oin.product_id;

# Sub queries return single raw
SELECT first_name, last_name, salary
FROM sql_hr.employees e
WHERE salary > (SELECT AVG(salary) FROM employees e2);



# get all managers
SELECT first_name, last_name, salary
FROM sql_hr.employees e
WHERE e.employee_id IN (SELECT e2.manager_id FROM employees e2);

# min and max salary in each of departments
SELECT department_name, MIN(salary), MAX(salary)
FROM (
    SELECT salary, department_name
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
    ) as sdn
GROUP BY department_name;

# get all employees where salary > avg salary in him department
SELECT e1.first_name, e1.last_name, e1.salary, d.department_name,
       (
           SELECT AVG(e2.salary)
           FROM employees e2
           WHERE e2.department_id = e1.department_id
       ) avg_salary
FROM sql_hr.employees e1
JOIN departments d on e1.department_id = d.department_id
WHERE e1.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e1.department_id
    );


# all employees who work in some country
SELECT first_name, last_name, salary
FROM sql_hr.employees e
WHERE department_id IN (
    SELECT department_id FROM departments WHERE location_id IN (
        SELECT location_id FROM locations WHERE country_id = (
            SELECT country_id FROM countries WHERE country_name = 'United States of America'
        )
    )
);


# Получить город/города, где сотрудники в сумме зарабатывают меньше всего.
SELECT city, SUM(salary) sum_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
GROUP BY city
HAVING sum_salary = (
    SELECT MIN(sum_salary)
    FROM (SELECT SUM(salary) sum_salary
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
    JOIN locations l ON d.location_id = l.location_id
    GROUP BY city) as e2d2l2ss);



# INSERT
INSERT INTO countries VALUES ('SW', 'Sweden', 1);
INSERT INTO countries (country_id, country_name, region_id) VALUES ('NR', 'Norway', 1);
INSERT INTO employees (employee_id, last_name, email, phone_number, hire_date, job_id)
VALUES (111, UCASE('alex'), UPPER('alex'), 122313, DATE('2002-03-15'), 'FI MGR');


# insert with a sub query
CREATE TABLE sql_hr.new_emps
(
    emp_id integer,
    name varchar(20),
    start_date date,
    job varchar(10)
);

INSERT INTO sql_hr.new_emps (emp_id, name, start_date)
(
    SELECT employee_id, first_name, hire_date
    FROM employees
    WHERE employee_id > 105
);


# UPDATE
UPDATE employees SET salary = 17000 WHERE employee_id = 100;
UPDATE employees SET salary = salary + 1000 WHERE employee_id > 105;
UPDATE employees e,
    (
    SELECT CAST(AVG(e1.salary) AS UNSIGNED) value
    FROM employees e1 WHERE e1.department_id IN (
        SELECT d1.department_id FROM departments d1 WHERE d1.department_name = 'Executive'
        )
    ) AS avg_salary
SET e.salary = avg_salary.value
WHERE department_id IN (
    SELECT department_id FROM departments WHERE department_name = 'Finance'
);


# DELETE
DELETE FROM new_emps WHERE emp_id = 111;
DELETE FROM new_emps WHERE emp_id IN (110);


# TRANSACTION
START TRANSACTION;
UPDATE employees SET salary = 17100 WHERE employee_id = 100;
DELETE FROM new_emps WHERE emp_id = 109;
COMMIT;

BEGIN;
UPDATE employees SET salary = 17000 WHERE employee_id = 100;
DELETE FROM new_emps WHERE emp_id = 108;
ROLLBACK;


# CREATE TABLE
CREATE TABLE sql_hr.students (
    student_id integer,
    name varchar(255),
    start_date date DEFAULT(CURRENT_DATE),
    scholarship numeric(6,2),
    avg_score numeric(4,2) DEFAULT 5
);
INSERT INTO students VALUES (1, 'Zaur', DATE('2004-10-25'), 1500.3, 7.8);
INSERT INTO students VALUES (2, 'Ivan', DATE('2002-05-07'), 800.36, 8);
INSERT INTO students (student_id, name, scholarship) VALUES (3, 'Nina', 750);

# ALTER TABLE
ALTER TABLE students
ADD COLUMN course numeric DEFAULT(3) AFTER name;

ALTER TABLE students
MODIFY COLUMN avg_score numeric(5,3);

ALTER TABLE students
CHANGE COLUMN avg_score avg_score integer;

ALTER TABLE students
RENAME COLUMN avg_score TO avg;

ALTER TABLE students
DROP COLUMN scholarship;

# TRUNCATE TABLE
TRUNCATE TABLE students;

# DROP TABLE
DROP TABLE students;















