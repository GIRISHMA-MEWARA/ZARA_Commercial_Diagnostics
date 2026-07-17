CREATE TABLE Zara_Sales(
raw_data TEXT
);
SELECT COUNT(*) FROM Zara_Sales;
CREATE TABLE Zara_Sales_Cleaned AS SELECT
split_part(raw_data, ',', 1) AS product_id,
split_part(raw_data, ',',2) AS product_position,
split_part(raw_data, ',',3) AS promotion,
split_part(raw_data, ',', 4) AS product_category,
split_part(raw_data, ',', 5) AS seasonal,
split_part(raw_data, ',', 6) AS sales_volume,
split_part(raw_data, ',', 7) AS brand,
split_part(raw_data, ',', 8) AS url,
split_part(raw_data, ',', 9) AS name,
split_part(raw_data, ',', 10) AS description,
split_part(raw_data, ',', 11) AS price,
split_part(raw_data, ',', 12) AS currency,
split_part(raw_data, ',', 13) AS terms,
split_part(raw_data, ',', 14) AS section,
split_part(raw_data, ',', 15) AS season,
split_part(raw_data, ',', 16) AS material,
split_part(raw_data, ',', 17) AS origin
FROM Zara_Sales;
SELECT * FROM Zara_Sales_Cleaned LIMIT 10;

SELECT 
COUNT(*) FILTER(WHERE price IS NULL OR price = ' ') AS blank_prices,
COUNT(*) FILTER(WHERE sales_volume IS NULL OR sales_volume = ' ') AS blank_sales
FROM Zara_Sales_Cleaned;

SELECT 
product_category, COUNT(*) FROM Zara_Sales_Cleaned
GROUP BY product_category
ORDER BY COUNT(*) DESC;

SELECT name, description
FROM Zara_Sales_Cleaned
WHERE name LIKE '%Ã%' OR description LIKE '%Ã%'
LIMIT 10;

SELECT product_category,name, description, price, sales_volume
FROM Zara_Sales_Cleaned
LIMIT 10;

DROP TABLE IF EXISTS Zara_Sales_Cleaned;
SELECT raw_data FROM Zara_Sales;

ALTER TABLE Zara_Sales_Cleaned
ALTER COLUMN price TYPE NUMERIC
USING (TRIM(price):: NUMERIC);

DELETE FROM Zara_Sales_Cleaned
WHERE price = 'price';

ALTER TABLE Zara_Sales_Cleaned
ALTER COLUMN sales_volume TYPE INTEGER
USING (TRIM(sales_volume)::INTEGER);

SELECT COUNT(*), AVG(price) AS Average_price,
SUM(sales_volume) AS Total_units_sold
FROM Zara_Sales_Cleaned;

DELETE FROM Zara_Sales_Cleaned
WHERE product_category = 'product_category';

SELECT 
product_position,promotion,
COUNT(*) AS Total_Unique_Products,
SUM(sales_volume) AS Total_units_sold,
ROUND(AVG(price),2) AS Avg_unit_price,
ROUND(SUM(price*sales_volume),2) AS Gross_Revenue
FROM Zara_Sales_Cleaned
GROUP BY product_position, promotion
ORDER BY product_position, promotion;

SELECT origin, material,
COUNT(*) AS Total_products,
SUM(Sales_volume) AS Total_Pieces_Sold
FROM Zara_Sales_Cleaned
WHERE origin IS NOT NULL AND origin != '' 
AND material IS NOT NULL AND material != ''
GROUP BY origin, material
ORDER BY Total_Pieces_Sold DESC LIMIT 10;

SELECT season, terms,
COUNT(*) AS Total_products,
SUM(sales_volume) AS Total_Pieces_Sold
FROM Zara_Sales_Cleaned
GROUP BY season,terms
ORDER BY season, Total_Pieces_Sold DESC;





