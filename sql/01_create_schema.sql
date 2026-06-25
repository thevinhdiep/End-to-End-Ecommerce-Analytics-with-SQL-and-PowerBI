-- =========================================================
-- Phase 4: Data Warehouse Schema Design (SQL Server / T-SQL)
-- =========================================================

-- Tạo Database nếu chưa tồn tại
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'EcommerceDB')
BEGIN
    CREATE DATABASE EcommerceDB;
END
GO

USE EcommerceDB;
GO

-- 1. Tạo các bảng Dimension (Chiều phân tích)
-- =========================================================

-- Bảng Khách hàng
IF OBJECT_ID('dim_customer', 'U') IS NOT NULL DROP TABLE dim_customer;
CREATE TABLE dim_customer (
    customer_id VARCHAR(50) PRIMARY KEY,
    gender VARCHAR(20),
    device_type VARCHAR(50),
    customer_login_type VARCHAR(50)
);
GO

-- Bảng Sản phẩm
IF OBJECT_ID('dim_product', 'U') IS NOT NULL DROP TABLE dim_product;
CREATE TABLE dim_product (
    product_id VARCHAR(50) PRIMARY KEY,
    product_name NVARCHAR(255),
    product_category NVARCHAR(100)
);
GO

-- Bảng Thời gian
IF OBJECT_ID('dim_date', 'U') IS NOT NULL DROP TABLE dim_date;
CREATE TABLE dim_date (
    date_id DATE PRIMARY KEY,
    order_month VARCHAR(20),
    order_quarter VARCHAR(20),
    order_weekday VARCHAR(20)
);
GO

-- 2. Tạo bảng Fact (Bảng Giao dịch/Sự kiện)
-- =========================================================

IF OBJECT_ID('fact_sales', 'U') IS NOT NULL DROP TABLE fact_sales;
CREATE TABLE fact_sales (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50) NOT NULL,
    product_id VARCHAR(50) NOT NULL,
    date_id DATE NOT NULL,
    payment_method VARCHAR(50),
    order_priority VARCHAR(50),
    sales DECIMAL(18, 2),
    quantity INT,
    discount DECIMAL(5, 2),
    profit DECIMAL(18, 2),
    shipping_cost DECIMAL(18, 2),
    aging DECIMAL(18, 2),

    -- Ràng buộc Khóa ngoại (Foreign Keys) trỏ tới các bảng Dimension
    CONSTRAINT FK_fact_sales_customer FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id),
    CONSTRAINT FK_fact_sales_product FOREIGN KEY (product_id) REFERENCES dim_product(product_id),
    CONSTRAINT FK_fact_sales_date FOREIGN KEY (date_id) REFERENCES dim_date(date_id)
);
GO

-- 3. Tạo các Index để tối ưu tốc độ truy vấn (Performance Tuning)
-- =========================================================

-- Tạo Non-Clustered Indexes trên các cột Khóa ngoại giúp JOIN và Filter nhanh hơn
CREATE NONCLUSTERED INDEX IX_fact_sales_customer_id ON fact_sales(customer_id);
CREATE NONCLUSTERED INDEX IX_fact_sales_product_id ON fact_sales(product_id);
CREATE NONCLUSTERED INDEX IX_fact_sales_date_id ON fact_sales(date_id);
GO
