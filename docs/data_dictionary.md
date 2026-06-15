# Data Dictionary

## E-commerce Sales & Customer Behavior Analytics

File nguồn: `E-commerce Dataset.csv`

Phase: `Phase 1 - Data Audit & Data Understanding`

## Column Definitions

| Column Name | Expected Type | Business Meaning | Audit Notes |
|---|---|---|---|
| `Order_Date` | Date | Ngày đặt hàng | Parse được thành date, date range từ 2018-01-01 đến 2018-12-30 |
| `Time` | Time/String | Giờ đặt hàng | Có thể dùng để phân tích order behavior theo thời điểm trong ngày |
| `Aging` | Numeric | Thời gian xử lý đơn hàng | Có 1 missing value |
| `Customer_Id` | ID/Categorical | Mã định danh khách hàng | Có 38,997 unique customers |
| `Gender` | Categorical | Giới tính khách hàng | Gồm `Male`, `Female` |
| `Device_Type` | Categorical | Thiết bị khách hàng dùng khi mua hàng | Gồm `Web`, `Mobile` |
| `Customer_Login_type` | Categorical | Loại đăng nhập của khách hàng | Gồm `Member`, `Guest`, `First SignUp`, `New` |
| `Product_Category` | Categorical | Danh mục sản phẩm | Gồm 4 categories |
| `Product` | Categorical | Tên sản phẩm | Có 42 unique products |
| `Sales` | Numeric | Doanh thu ghi nhận trên order line | Có 1 missing value |
| `Quantity` | Numeric | Số lượng sản phẩm | Có 2 missing values |
| `Discount` | Numeric | Tỷ lệ giảm giá | Có 1 missing value |
| `Profit` | Numeric | Lợi nhuận | Không có missing value |
| `Shipping_Cost` | Numeric | Chi phí vận chuyển | Có 1 missing value |
| `Order_Priority` | Categorical | Mức độ ưu tiên đơn hàng | Có 2 missing values |
| `Payment_method` | Categorical | Phương thức thanh toán | Có 1 giá trị `not_defined` |

## Key Data Quality Notes

- Dataset có 51,290 rows và 16 columns.
- Không có duplicate rows.
- Missing values rất ít, nhưng xuất hiện ở các metric quan trọng như `Sales`, `Quantity`, `Discount`, `Shipping_Cost`.
- Raw dataset chưa có `Order_Id`, nên Phase 3 cần tạo surrogate key như `order_key`.
- Column naming chưa nhất quán, cần chuẩn hóa trong Phase 2.

## Cleaning Decisions To Review In Phase 2

- Chuẩn hóa column names sang `snake_case`.
- Convert `Order_Date` sang datetime.
- Convert numeric fields bằng `pd.to_numeric`.
- Replace `Payment_method = not_defined` thành `Unknown`.
- Fill missing `Order_Priority` bằng `Unknown`.
- Với missing numeric fields, quyết định impute hay flag dựa trên business rule.
