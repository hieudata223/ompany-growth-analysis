
--Doanh thu và lợi nhuận theo tháng
SELECT
    Month,
    Year,
    SUM(Revenue) AS monthly_revenue,
    SUM(Revenue - Cost) AS monthly_profit
FROM dbo.sales_data
GROUP BY Year, Month 
ORDER BY Year, Month ;
--MoM growth bằng LAG
WITH monthly_sales AS (
    SELECT
        Year,
        Month,
        SUM(Revenue) AS revenue
    FROM dbo.sales_data
    GROUP BY Year, Month
)
SELECT
    Year,
    Month,
    revenue,
    LAG(revenue) OVER (ORDER BY Year, Month) AS prev_month_revenue,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY Year, Month)) * 100.0
        / NULLIF(LAG(revenue) OVER (ORDER BY Year, Month), 0),
        2
    ) AS mom_growth_pct
FROM monthly_sales
ORDER BY Year, Month;
-- xếp hạng tháng doanh thu cao nhất
WITH monthly_sales AS (
    SELECT
        Year,
        Month,
        SUM(Revenue) AS revenue
    FROM dbo.sales_data
    GROUP BY Year, Month
)
SELECT
    Year,
    Month,
    revenue,
    RANK() OVER (ORDER BY revenue DESC) AS revenue_rank
FROM monthly_sales
ORDER BY revenue_rank;
--