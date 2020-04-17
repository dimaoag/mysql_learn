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

SELECT first_name, salary, manager_id FROM sql_hr.employees ORDER BY salary;


# LIMIT
SELECT * FROM sql_store.customers LIMIT 2;
SELECT * FROM sql_store.customers LIMIT 2 OFFSET 2;


# INNER JOIN
USE sql_store;
SELECT order_id, first_name, last_name
FROM sql_store.orders o
JOIN sql_store.customers c
    ON o.customer_id = c.customer_id;


SELECT order_id, o.product_id, quantity, o.unit_price
FROM sql_store.order_items o
JOIN sql_store.products p
    ON o.product_id = p.product_id;

# SELF JOIN
SELECT
    e.employee_id,
    e.first_name employee,
    m.first_name manager
FROM sql_hr.employees e
JOIN sql_hr.employees m
    ON e.reports_to = m.employee_id;

# MULTIPLE TABLES JOIN
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


# COMPOUND JOINS CONDITIONS (pair primary key)
SELECT
    *
FROM sql_store.order_items oi
JOIN sql_store.order_item_notes oin
    ON oi.order_id = oin.order_Id
    AND oi.product_id = oin.product_id;


# implicit join syntax
SELECT
    *
FROM sql_store.orders o, sql_store.customers c
WHERE o.customer_id = c.customer_id;


# LEFT JOIN
SELECT
    c.customer_id,
    c.first_name,
    o.order_id
FROM sql_store.customers c
JOIN sql_store.orders o
    ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

SELECT
    c.customer_id,
    c.first_name,
    o.order_id
FROM sql_store.customers c
LEFT JOIN sql_store.orders o
    ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

SELECT
    p.product_id,
    p.name,
    oi.quantity
FROM products p
LEFT JOIN sql_store.order_items oi
    ON p.product_id = oi.product_id;


# joins between multiple tables
SELECT
    c.customer_id,
    c.first_name,
    o.order_id,
    sh.name shipper
FROM sql_store.customers c
LEFT JOIN sql_store.orders o
    ON c.customer_id = o.customer_id
LEFT JOIN sql_store.shippers sh
    ON o.shipper_id = sh.shipper_id
ORDER BY c.customer_id;

SELECT
    o.order_id,
    o.order_date,
    c.first_name customer,
    sh.name shipper,
    s.name status
FROM sql_store.orders o
JOIN sql_store.customers c
    ON o.customer_id = c.customer_id
LEFT JOIN shippers sh
    ON o.shipper_id = sh.shipper_id
JOIN sql_store.order_statuses s
    ON o.status = s.order_status_id;













