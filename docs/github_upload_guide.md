# GitHub Upload Guide

## E-commerce Sales & Customer Behavior Analytics

---

# Mục tiêu

Repository này được xây dựng nhằm thể hiện toàn bộ quy trình làm việc của một Data Analyst từ:

* Business Understanding
* Data Cleaning
* Data Modeling
* Database Design
* ETL Pipeline
* Data Validation
* SQL Analytics
* Business Insights
* Dashboard Development

Dự án không tập trung vào việc trình bày Dashboard đơn thuần mà hướng tới mô phỏng quy trình phân tích dữ liệu thực tế trong doanh nghiệp.

---

# Nguyên tắc Upload GitHub

## Chỉ upload những thứ tạo ra giá trị

Nên upload:

* Notebook hoàn chỉnh
* SQL Script hoàn chỉnh
* ERD Diagram
* Dashboard Screenshot
* Documentation
* Business Insights

Không nên upload:

* File test
* File backup
* Dataset nhiều phiên bản
* Notebook nháp
* Screenshot lỗi
* File tạm

---

# Repository Structure

```text
Ecommerce-Sales-Customer-Behavior-Analytics
│
├── README.md
│
├── docs
│   ├── project_overview.md
│   ├── business_requirements.md
│   ├── data_dictionary.md
│   ├── data_model.md
│   └── github_upload_guide.md
│
├── data
│   └── sample_data.csv
│
├── notebooks
│   ├── 01_data_audit.ipynb
│   └── 02_data_cleaning.ipynb
│
├── sql
│   ├── 01_create_schema.sql
│   ├── 02_etl_pipeline.sql
│   ├── 03_data_validation.sql
│   ├── 04_kpi_analysis.sql
│   ├── 05_sales_analysis.sql
│   ├── 06_customer_analysis.sql
│   ├── 07_product_analysis.sql
│   ├── 08_payment_analysis.sql
│   ├── 09_discount_analysis.sql
│   └── 10_advanced_analytics.sql
│
├── dashboard
│   └── Ecommerce_Analytics.pbix
│
├── reports
│   ├── executive_summary.md
│   └── business_recommendations.md
│
├── images
│   ├── architecture.png
│   ├── erd.png
│   ├── dashboard_page1.png
│   ├── dashboard_page2.png
│   ├── dashboard_page3.png
│   ├── dashboard_page4.png
│   └── dashboard_page5.png
│
└── .gitignore
```

---

# Phase 1 — Data Audit

## Mục tiêu

Hiểu cấu trúc dữ liệu và đánh giá chất lượng dữ liệu ban đầu.

## Upload lên GitHub

### notebooks/

```text
01_data_audit.ipynb
```

### docs/

```text
data_dictionary.md
```

Nội dung:

* Column Name
* Data Type
* Business Meaning

---

## Commit Message

```text
Phase 1 - Data Audit & Data Understanding
```

---

# Phase 2 — Data Cleaning

## Mục tiêu

Làm sạch dữ liệu và chuẩn hóa dữ liệu.

## Upload lên GitHub

### notebooks/

```text
02_data_cleaning.ipynb
```

Notebook cần thể hiện:

* Missing Values Analysis
* Duplicate Analysis
* Datetime Conversion
* Feature Engineering
* Data Quality Fixes

---

## Không Upload

```text
clean_v1.csv
clean_v2.csv
clean_v3.csv
```

---

## Commit Message

```text
Phase 2 - Data Cleaning & Feature Engineering
```

---

# Phase 3 — Data Modeling

## Mục tiêu

Thiết kế mô hình dữ liệu phục vụ phân tích.

## Upload lên GitHub

### images/

```text
erd.png
```

### docs/

```text
data_model.md
```

Nội dung:

* Fact Table
* Dimension Tables
* Relationships
* Business Logic

---

## Commit Message

```text
Phase 3 - Data Modeling & Star Schema Design
```

---

# Phase 4 — Data Warehouse

## Mục tiêu

Xây dựng cấu trúc cơ sở dữ liệu.

## Upload lên GitHub

### sql/

```text
01_create_schema.sql
```

Bao gồm:

* Create Database
* Create Fact Table
* Create Dimension Tables
* Primary Keys
* Foreign Keys

---

## Commit Message

```text
Phase 4 - Data Warehouse Schema Implementation
```

---

# Phase 5 — ETL Pipeline

## Mục tiêu

Nạp dữ liệu từ Raw Layer sang Data Warehouse.

## Upload lên GitHub

### sql/

```text
02_etl_pipeline.sql
```

Bao gồm:

### Customer Dimension Load

```sql
INSERT INTO dim_customer
```

### Product Dimension Load

```sql
INSERT INTO dim_product
```

### Payment Dimension Load

