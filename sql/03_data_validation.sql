-- =========================================================
-- Phase 6: Data Validation & Quality Assurance (QA)
-- =========================================================

USE EcommerceDB;
GO

-- 1. Kiểm tra số lượng dòng (Row Count Check)
-- Bảng fact_sales phải có đúng 51,290 dòng (khớp với file CSV ban đầu)
SELECT 
    'Row Count' AS Test_Name,
    COUNT(*) AS Actual_Value,
    51290 AS Expected_Value,
    CASE WHEN COUNT(*) = 51290 THEN 'Passed' ELSE 'Failed' END AS Status
FROM fact_sales;
GO

-- 2. Kiểm tra tính toàn vẹn của Khóa ngoại (Referential Integrity Check)
-- Đảm bảo không có order nào chứa customer_id hoặc product_id không tồn tại trong bảng Dimension (Orphan Records)
SELECT 
    'Orphan Customers' AS Test_Name,
    COUNT(*) AS Orphan_Count,
    CASE WHEN COUNT(*) = 0 THEN 'Passed' ELSE 'Failed' END AS Status
FROM fact_sales f
LEFT JOIN dim_customer c ON f.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
GO

SELECT 
    'Orphan Products' AS Test_Name,
    COUNT(*) AS Orphan_Count,
    CASE WHEN COUNT(*) = 0 THEN 'Passed' ELSE 'Failed' END AS Status
FROM fact_sales f
LEFT JOIN dim_product p ON f.product_id = p.product_id
WHERE p.product_id IS NULL;
GO

-- 3. Kiểm tra trùng lặp dữ liệu (Duplication Check)
-- Khóa chính order_id không được phép trùng lặp
SELECT 
    'Duplicate Orders' AS Test_Name,
    COUNT(order_id) - COUNT(DISTINCT order_id) AS Duplicate_Count,
    CASE WHEN COUNT(order_id) = COUNT(DISTINCT order_id) THEN 'Passed' ELSE 'Failed' END AS Status
FROM fact_sales;
GO

-- 4. Kiểm tra giá trị NULL (Null Check)
-- Các cột quan trọng không được phép chứa giá trị NULL sau khi đã chạy ETL
SELECT 
    'Null Sales/Profit Check' AS Test_Name,
    COUNT(*) AS Null_Count,
    CASE WHEN COUNT(*) = 0 THEN 'Passed' ELSE 'Failed' END AS Status
FROM fact_sales
WHERE sales IS NULL OR profit IS NULL OR quantity IS NULL;
GO

-- 5. Kiểm tra logic nghiệp vụ (Business Logic Check)
-- Giá trị Sales, Quantity không được phép âm trong ngành bán lẻ
SELECT 
    'Negative Values Check' AS Test_Name,
    COUNT(*) AS Negative_Count,
    CASE WHEN COUNT(*) = 0 THEN 'Passed' ELSE 'Failed' END AS Status
FROM fact_sales
WHERE sales < 0 OR quantity < 0;
GO

-- 6. Đối soát tổng doanh thu (Revenue Reconciliation)
-- Kiểm tra tổng doanh thu có khớp với báo cáo Python ở Phase 1 (~ 7,813,411) hay không
SELECT 
    'Total Revenue' AS Metric_Name,
    SUM(sales) AS Total_Value
FROM fact_sales;
GO
