CREATE DATABASE trade_dataset;
USE trade_dataset;
show tables;
select count(*) from data_cleaned; 


-- Simplest SELF JOIN
SELECT
    a.Year_Month,
    a.partner_country_code,
    b.trade_type
FROM data_cleaned a
JOIN data_cleaned b
    ON a.partner_country_code = b.partner_country_code
LIMIT 10;

-- Simple Import–Export JOIN (Join Import rows with Export rows)
SELECT
    a.partner_country_code,
    a.trade_value AS import_value,
    b.trade_value AS export_value
FROM data_cleaned a
JOIN data_cleaned b
    ON a.partner_country_code = b.partner_country_code
WHERE
    a.trade_type = 1
    AND b.trade_type = 2
LIMIT 10;

-- Self JOIN using same Year (Same country ,Same month , Different rows joined)
SELECT
    a.year_month,
    a.partner_country_code,
    a.trade_value,
    b.trade_value AS compared_value
FROM data_cleaned a
JOIN data_cleaned b
    ON a.partner_country_code = b.partner_country_code
   AND a.year_month = b.year_month
LIMIT 10;

-- There is only 1 table named data_cleaned, so we did join using different year 
SELECT
    a.partner_country_code,
    SUM(a.trade_Value) AS trade_1989,
    SUM(b.trade_Value) AS trade_1990
FROM data_cleaned a
JOIN data_cleaned b
    ON a.partner_country_code = b.partner_country_code
WHERE
    SUBSTRING(a.Year_Month, 1, 4) = '1989'
    AND SUBSTRING(b.Year_Month, 1, 4) = '1990'
GROUP BY a.partner_country_code;

-- LEFT JOIN (to understand unmatched data)
SELECT
    a.partner_country_code,
    a.hs_product_code,
    b.quantity
FROM data_cleaned a
LEFT JOIN data_cleaned b
    ON a.hs_product_code = b.hs_product_code
   AND a.partner_country_code = b.partner_country_code
LIMIT 10;

-- SELF JOIN using Product
SELECT
    a.hs_product_code,
    a.partner_country_code,
    a.trade_value,
    b.trade_value AS compared_trade_value
FROM data_cleaned a
JOIN data_cleaned b
    ON a.hs_product_code = b.hs_product_code
LIMIT 10;

-- JOIN with Trade Type difference(Builds foundation for trade balance analysis)
SELECT
    a.partner_country_code,
    a.hs_product_code,
    a.trade_type,
    b.trade_type AS compared_trade_type
FROM data_cleaned a
JOIN data_cleaned b
    ON a.hs_product_code = b.hs_product_code
WHERE a.trade_type <> b.trade_type
LIMIT 10;

-- JOIN on Month (Compare multiple metrics within same time period)
SELECT
    a.year_month,
    a.partner_country_code,
    a.trade_value,
    b.quantity
FROM data_cleaned a
JOIN data_cleaned b
    ON a.year_month = b.year_month
LIMIT 10;


