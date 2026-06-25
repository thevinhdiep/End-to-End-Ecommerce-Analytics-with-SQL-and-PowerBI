-- =========================================================
-- Phase 5: ETL Pipeline (SQL Server / T-SQL)
-- Extract, Transform, Load data from CSV to Star Schema
-- =========================================================

USE EcommerceDB;
GO

-- =========================================================
-- 1. EXTRACT: Tạo bảng Staging và nạp dữ liệu thô (BULK INSERT)
-- =========================================================

-- Xóa bảng Staging nếu đã tồn tại
IF OBJECT_ID('staging_orders', 'U') IS NOT NULL DROP TABLE staging_orders;

-- Tạo bảng Staging khớp với cấu trúc file CSV
CREATE TABLE staging_orders (
    order_id VARCHAR(50),
    order_date DATE,
    [time] VARCHAR(50),
    aging DECIMAL(18,2),
    customer_id VARCHAR(50),
    gender VARCHAR(20),
    device_type VARCHAR(50),
    customer_login_type VARCHAR(50),
    product_category NVARCHAR(100),
    product NVARCHAR(255),
    sales DECIMAL(18,2),
    quantity FLOAT,
    discount DECIMAL(5,2),
    profit DECIMAL(18,2),
    shipping_cost DECIMAL(18,2),
    order_priority VARCHAR(50),
    payment_method VARCHAR(50),
    order_month VARCHAR(20),
    order_quarter VARCHAR(20),
    order_weekday VARCHAR(20),
    profit_margin DECIMAL(18,4),
    shipping_cost_ratio DECIMAL(18,4)
);
GO

-- Nạp dữ liệu từ file CSV vào bảng Staging
-- LƯU Ý: Thay đổi đường dẫn 'C:\Path\To\Your\Portfolio\data\cleaned_ecommerce_dataset.csv'
-- thành đường dẫn tuyệt đối (Absolute Path) trên máy của bạn trước khi chạy.
BULK INSERT staging_orders
FROM 'C:\Users\Dell\Desktop\Portfolio\data\cleaned\cleaned_ecommerce_dataset.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2, -- Bỏ qua dòng tiêu đề
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
GO

-- =========================================================
-- 2. TRANSFORM & LOAD: Đẩy dữ liệu vào các bảng Dimension
-- =========================================================

-- 2.1 Load vào dim_customer
-- Dùng cú pháp INSERT ... SELECT DISTINCT để lọc các giá trị duy nhất
INSERT INTO dim_customer (customer_id, gender, device_type, customer_login_type)
SELECT customer_id, gender, device_type, customer_login_type
FROM (
    SELECT 
        customer_id, 
        gender, 
        device_type, 
        customer_login_type,
        ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date DESC) as rn
    FROM staging_orders
    WHERE customer_id IS NOT NULL 
      AND customer_id NOT IN (SELECT customer_id FROM dim_customer)
) t
WHERE rn = 1;
GO

-- 2.2 Load vào dim_product
-- Vì data gốc không có product_id, ta tạo mã tự động (VD: PRD_00001) dựa trên hàm ROW_NUMBER()
INSERT INTO dim_product (product_id, product_name, product_category)
SELECT 
    CONCAT('PRD_', RIGHT('00000' + CAST(ROW_NUMBER() OVER(ORDER BY product) AS VARCHAR), 5)) AS product_id,
    product AS product_name,
    product_category
FROM (
    SELECT 
        product, 
        product_category,
        ROW_NUMBER() OVER(PARTITION BY product ORDER BY order_date DESC) as rn
    FROM staging_orders
    WHERE product IS NOT NULL 
      AND product NOT IN (SELECT product_name FROM dim_product)
) t
WHERE rn = 1;
GO

-- 2.3 Load vào dim_date
-- Đẩy thông tin ngày tháng unique
INSERT INTO dim_date (date_id, order_month, order_quarter, order_weekday)
SELECT DISTINCT 
    order_date, 
    order_month, 
    order_quarter, 
    order_weekday
FROM staging_orders
WHERE order_date IS NOT NULL
  AND order_date NOT IN (SELECT date_id FROM dim_date);
GO

-- =========================================================
-- 3. LOAD: Đẩy dữ liệu vào bảng Fact
-- =========================================================

-- Load vào fact_sales
-- Ta cần JOIN staging_orders với dim_product thông qua cột product(name) để lấy được product_id mới tạo
INSERT INTO fact_sales (
    order_id, customer_id, product_id, date_id, payment_method, order_priority,
    sales, quantity, discount, profit, shipping_cost, aging
)
SELECT 
    s.order_id,
    s.customer_id,
    p.product_id,
    s.order_date,
    s.payment_method,
    s.order_priority,
    s.sales,
    s.quantity,
    s.discount,
    s.profit,
    s.shipping_cost,
    s.aging
FROM staging_orders s
JOIN dim_product p ON s.product = p.product_name
WHERE s.order_id NOT IN (SELECT order_id FROM fact_sales);
GO

-- =========================================================
-- 4. CLEANUP (Dọn dẹp)
-- =========================================================
-- Dọn dẹp bảng Staging sau khi ETL thành công để giải phóng dung lượng
DROP TABLE staging_orders;
GO

PRINT 'ETL Pipeline completed successfully!';
