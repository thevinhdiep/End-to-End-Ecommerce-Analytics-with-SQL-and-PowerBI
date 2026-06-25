-- =========================================================
-- Phase 7: Business Analytics with Advanced T-SQL
-- Mục đích: Khai thác dữ liệu từ Data Warehouse để tìm ra các Insight kinh doanh
-- =========================================================

USE EcommerceDB;
GO

-- ---------------------------------------------------------
-- Báo cáo 1: Xu hướng Doanh thu hàng tháng & Doanh thu lũy kế (YTD Revenue)
-- Câu hỏi: Tốc độ tăng trưởng dòng tiền qua từng tháng như thế nào?
-- Kỹ thuật: Window Function (SUM OVER)
-- ---------------------------------------------------------
WITH MonthlySales AS (
    SELECT 
        d.order_month,
        SUM(f.sales) AS total_revenue
    FROM fact_sales f
    JOIN dim_date d ON f.date_id = d.date_id
    GROUP BY d.order_month
)
SELECT 
    order_month,
    total_revenue,
    SUM(total_revenue) OVER (ORDER BY order_month ROWS UNBOUNDED PRECEDING) AS ytd_revenue
FROM MonthlySales
ORDER BY order_month;
GO

-- ---------------------------------------------------------
-- Báo cáo 2: Xếp hạng Top 5 Khách hàng mang lại Doanh thu cao nhất
-- Câu hỏi: Khách hàng nào (VIP) đóng góp doanh thu lớn nhất cho công ty?
-- Kỹ thuật: Window Function (RANK), OFFSET FETCH
-- ---------------------------------------------------------
WITH CustomerRevenue AS (
    SELECT 
        f.customer_id,
        c.gender,
        c.device_type,
        SUM(f.sales) AS total_revenue,
        SUM(f.profit) AS total_profit
    FROM fact_sales f
    JOIN dim_customer c ON f.customer_id = c.customer_id
    GROUP BY f.customer_id, c.gender, c.device_type
)
SELECT 
    customer_id,
    gender,
    device_type,
    total_revenue,
    total_profit,
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM CustomerRevenue
ORDER BY total_revenue DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;
GO

-- ---------------------------------------------------------
-- Báo cáo 3: Phân tích Hiệu suất Ngành hàng (Biên lợi nhuận)
-- Câu hỏi: Ngành hàng nào bán chạy nhất, ngành nào sinh lời hiệu quả nhất?
-- Kỹ thuật: Aggregation, Toán học (Chống chia cho 0)
-- ---------------------------------------------------------
SELECT 
    p.product_category,
    COUNT(DISTINCT f.order_id) AS total_orders,
    SUM(f.sales) AS total_revenue,
    SUM(f.profit) AS total_profit,
    -- Tính Profit Margin %, dùng NULLIF để tránh lỗi chia cho 0
    CAST(SUM(f.profit) / NULLIF(SUM(f.sales), 0) * 100 AS DECIMAL(5,2)) AS profit_margin_pct
FROM fact_sales f
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY p.product_category
ORDER BY profit_margin_pct DESC;
GO

-- ---------------------------------------------------------
-- Báo cáo 4: Tốc độ xử lý đơn hàng (Aging) theo Mức độ ưu tiên
-- Câu hỏi: Hệ thống Vận hành/Logistics có ưu tiên xử lý các đơn hàng 'Critical' nhanh hơn không?
-- Kỹ thuật: CASE WHEN trong ORDER BY
-- ---------------------------------------------------------
SELECT 
    order_priority,
    COUNT(order_id) AS total_orders,
    CAST(AVG(aging) AS DECIMAL(5,2)) AS avg_processing_days,
    MAX(aging) AS max_processing_days
FROM fact_sales
GROUP BY order_priority
ORDER BY 
    CASE order_priority 
        WHEN 'Critical' THEN 1 
        WHEN 'High' THEN 2 
        WHEN 'Medium' THEN 3 
        WHEN 'Low' THEN 4 
        ELSE 5 
    END;
GO

-- ---------------------------------------------------------
-- Báo cáo 5: Chấm điểm RFM cơ bản (Recency, Frequency, Monetary)
-- Câu hỏi: Nhận diện khách hàng có giá trị cao, khách hàng trung thành hoặc có nguy cơ rời bỏ?
-- Kỹ thuật: Phức hợp CTE, DATEDIFF & Window Functions (NTILE)
-- ---------------------------------------------------------
-- Giả định ngày chạy báo cáo là 01/01/2019 (Sau ngày mua cuối cùng trong năm 2018)
DECLARE @AnalysisDate DATE = '2019-01-01'; 

WITH CustomerRFM AS (
    SELECT 
        customer_id,
        DATEDIFF(DAY, MAX(date_id), @AnalysisDate) AS recency_days,
        COUNT(DISTINCT order_id) AS frequency_orders,
        SUM(sales) AS monetary_value
    FROM fact_sales
    GROUP BY customer_id
)
SELECT 
    customer_id,
    recency_days,
    frequency_orders,
    monetary_value,
    -- Dùng NTILE(4) chia thành 4 tứ phân vị để chấm điểm từ 1 đến 4
    NTILE(4) OVER (ORDER BY recency_days DESC) AS R_Score,
    NTILE(4) OVER (ORDER BY frequency_orders ASC) AS F_Score,
    NTILE(4) OVER (ORDER BY monetary_value ASC) AS M_Score
FROM CustomerRFM
ORDER BY monetary_value DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;
GO
