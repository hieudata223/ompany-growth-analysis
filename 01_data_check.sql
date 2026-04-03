CREATE DATABASE sales_project;
-- Xem dữ liệu
SELECT TOP 10 *
FROM dbo.sales_data;
--Đếm số dòng
SELECT COUNT(*) AS total_rows
FROM dbo.sales_data;
--kiểm tra null
SELECT
    SUM(CASE WHEN Date IS NULL THEN 1 ELSE 0 END) AS null_date,
    SUM(CASE WHEN Year IS NULL THEN 1 ELSE 0 END) AS null_year,
    SUM(CASE WHEN Customer_Age IS NULL THEN 1 ELSE 0 END) AS null_customer_age,
    SUM(CASE WHEN Customer_Gender IS NULL THEN 1 ELSE 0 END) AS null_gender,
    SUM(CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS null_country,
    SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS null_state,
    SUM(CASE WHEN Product_Category IS NULL THEN 1 ELSE 0 END) AS null_product_category,
    SUM(CASE WHEN Sub_Category IS NULL THEN 1 ELSE 0 END) AS null_sub_category,
    SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS null_quantity,
    SUM(CASE WHEN Revenue IS NULL THEN 1 ELSE 0 END) AS null_revenue,
    SUM(CASE WHEN Cost IS NULL THEN 1 ELSE 0 END) AS null_cost
FROM dbo.sales_data;
/* 1 dòng dữ liệu bị thiếu tất cả dữ liệu trừ lợi nhuận*/
--kiểm tra duplicate
SELECT
    Date,
    Customer_Age,
    Customer_Gender,
    Country,
    State,
    Product_Category,
    Sub_Category,
    Quantity,
    Unit_Cost,
    Unit_Price,
    Revenue,
    Cost,
    COUNT(*) AS duplicate_count
FROM dbo.sales_data
GROUP BY
    Date,
    Customer_Age,
    Customer_Gender,
    Country,
    State,
    Product_Category,
    Sub_Category,
    Quantity,
    Unit_Cost,
    Unit_Price,
    Revenue,
    Cost
HAVING COUNT(*) > 1;
/* có 1 dòng bị duplicate đã xóa */
--kiểm tra dữ liệu bất thường
SELECT *
FROM dbo.sales_data
WHERE Quantity <= 0
   OR Revenue < 0
   OR Cost < 0
   OR Unit_Price < 0
   OR Unit_Cost < 0;
/* không có dữ liệu bất thường*/