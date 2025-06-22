
-- 1. Remove rows with NULL values in key columns
DELETE FROM retail_data
WHERE profit IS NULL OR category IS NULL OR sales IS NULL;

-- 2. Remove duplicate entries based on order_id and product_id
DELETE FROM retail_data
WHERE rowid NOT IN (
    SELECT MIN(rowid)
    FROM retail_data
    GROUP BY order_id, product_id
);

-- 3. Calculate profit margin by category and sub-category
SELECT
    category,
    sub_category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(SUM(profit) / NULLIF(SUM(sales), 0) * 100, 2) AS profit_margin_percent
FROM retail_data
GROUP BY category, sub_category
ORDER BY profit_margin_percent ASC;
