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
