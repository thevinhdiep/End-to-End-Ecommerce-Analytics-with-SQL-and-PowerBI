# Phase 1 - Data Audit Summary

## 1. Context Setting

Data Audit là bước đầu tiên trong workflow Data Analyst vì nó trả lời câu hỏi: "Mình có thể tin dataset này đến mức nào trước khi phân tích business không?"

Với portfolio E-commerce Sales & Customer Behavior Analytics, bước này giúp chứng minh rằng dashboard và insight phía sau không chỉ đẹp, mà được xây trên dữ liệu đã được kiểm tra về schema, missing values, duplicate records, date coverage, metric validity và categorical consistency.

## 2. Audit Objectives

Mục tiêu của Phase 1:

- Hiểu cấu trúc raw dataset.
- Kiểm tra số dòng, số cột và schema.
- Kiểm tra missing values.
- Kiểm tra duplicate records.
- Kiểm tra date range và khả năng parse ngày.
- Kiểm tra numeric metrics như `Sales`, `Quantity`, `Discount`, `Profit`, `Shipping_Cost`.
- Kiểm tra categorical values như `Product_Category`, `Payment_method`, `Device_Type`, `Order_Priority`.
- Xác định những vấn đề cần xử lý trong Phase 2 - Data Cleaning.

## 3. Dataset Overview

| Metric | Value |
|---|---:|
| Dataset | `E-commerce Dataset.csv` |
| Rows | 51,290 |
| Columns | 16 |
| Date range | 2018-01-01 to 2018-12-30 |
| Duplicate rows | 0 |
| Unique customers | 38,997 |
| Unique products | 42 |
| Unique product categories | 4 |
| Unique payment methods | 5 |

## 4. Raw Schema

| Column | Business Meaning | Expected Type |
|---|---|---|
| `Order_Date` | Ngày đặt hàng | Date |
| `Time` | Giờ đặt hàng | Time/String |
| `Aging` | Thời gian xử lý đơn hàng | Numeric |
| `Customer_Id` | Mã khách hàng | Categorical/ID |
| `Gender` | Giới tính khách hàng | Categorical |
| `Device_Type` | Thiết bị mua hàng | Categorical |
| `Customer_Login_type` | Loại đăng nhập | Categorical |
| `Product_Category` | Danh mục sản phẩm | Categorical |
| `Product` | Tên sản phẩm | Categorical |
| `Sales` | Doanh thu đơn hàng | Numeric |
| `Quantity` | Số lượng sản phẩm | Numeric |
| `Discount` | Tỷ lệ giảm giá | Numeric |
| `Profit` | Lợi nhuận | Numeric |
| `Shipping_Cost` | Chi phí vận chuyển | Numeric |
| `Order_Priority` | Mức độ ưu tiên đơn hàng | Categorical |
| `Payment_method` | Phương thức thanh toán | Categorical |

## 5. Missing Values

Dataset có missing values rất ít, nhưng xuất hiện ở các cột quan trọng cho business analysis.

| Column | Missing Count | Why It Matters |
|---|---:|---|
| `Quantity` | 2 | Ảnh hưởng phân tích volume và average order quantity |
| `Order_Priority` | 2 | Ảnh hưởng phân tích operation/shipping priority |
| `Aging` | 1 | Ảnh hưởng phân tích thời gian xử lý đơn hàng |
| `Sales` | 1 | Ảnh hưởng KPI revenue |
| `Discount` | 1 | Ảnh hưởng phân tích discount impact |
| `Shipping_Cost` | 1 | Ảnh hưởng phân tích shipping efficiency |

Recommended cleaning decision cho Phase 2:

- Với `Sales`, `Quantity`, `Discount`, `Shipping_Cost`: kiểm tra có thể impute theo `Product` hoặc `Product_Category` không. Nếu không chắc, flag row và loại khỏi metric-specific analysis.
- Với `Order_Priority`: fill bằng `"Unknown"` để giữ record cho revenue/profit analysis.
- Với `Aging`: impute median theo `Order_Priority` hoặc `Product_Category` nếu cần phân tích fulfillment.

## 6. Duplicate Check

| Check | Result |
|---|---:|
| Full duplicate rows | 0 |

