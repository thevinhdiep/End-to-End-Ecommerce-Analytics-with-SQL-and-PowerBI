# 📂 Dữ liệu dự án (Data Directory)

Thư mục này lưu trữ toàn bộ dữ liệu phục vụ phân tích Thương mại điện tử (E-Commerce), được tổ chức theo hai giai đoạn xử lý: `raw` (dữ liệu thô) và `cleaned` (dữ liệu đã được làm sạch).

## 1. Dữ liệu thô (Raw Data)
Dữ liệu nguyên bản chứa toàn bộ lịch sử giao dịch bán hàng chưa qua bất kỳ bước xử lý nào.

| Thông tin | Chi tiết |
|---|---|
| **File tổng hợp** | `E-commerce Dataset.csv` |
| **Nguồn gốc** | Hệ thống bán hàng giả định (Dạng Kaggle) |
| **Giai đoạn** | Toàn bộ năm 2018 (Tháng 1 - Tháng 12) |
| **Tổng số bản ghi** | 51,290 dòng |
| **Số cột** | 16 |

### Cấu trúc cột (Dữ liệu gốc)
| # | Tên cột | Mô tả |
|---|---|---|
| 1 | `Customer_Id` | Mã định danh khách hàng |
| 2 | `Order_Date` | Ngày đặt hàng |
| 3 | `Time` | Giờ đặt hàng |
| 4 | `Aging` | Thời gian chờ xử lý đơn hàng (ngày) |
| 5 | `Gender` | Giới tính khách hàng |
| 6 | `Device_Type` | Thiết bị sử dụng (Web/Mobile) |
| 7 | `Customer_Login_type`| Loại tài khoản đăng nhập |
| 8 | `Product_Category` | Danh mục sản phẩm |
| 9 | `Product` | Tên sản phẩm cụ thể |
| 10| `Sales` | Doanh thu |
| 11| `Quantity` | Số lượng sản phẩm bán ra |
| 12| `Discount` | Mức giảm giá áp dụng |
| 13| `Profit` | Lợi nhuận thu được |
| 14| `Shipping_Cost` | Chi phí vận chuyển |
| 15| `Order_Priority` | Mức độ ưu tiên của đơn hàng |
| 16| `Payment_method` | Phương thức thanh toán |

## 2. Dữ liệu đã xử lý (Cleaned Data)
Bộ dữ liệu đã qua tiền xử lý, làm sạch và Feature Engineering bằng Python (Pandas) ở Phase 2, sẵn sàng phục vụ nạp vào Data Warehouse thông qua quá trình ETL.

| Thông tin | Chi tiết |
|---|---|
| **File tổng hợp** | `cleaned_ecommerce_dataset.csv` |
| **Phương thức xử lý** | Python (Pandas) |
| **Số lượng cột mới** | Tăng lên 22 cột (đã bổ sung Metrics hỗ trợ BI) |

### Cấu trúc cột (Sau khi làm sạch & Feature Engineering)
Toàn bộ tên cột đã được chuẩn hóa về định dạng `snake_case` để thân thiện với SQL.

| # | Tên cột | Kiểu dữ liệu | Tác dụng / Thay đổi so với gốc |
|---|---|---|---|
| 1 | `order_id` | `VARCHAR` | **(Mới)** Khóa đại diện sinh tự động bằng UUID/Index để quản lý giao dịch. |
| 2 | `order_date` | `DATE` | Đã ép kiểu chuẩn Datetime. |
| 3 | `time` | `VARCHAR` | Giờ đặt hàng. |
| 4 | `aging` | `FLOAT` | Xử lý fill Missing bằng Median. |
| 5 | `customer_id` | `VARCHAR` | Mã khách hàng. |
| 6 | `gender` | `VARCHAR` | Giới tính. |
| 7 | `device_type` | `VARCHAR` | Thiết bị mua sắm. |
| 8 | `customer_login_type`| `VARCHAR` | Hình thức đăng nhập. |
| 9 | `product_category` | `VARCHAR` | Danh mục sản phẩm. |
| 10| `product` | `VARCHAR` | Tên sản phẩm. |
| 11| `sales` | `FLOAT` | Xử lý fill Missing bằng Median. |
| 12| `quantity` | `INT` | Xử lý fill Missing bằng Median. |
| 13| `discount` | `FLOAT` | Xử lý fill Missing bằng Median. |
| 14| `profit` | `FLOAT` | Lợi nhuận. |
| 15| `shipping_cost` | `FLOAT` | Chi phí vận chuyển. |
| 16| `order_priority` | `VARCHAR` | Điền `Unknown` cho giá trị rỗng. |
| 17| `payment_method` | `VARCHAR` | Đổi `not_defined` thành `Unknown` và viết hoa (Title Case). |
| 18| `order_month` | `VARCHAR` | **(Mới)** Rút trích tháng đặt hàng (VD: 2018-01). |
| 19| `order_quarter`| `VARCHAR` | **(Mới)** Rút trích quý đặt hàng (VD: Q1-2018). |
| 20| `order_weekday`| `VARCHAR` | **(Mới)** Rút trích ngày trong tuần. |
| 21| `profit_margin`| `FLOAT` | **(Mới)** Tỷ suất lợi nhuận (`profit / sales`). |
| 22| `shipping_cost_ratio`|`FLOAT`| **(Mới)** Tỷ lệ phí vận chuyển (`shipping_cost / sales`). |
