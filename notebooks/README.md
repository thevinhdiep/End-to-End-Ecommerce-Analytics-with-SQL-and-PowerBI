# 📓 Mã nguồn Python (Jupyter Notebooks)

Thư mục này chứa mã nguồn Python (thư viện Pandas, Numpy) thực hiện quá trình Khám phá dữ liệu (Exploratory Data Analysis - EDA), Kiểm toán và Làm sạch dữ liệu.

## 1. File `01_data_audit.ipynb`
**Mục tiêu:** Kiểm toán chất lượng của tập dữ liệu thô (Raw Data).

| Hoạt động | Mô tả chi tiết |
|---|---|
| **Kiểm tra Cấu trúc** | Phân tích số lượng dòng, cột và kiểu dữ liệu ban đầu. |
| **Kiểm tra Missing Values**| Quét các cột bị thiếu dữ liệu (ví dụ `Quantity`, `Sales`, `Order_Priority`). |
| **Kiểm tra Duplicates** | Đảm bảo không có các bản ghi trùng lặp (Duplicate rows). |
| **Phân tích Phân phối** | Khám phá các metrics bằng Descriptive Statistics (Min, Max, Mean, Median). |
| **Xuất báo cáo** | Sinh ra các bảng CSV lưu trong `reports/data_audit_tables/` để đối chiếu. |

## 2. File `02_data_cleaning.ipynb`
**Mục tiêu:** Tiền xử lý, chuẩn hóa và Kỹ thuật Đặc trưng (Feature Engineering).

| Hoạt động | Mô tả chi tiết |
|---|---|
| **Chuẩn hóa tên cột** | Chuyển mọi cột sang định dạng `snake_case` để đồng bộ hoàn toàn với SQL. |
| **Xử lý Missing Data** | Điền các cột số (`Sales`, `Quantity`...) bằng giá trị Median; Điền các cột chuỗi bằng `Unknown`. |
| **Tạo Surrogate Key** | Khởi tạo cột `order_id` do file gốc không có mã định danh giao dịch. |
| **Làm sạch Outliers** | Chuyển giá trị `not_defined` trong `payment_method` thành chuẩn `Unknown` và định dạng chữ hoa đầu dòng (Title Case). |
| **Feature Engineering** | Tạo thêm các cột hỗ trợ BI Dashboard sau này như: `order_month`, `order_quarter`, `profit_margin`, `shipping_cost_ratio`. |
| **Xuất file** | Lưu kết quả dưới dạng `cleaned_ecommerce_dataset.csv` trong thư mục `data/cleaned/`. |