Interpretation:

Dataset không có duplicated records hoàn toàn. Tuy nhiên, vì raw data không có `Order_Id`, trong Phase 3 cần tạo surrogate key như `order_key` bằng row number hoặc hash key để dùng trong fact table.

## 7. Numeric Summary

| Metric | Count | Missing | Min | Median | Mean | Max | Sum |
|---|---:|---:|---:|---:|---:|---:|---:|
| `Aging` | 51,289 | 1 | 1.00 | 5.00 | 5.26 | 10.50 | 269,525.50 |
| `Sales` | 51,289 | 1 | 33.00 | 133.00 | 152.34 | 250.00 | 7,813,411.00 |
| `Quantity` | 51,288 | 2 | 1.00 | 2.00 | 2.50 | 5.00 | 128,373.00 |
| `Discount` | 51,289 | 1 | 0.10 | 0.30 | 0.30 | 0.50 | 15,582.70 |
| `Profit` | 51,290 | 0 | 0.50 | 59.90 | 70.41 | 167.50 | 3,611,186.60 |
| `Shipping_Cost` | 51,289 | 1 | 0.10 | 6.00 | 7.04 | 16.80 | 361,154.40 |

Key observation:

- `Sales` nằm trong khoảng 33 đến 250, không thấy outlier extreme ở revenue.
- `Profit` không có missing values, tốt cho profitability analysis.
- `Discount` có range 0.10 đến 0.50. Không thấy discount bằng 0 trong raw audit sau numeric conversion.
- `Quantity` nằm trong khoảng 1 đến 5, phù hợp với order-level retail data.

## 8. Categorical Distribution

### Gender

| Value | Rows |
|---|---:|
| Male | 28,138 |
| Female | 23,152 |

### Device Type

| Value | Rows |
|---|---:|
| Web | 47,632 |
| Mobile | 3,658 |

Interpretation:

Web chiếm đa số giao dịch. Đây là một insight tiềm năng cho customer behavior, nhưng cần kiểm tra thêm revenue/profit theo device trong Phase 7.

### Customer Login Type

| Value | Rows |
|---|---:|
| Member | 49,097 |
| Guest | 1,993 |
| First SignUp | 173 |
| New | 27 |

Interpretation:

`Member` áp đảo. Trong Phase 2 nên chuẩn hóa tên cột thành `customer_login_type`. Trong Phase 7 có thể so sánh `Member` vs `Guest` theo revenue per customer.

### Product Category

| Value | Rows |
|---|---:|
| Fashion | 25,646 |
| Home & Furniture | 15,438 |
| Auto & Accessories | 7,505 |
| Electronic | 2,701 |

### Order Priority

| Value | Rows |
|---|---:|
| Medium | 29,433 |
| High | 15,499 |
| Critical | 3,932 |
| Low | 2,424 |
| Missing | 2 |

### Payment Method

| Value | Rows |
|---|---:|
| credit_card | 38,137 |
| money_order | 9,629 |
| e_wallet | 2,789 |
| debit_card | 734 |
| not_defined | 1 |

Recommended cleaning decision:

- Convert payment methods to consistent labels: `Credit Card`, `Money Order`, `E-Wallet`, `Debit Card`, `Unknown`.
- Replace `not_defined` with `Unknown`.

## 9. Category KPI Summary

| Product Category | Orders | Revenue | Profit | Profit Margin | Shipping Cost Ratio |
|---|---:|---:|---:|---:|---:|
| Fashion | 25,646 | 4,345,914.00 | 2,072,623.90 | 47.69% | 4.77% |
| Home & Furniture | 15,438 | 1,975,831.00 | 880,058.90 | 44.54% | 4.46% |
| Auto & Accessories | 7,505 | 1,096,928.00 | 484,313.20 | 44.15% | 4.41% |
| Electronic | 2,701 | 394,738.00 | 174,190.60 | 44.13% | 4.42% |

Early business observation:

Fashion là category lớn nhất theo cả order count, revenue và profit. Tuy nhiên, cần phân tích thêm discount, product mix và customer concentration trước khi đưa recommendation.

## 10. Monthly Revenue Snapshot