```sql
INSERT INTO dim_payment
```

### Date Dimension Load

```sql
INSERT INTO dim_date
```

### Fact Table Load

```sql
INSERT INTO fact_orders
```

---

## Commit Message

```text
Phase 5 - ETL Pipeline Development
```

---

# Phase 6 — Data Validation

## Mục tiêu

Kiểm tra tính chính xác của dữ liệu sau ETL.

## Upload lên GitHub

### sql/

```text
03_data_validation.sql
```

Bao gồm:

### Revenue Validation

Raw Revenue = Fact Revenue

### Profit Validation

Raw Profit = Fact Profit

### Customer Validation

Distinct Customer Count

### Product Validation

Distinct Product Count

### Row Count Validation

Raw Row Count = Fact Row Count

---

## Commit Message

```text
Phase 6 - Data Validation & Quality Assurance
```

---

# Phase 7 — SQL Analytics

## Mục tiêu

Thực hiện các bài phân tích kinh doanh.

---

## Upload

### sql/

```text
04_kpi_analysis.sql
```

Bao gồm:

* Total Revenue
* Total Profit
* Profit Margin
* Total Orders
* Total Customers

---

### sql/

```text
05_sales_analysis.sql
```

Bao gồm:

* Revenue Trend
* Monthly Revenue
* Quarterly Revenue
* MoM Growth

---

### sql/

```text
06_customer_analysis.sql
```

Bao gồm:

* Top Customers
* Customer Segmentation
* Gender Analysis
* Device Analysis

---

### sql/

```text
07_product_analysis.sql
```

Bao gồm:

* Top Products
* Bottom Products
* Revenue by Category
* Profit by Category

---

### sql/

```text
08_payment_analysis.sql
```

Bao gồm:

* Revenue by Payment Method
* Payment Share
* Profit by Payment Method

---

### sql/

```text
09_discount_analysis.sql
```

Bao gồm:

* Discount vs Revenue
* Discount vs Profit
* Discount Impact Analysis

---

### sql/

```text
10_advanced_analytics.sql
```

Bao gồm:

* CTE
* Window Functions
* LAG
* RANK
* DENSE_RANK
* Pareto Analysis
* Running Total

---

## Commit Message

```text
Phase 7 - Business Analytics with SQL
```

---

# Phase 8 — Business Insights

## Mục tiêu

Chuyển kết quả phân tích thành hành động kinh doanh.

## Upload lên GitHub

### reports/

```text
executive_summary.md
```

### reports/

```text
business_recommendations.md
```

Mỗi insight nên gồm:

1. Observation
2. Reason
3. Business Impact
4. Recommendation

---

## Commit Message

```text
Phase 8 - Business Insights & Recommendations
```

---

# Phase 9 — Power BI Dashboard

## Mục tiêu

Trực quan hóa dữ liệu phục vụ ra quyết định.

## Upload lên GitHub

### dashboard/

```text
Ecommerce_Analytics.pbix
```

### images/

```text
dashboard_page1.png
dashboard_page2.png
dashboard_page3.png
dashboard_page4.png
dashboard_page5.png
```

---

## Commit Message

```text
Phase 9 - Power BI Dashboard Development
```

---

# Phase 10 — Final Repository

## README phải trả lời được

### Business Problem

Doanh nghiệp đang gặp vấn đề gì?

### Dataset

Nguồn dữ liệu là gì?

### Data Architecture

Dữ liệu đi qua những bước nào?

### Data Model

Fact và Dimension gồm những gì?

### ETL Process

Dữ liệu được xử lý như thế nào?

### SQL Analytics

Các phân tích chính đã thực hiện.

### Dashboard

Các trang dashboard và mục tiêu của từng trang.

### Key Insights

5–10 insight quan trọng nhất.

### Business Recommendations

Những đề xuất hành động dựa trên dữ liệu.

---

# Những thứ không nên xuất hiện trong GitHub

```text
test.sql
query_v2.sql
query_v3.sql

draft.pbix

temp.ipynb

dataset_backup.csv

old_dataset.csv

notes.docx

screenshot_error.png
```

---

# Tiêu chí đánh giá Repository Hoàn Chỉnh

Checklist:

☑ Business Problem

☑ Data Audit

☑ Data Cleaning

☑ Data Modeling

☑ Star Schema

☑ SQL Scripts

☑ ETL Pipeline

☑ Data Validation

☑ SQL Analytics

☑ Business Insights

☑ Power BI Dashboard

☑ README Documentation

☑ Professional Folder Structure

Nếu hoàn thành toàn bộ checklist trên, repository sẽ thể hiện đầy đủ quy trình Data Analytics End-to-End thay vì chỉ là một Dashboard Project đơn thuần.
