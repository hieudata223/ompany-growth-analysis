--KPI OVERVIEW
SELECT
    SUM(Revenue) AS total_revenue,
    SUM(Cost) AS total_cost,
    SUM(Revenue - Cost) AS total_profit,
    ROUND(SUM(Revenue - Cost) * 100.0 / NULLIF(SUM(Revenue), 0), 2) AS profit_margin_pct,
    COUNT(*) AS total_orders,
    SUM(Quantity) AS total_quantity,
    ROUND(SUM(Revenue) * 1.0 / COUNT(*), 2) AS avg_order_value
FROM dbo.sales_data;
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