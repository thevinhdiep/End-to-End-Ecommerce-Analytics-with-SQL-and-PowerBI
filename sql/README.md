# 🗄️ Mã nguồn SQL (Data Warehouse & ETL Pipeline)

Thư mục này chứa toàn bộ mã nguồn T-SQL (SQL Server) phục vụ cho việc tạo cấu trúc Data Warehouse vật lý và xây dựng đường ống nạp dữ liệu (ETL Pipeline).

## 1. File `01_create_schema.sql` (Thiết kế DWH)
Script này thực hiện việc chuyển đổi cấu trúc từ bảng phẳng (Flat File) sang Star Schema chuẩn 3NF.

| Hạng mục | Chi tiết triển khai trong Script |
|---|---|
| **Khởi tạo Database** | Tạo Cơ sở dữ liệu `EcommerceDB`. |
| **Bảng Dimension (Chiều)** | Tạo 3 bảng con: `dim_customer`, `dim_product`, `dim_date` với các Primary Keys. |
| **Bảng Fact (Sự kiện)** | Tạo bảng trung tâm `fact_sales` chứa các Foreign Keys trỏ tới Dimension và các Metrics tài chính. |
| **Tối ưu Hiệu năng** | Đánh chỉ mục (`NONCLUSTERED INDEX`) trên các Foreign Keys để tăng tốc độ truy vấn JOIN. |

## 2. File `02_etl_pipeline.sql` (Quy trình nạp Dữ liệu ETL)
Thực thi toàn bộ vòng đời Extract - Transform - Load (ETL) bằng T-SQL.

| Quy trình | Kỹ thuật T-SQL áp dụng |
|---|---|
| **1. Extract (E)** | Dùng lệnh `BULK INSERT` để nạp tốc độ cao 51.000+ dòng từ CSV sạch vào bảng tạm `staging_orders`. |
| **2. Transform (T)** | Lọc bản ghi duy nhất (`DISTINCT`) để đẩy vào các Dimension. Sinh mã sản phẩm tự động bằng hàm `ROW_NUMBER() OVER()` vì dữ liệu gốc không có mã ID chuẩn. |
| **3. Load (L)** | `JOIN` bảng Staging với bảng Dimension để lấy mã ID mới sinh, sau đó `INSERT` dữ liệu hoàn chỉnh vào bảng cốt lõi `fact_sales`. |
| **4. Cleanup** | Sử dụng `DROP TABLE staging_orders` để giải phóng bộ nhớ hệ thống sau khi quá trình nạp ETL hoàn tất. |

## 3. File `03_data_validation.sql` (Kiểm tra chất lượng dữ liệu - QA)
Script này đóng vai trò như một bài test (Data Quality Check) để đảm bảo quá trình ETL không xảy ra sai sót.

| Tiêu chí kiểm tra | Kỹ thuật kiểm tra bằng SQL |
|---|---|
| **1. Row Count Check** | Kiểm tra tổng số dòng của bảng `fact_sales` có khớp với 51,290 dòng của file CSV gốc hay không bằng hàm `COUNT(*)`. |
| **2. Referential Integrity** | Dùng `LEFT JOIN` và lọc `IS NULL` để truy tìm các đơn hàng bị mồ côi (Orphan Records), tức là đơn hàng có mã khách hàng hoặc mã sản phẩm nhưng không tìm thấy thông tin tương ứng trong các bảng Dimension. |
| **3. Duplication Check** | Kiểm tra `COUNT(order_id)` so với `COUNT(DISTINCT order_id)` để đảm bảo không bị nhân bản dòng (Duplicated Rows) sau khi ETL. |
| **4. Null & Logic Check** | Đảm bảo các chỉ số quan trọng (`Sales`, `Quantity`) không bị `NULL` và không mang giá trị âm (số lượng, doanh thu phải > 0). |
| **5. Revenue Reconciliation** | Dùng hàm `SUM(sales)` tính lại tổng doanh thu để đối soát (Reconcile) xem có khớp tuyệt đối với con số báo cáo bằng Python ở Phase 1 hay không. |

## 4. File `04_business_analytics.sql` (Phân tích Kinh doanh bằng T-SQL)
Chứa các truy vấn phân tích chuyên sâu (Advanced SQL) dùng để trả lời các câu hỏi kinh doanh chiến lược của bộ phận Sales & Marketing.

| Báo cáo (Insight) | Kỹ thuật T-SQL nâng cao áp dụng |
|---|---|
| **1. YTD Revenue Trend** | Phân tích tốc độ tăng trưởng dòng tiền qua từng tháng. Sử dụng Window Function `SUM() OVER(ORDER BY ... ROWS UNBOUNDED PRECEDING)` để tính doanh thu lũy kế qua từng tháng. |
| **2. Top Customers Ranking** | Truy tìm các khách hàng VIP. Dùng `RANK() OVER` để xếp hạng khách hàng dựa trên mức chi tiêu, kết hợp `OFFSET FETCH` để lấy Top 5 chuẩn xác nhất. |
| **3. Category Profitability** | Đánh giá hiệu suất ngành hàng. Gom nhóm (`GROUP BY`) tính tổng doanh thu, lợi nhuận và dùng biểu thức toán học tính Biên lợi nhuận (Profit Margin %). Dùng `NULLIF()` để bẫy lỗi chia cho 0. |
| **4. Shipping Efficiency** | Kiểm tra hệ thống Logistics. Tính thời gian xử lý trung bình (Average Aging) và dùng cấu trúc `CASE WHEN` trong mệnh đề `ORDER BY` để sắp xếp độ ưu tiên chuẩn xác. |
| **5. RFM Segmentation** | Phân khúc khách hàng tự động bằng SQL. Dùng Common Table Expression (CTE) kết hợp `DATEDIFF` để tính toán khoảng cách mua hàng (Recency). Áp dụng Window Function `NTILE(4)` để chấm điểm RFM động cho khách hàng. |

---

## 5. Kết quả Phân tích (Analytics Results)
*(Thư mục này là nơi bạn trưng bày kết quả chạy code thực tế)*

### Báo cáo 1: Xu hướng Doanh thu hàng tháng & YTD
![YTD_Revenue](../assets/sql_report_1.png)
> 💡 **Key Insight:** Doanh thu tăng trưởng ổn định qua từng tháng. Bắt đầu có dấu hiệu tăng vọt vào quý cuối năm (Mùa lễ hội). Dòng tiền lũy kế (YTD) chứng tỏ doanh nghiệp đang duy trì mức tăng trưởng dương liên tục.

### Báo cáo 2: Xếp hạng Top 5 Khách hàng mang lại Doanh thu cao nhất
![Top_Customers](../assets/sql_report_2.png)
> 💡 **Key Insight:** Định luật 80/20 được thể hiện rõ. Các khách hàng Top đầu (VIP) tuy chiếm số lượng nhỏ nhưng lại tạo ra lượng doanh thu và lợi nhuận khổng lồ. Doanh nghiệp cần lập tức đưa nhóm này vào chương trình chăm sóc đặc biệt (Loyalty Program).
