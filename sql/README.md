# 🗄️ SQL Scripts (Data Warehouse & ETL)

Thư mục này chứa toàn bộ mã nguồn T-SQL (SQL Server) phục vụ cho việc tạo cấu trúc Data Warehouse và xây dựng đường ống nạp dữ liệu (ETL Pipeline).

## 🗂 Danh sách Scripts

1. **`01_create_schema.sql`**: Khởi tạo Database và các bảng Dimension & Fact theo chuẩn Star Schema (Phase 4).
2. **`02_etl_pipeline.sql`**: Thực thi quy trình Extract, Transform, Load (ETL). Đọc dữ liệu từ file Cleaned CSV, xử lý logic (tạo ID sản phẩm) và nạp tự động vào kho dữ liệu (Phase 5).
