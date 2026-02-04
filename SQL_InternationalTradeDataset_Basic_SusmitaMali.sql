USE trade_dataset  ;
DESCRIBE data_cleaned;

SELECT *
FROM data_cleaned
LIMIT 10;

-- Unique trade types
SELECT DISTINCT trade_type
FROM data_cleaned;

-- Unique partner countries
SELECT DISTINCT partner_country_code
FROM data_cleaned;

-- Records with non-null trade value
SELECT *
FROM data_cleaned
WHERE trade_value IS NOT NULL;

-- High-value trade records
SELECT *
FROM data_cleaned
WHERE trade_value > 1000000;

-- Export-only records
SELECT *
FROM data_cleaned
WHERE trade_type = 2;

-- Sorting Operations
-- Highest trade value records
SELECT *
FROM data_cleaned
ORDER BY trade_value DESC
LIMIT 10;

-- Lowest trade value records
SELECT *
FROM data_cleaned
ORDER BY trade_value ASC
LIMIT 10;

-- Aggregation & Group-Based Analysis
-- Trade value by trade type
SELECT trade_type,
       SUM(trade_value) AS total_trade_value
FROM data_cleaned
GROUP BY trade_type;

-- Trade value by partner country
SELECT Partner_Country_Code,
       SUM(Trade_Value) AS total_trade_value
FROM data_cleaned
GROUP BY Partner_Country_Code
ORDER BY total_trade_value DESC;

-- Trade value by product category
SELECT product_category_code,
       SUM(trade_value) AS total_trade_value
FROM data_cleaned
GROUP BY product_category_code
ORDER BY total_trade_value DESC;

-- Trade value by HS product code
SELECT HS_Product_Code,
       SUM(Trade_Value) AS total_trade_value
FROM data_cleaned
GROUP BY HS_Product_Code
ORDER BY total_trade_value DESC;

-- Subquery Operations (NO JOINs)
-- Trades above overall average trade value
SELECT *
FROM data_cleaned
WHERE trade_value >
      (SELECT AVG(trade_value) FROM data_cleaned);

-- Maximum trade value record
SELECT *
FROM data_cleaned
WHERE trade_value =
      (SELECT MAX(trade_value) FROM data_cleaned);

-- Export records above average export trade value
SELECT *
FROM data_cleaned
WHERE trade_type = 2
  AND trade_value >
      (SELECT AVG(trade_value)
       FROM data_cleaned
       WHERE trade_type = 2);

-- Correlated subquery – country-wise comparison
SELECT *
FROM data_cleaned d
WHERE trade_value >
      (SELECT AVG(trade_value)
       FROM data_cleaned
       WHERE partner_country_code = d.partner_country_code);

-- Validation Queries
-- Count records by trade type
SELECT trade_type,
       COUNT(*) AS record_count
FROM data_cleaned
GROUP BY trade_type;

-- Total trade value 
SELECT SUM(trade_value) AS total_trade_value
FROM data_cleaned;


