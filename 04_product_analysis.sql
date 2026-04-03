/* PHÂN TÍCH SẢN PHẨM*/
--hiệu suất theo category
SELECT
    Product_Category,
    SUM(Revenue) AS revenue,
    SUM(Cost) AS cost,
    SUM(Revenue - Cost) AS profit,
    ROUND(SUM(Revenue - Cost) * 100.0 / NULLIF(SUM(Revenue), 0), 2) AS margin_pct
FROM dbo.sales_data
GROUP BY Product_Category
ORDER BY revenue DESC;
--hiệu suất theo sub-category
SELECT
    Product_Category,
    Sub_Category,
    SUM(Quantity) AS total_quantity,
    SUM(Revenue) AS revenue,
    SUM(Revenue - Cost) AS profit
FROM dbo.sales_data
GROUP BY Product_Category, Sub_Category
ORDER BY revenue DESC;
--rank sub-category trong từng category
WITH product_perf AS (
    SELECT
        Product_Category,
        Sub_Category,
        SUM(Revenue) AS revenue
    FROM dbo.sales_data
    GROUP BY Product_Category,Sub_Category
)
SELECT
    Product_Category,
    Sub_Category,
    revenue,
    RANK() OVER (PARTITION BY Product_Category ORDER BY revenue DESC) AS rank_in_category
FROM product_perf
ORDER BY Product_Category, rank_in_category;