| Month | Revenue |
|---|---:|
| 2018-01 | 379,627 |
| 2018-02 | 332,495 |
| 2018-03 | 435,502 |
| 2018-04 | 597,312 |
| 2018-05 | 824,502 |
| 2018-06 | 642,555 |
| 2018-07 | 810,205 |
| 2018-08 | 664,495 |
| 2018-09 | 738,303 |
| 2018-10 | 743,387 |
| 2018-11 | 877,881 |
| 2018-12 | 767,147 |

Early business observation:

Revenue cao nhất ở 2018-11. Đây có thể liên quan đến seasonal demand hoặc promotion period, nhưng cần verify bằng discount trend và category/product mix.

## 11. Data Quality Assessment

Overall quality: Good for portfolio analytics.

Strengths:

- Dataset đủ lớn cho portfolio: hơn 51K rows.
- Không có duplicate rows.
- Date range gần trọn năm 2018.
- Có đủ dimensions quan trọng: customer, product, category, device, login type, payment, order priority.
- Có đủ measures quan trọng: revenue, quantity, discount, profit, shipping cost.

Risks:

- Không có `Order_Id`, cần tạo surrogate `order_key`.
- Missing values ít nhưng nằm ở metric columns.
- `Payment_method` có giá trị `not_defined`.
- Column naming chưa nhất quán: `Customer_Login_type`, `Payment_method`, `Shipping_Cost`.
- Cần xác định rõ `Sales` là line-level revenue hay unit price/order revenue trước khi modeling.

## 12. Advanced Insights

### Mental Model

Hãy nghĩ Data Audit như "pre-flight checklist" trước khi máy bay cất cánh. Dashboard và SQL insight là chuyến bay; nếu schema, missing values và metric definition chưa rõ, insight rất dễ sai hướng.

### Industry Practice

Ở real companies, analyst thường không publish dashboard ngay sau khi load CSV. Họ tạo data validation checks như row count, revenue reconciliation, duplicate check, null check và accepted value check trước.

### Common Pitfall

Một lỗi phổ biến là drop tất cả rows có missing values. Với dataset này, missing rất ít nhưng có `Sales` và `Quantity`. Drop toàn bộ có thể ổn về mặt impact, nhưng portfolio nên giải thích decision rõ ràng để thể hiện business judgment.

### Performance Hack

Với dataset lớn hơn 100K rows, nên dùng vectorized pandas operations như `groupby`, `assign`, `np.where`, thay vì loop qua từng row. Khi data lớn hơn vài triệu rows, chuyển audit summary sang SQL hoặc DuckDB sẽ nhanh hơn.

## 13. Deliverables

Created artifact:

- `notebooks/01_data_audit.py`: Python audit script.
- `reports/data_audit_summary.md`: Phase 1 audit report.

Expected generated tables after running the script:

- `reports/data_audit_tables/missing_values.csv`
- `reports/data_audit_tables/numeric_summary.csv`
- `reports/data_audit_tables/categorical_distribution.csv`
- `reports/data_audit_tables/category_kpi_summary.csv`
- `reports/data_audit_tables/monthly_revenue.csv`
- `reports/data_audit_tables/missing_value_examples.csv`

## 14. Action Items for Phase 2

Practice task:

- Create `notebooks/02_data_cleaning.py`.
- Standardize column names to `snake_case`.
- Convert `order_date` to datetime.
- Convert numeric fields using `pd.to_numeric`.
- Replace `not_defined` payment method with `Unknown`.
- Fill missing `order_priority` with `Unknown`.
- Create `profit_margin`, `shipping_cost_ratio`, `order_month`, `quarter`, `weekday`.
- Export `data/clean_ecommerce.csv`.

Resources:

- pandas missing values: https://pandas.pydata.org/docs/user_guide/missing_data.html
- pandas groupby: https://pandas.pydata.org/docs/user_guide/groupby.html
- pandas time series: https://pandas.pydata.org/docs/user_guide/timeseries.html

Career relevance:

Data Audit xuất hiện trong JD của Data Analyst, BI Analyst và Analytics Engineer dưới các keywords như `data quality checks`, `data validation`, `data profiling`, `data cleaning`, `KPI accuracy`, `dashboard reliability`.
