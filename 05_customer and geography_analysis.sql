/* PHÂN TÍCH KHÁCH HÀNG*/
--Theo nhóm tuổi + giới tính
SELECT
    CASE
        WHEN Customer_Age < 25 THEN 'Under 25'
        WHEN Customer_Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Customer_Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Customer_Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS age_group,
    Customer_Gender,
    COUNT(*) AS total_orders,
    SUM(Revenue) AS revenue,
    SUM(Revenue - Cost) AS profit,
    ROUND(SUM(Revenue) * 1.0 / COUNT(*), 2) AS avg_order_value
FROM dbo.sales_data
GROUP BY
    CASE
        WHEN Customer_Age < 25 THEN 'Under 25'
        WHEN Customer_Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Customer_Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Customer_Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END,
    Customer_Gender
ORDER BY revenue DESC;
--theo khu vực
SELECT
    Country,
    State,
    COUNT(*) AS total_orders,
    SUM(Revenue) AS revenue,
    SUM(Revenue - Cost) AS profit,
    ROUND(SUM(Revenue - Cost) * 100.0 / NULLIF(SUM(Revenue), 0), 2) AS margin_pct
FROM dbo.sales_data
GROUP BY Country, State
ORDER BY revenue DESC;
--Thứ hạng từng khu vực
WITH geo_perf AS (
    SELECT
        Country,
        State,
        SUM(Revenue) AS revenue
    FROM dbo.sales_data
    GROUP BY Country, State
)
SELECT
    Country,
    State,
    revenue,
    RANK() OVER (PARTITION BY Country ORDER BY revenue DESC) AS state_rank
FROM geo_perf
ORDER BY Country, state_rank;