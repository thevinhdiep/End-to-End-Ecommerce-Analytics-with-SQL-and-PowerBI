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
