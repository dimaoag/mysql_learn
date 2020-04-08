SHOW databases;

USE sql_store;

SELECT first_name, last_name, points p, points + 10 AS sum FROM sql_store.customers;

SELECT DISTINCT state FROM sql_store.customers; # unique values

SELECT name, unit_price, unit_price * 1.1 AS new_price FROM sql_store.products;

# // Operators
# >
# >=
# <
# <=
# =
# !=
# <>
# <>
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

# LIKE
SELECT * FROM sql_store.customers WHERE first_name LIKE 'b%';
SELECT * FROM sql_store.customers WHERE last_name LIKE '%y';
SELECT * FROM sql_store.customers WHERE last_name LIKE '%caf%';
SELECT * FROM sql_store.customers WHERE last_name LIKE '_____y';
SELECT * FROM sql_store.customers WHERE last_name LIKE 'b____y';
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









