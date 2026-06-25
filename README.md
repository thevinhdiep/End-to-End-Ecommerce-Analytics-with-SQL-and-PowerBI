# **🛍️ Phân Tích Dữ Liệu & Hành Vi Khách Hàng E-Commerce (End-to-End Analytics)**

## **🔎 1. Tổng quan dự án (Project Overview)**

Dự án này là một **giải pháp phân tích dữ liệu toàn diện (Full-Stack Data Solution)** cho doanh nghiệp thương mại điện tử dựa trên tập dữ liệu lịch sử năm 2018 (hơn 51,000 đơn hàng). Quy trình triển khai chuyên nghiệp và khép kín qua các trụ cột cốt lõi:

| Trụ cột | 1. Xử lý Dữ liệu (Python) | 2. Xây dựng Data Warehouse | 3. SQL Advanced Analytics | 4. Power BI Dashboard |
| :--- | :--- | :--- | :--- | :--- |
| **Công cụ** | Pandas, Jupyter Notebook | SQL Server, T-SQL, ETL, 3NF | Window Functions, CTE | Power BI, DAX, Data Modeling |

> 💡 **Lưu ý dành cho Nhà tuyển dụng / Technical Reviewer:**
> File `README.md` này đóng vai trò là **Báo cáo tổng quan**. Bạn có thể truy cập chi tiết mã nguồn và tài liệu từng phần thông qua bảng liên kết nhanh dưới đây:

| Phân khu | Mô tả chi tiết | Liên kết nhanh |
| :--- | :--- | :--- |
| **1. Jupyter Notebooks** | File Python làm sạch dữ liệu, kiểm toán chất lượng dữ liệu | [notebooks/](./notebooks/) |
| **2. Kiến trúc & Data Model** | Từ điển dữ liệu, sơ đồ ERD, thiết kế Star Schema | [docs/](./docs/) |
| **3. Báo cáo Data Audit** | Tóm tắt chất lượng dữ liệu ban đầu | [reports/](./reports/) |
| **4. Database & ETL** | Mã SQL tạo Schema 3NF và luồng nạp dữ liệu ETL | [sql/](./sql/) |

---

## **🎯 2. Tiến độ dự án (Current Status)**

| Giai đoạn (Phase) | Trạng thái | Nguồn tài liệu (Deliverables) |
|---|---|---|
| **Phase 1 - Data Audit** | ✅ Hoàn thành | `notebooks/01_data_audit.ipynb`, `docs/data_dictionary.md`, `reports/data_audit_summary.md` |
| **Phase 2 - Data Cleaning** | ✅ Hoàn thành | `notebooks/02_data_cleaning.ipynb` |
| **Phase 3 - Data Modeling** | ✅ Hoàn thành | `docs/data_model.md` (Sơ đồ ERD) |
| **Phase 4 - Data Warehouse** | ✅ Hoàn thành | `sql/01_create_schema.sql` |
| **Phase 5 - ETL Pipeline** | ✅ Hoàn thành | `sql/02_etl_pipeline.sql` |
| **Phase 6 - Data Validation** | ⏳ Chưa bắt đầu | Validation SQL scripts |
| **Phase 7 - SQL Analytics** | ⏳ Chưa bắt đầu | Báo cáo phân tích kinh doanh bằng SQL |
| **Phase 8 - Business Insights**| ⏳ Chưa bắt đầu | Báo cáo khuyến nghị và tổng kết |
| **Phase 9 - Power BI Dashboard**| ⏳ Chưa bắt đầu | File `.pbix` và hình ảnh Dashboard |
| **Phase 10 - Final Repository** | ⏳ Chưa bắt đầu | Cấu trúc lại toàn bộ kho lưu trữ |

---

## **📌 3. Tóm tắt Kiểm toán Dữ liệu (Phase 1 Summary)**

| Chỉ số | Giá trị |
|---|---:|
| **Số dòng** | 51,290 |
| **Số cột** | 16 |
| **Khách hàng Unique** | 38,997 |
| **Danh mục sản phẩm** | 4 |

**Kết quả chính:**
- Dữ liệu đủ tốt để thực hiện các bài toán phân tích.
- Thiếu sót một vài giá trị ở các cột quan trọng (đã được xử lý bằng Median/Unknown ở Phase 2).
- Không có `Order_Id` trong dữ liệu gốc (Đã tạo Surrogate Key tự động ở Phase 2).
- Khách hàng phần lớn đăng nhập dưới dạng Member.

---

## **⚙️ 4. Cấu trúc thư mục (Repository Structure)**

```text
Portfolio/
|-- README.md
|-- data/
|   |-- README.md
|   |-- raw/
|   |   `-- E-commerce Dataset.csv
|   `-- cleaned/
|       `-- cleaned_ecommerce_dataset.csv
|-- docs/
|   |-- README.md
|   |-- data_dictionary.md
|   |-- data_model.md
|   `-- github_upload_guide.md
|-- notebooks/
|   |-- README.md
|   |-- 01_data_audit.ipynb
|   `-- 02_data_cleaning.ipynb
|-- reports/
|   |-- README.md
|   |-- data_audit_summary.md
|   `-- data_audit_tables/
`-- sql/
    |-- README.md
    |-- 01_create_schema.sql
    `-- 02_etl_pipeline.sql
```

---

## **🚀 5. Hướng dẫn Review dự án**

Nếu bạn là nhà tuyển dụng hoặc reviewer, xin vui lòng xem xét dự án theo thứ tự sau:

1. **Khám phá Dữ liệu:** Xem `notebooks/01_data_audit.ipynb` và báo cáo `reports/data_audit_summary.md`.
2. **Làm sạch Dữ liệu:** Xem cách tối ưu ở `notebooks/02_data_cleaning.ipynb`.
3. **Mô hình hóa:** Đọc `docs/data_model.md` để xem tư duy thiết kế Star Schema.
4. **Xây dựng DWH & ETL:** Khảo sát mã SQL tại `sql/01_create_schema.sql` và `sql/02_etl_pipeline.sql`.

*(Các phase tiếp theo đang trong quá trình hoàn thiện...)*
