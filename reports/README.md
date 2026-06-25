# 📊 Báo cáo Kiểm toán (Audit Reports)

Thư mục này lưu trữ các tài liệu tổng kết và bảng số liệu phụ trợ (Artifacts) sinh ra sau quá trình dùng Python phân tích chất lượng tập dữ liệu gốc ở Phase 1.

## 1. Tài liệu `data_audit_summary.md`
Đóng vai trò như một "Health Check Report" (báo cáo sức khỏe) cho dataset trước khi bắt tay vào triển khai ETL.

| Nội dung chính | Ý nghĩa thực tiễn |
|---|---|
| **Tổng quan Dữ liệu** | Cung cấp cái nhìn nhanh về quy mô dữ liệu (hơn 51k dòng) và số lượng danh mục. |
| **Thống kê Missing Values**| Quyết định chiến lược xử lý dữ liệu bị thiếu (Imputation vs Deletion). |
| **Quan sát Số liệu (Numeric)**| Đánh giá sơ bộ xem các chỉ số tài chính (Doanh thu, Lợi nhuận) có bị âm hoặc bất hợp lý (Outliers) hay không. |
| **Phân phối Hạng mục (Categorical)**| Nhận định nhanh về cơ cấu khách hàng (Nam/Nữ, Thiết bị mua sắm, Loại đăng nhập). |
| **Action Items** | Đưa ra định hướng làm sạch cụ thể cho Phase 2 (Data Cleaning). |

## 2. Thư mục `data_audit_tables/`
Chứa các bảng số liệu `.csv` tĩnh sinh ra tự động từ Code Python để minh chứng cho các kết luận ở báo cáo trên.
- `missing_values.csv`
- `numeric_summary.csv`
- `categorical_distribution.csv`
- `category_kpi_summary.csv`
- `monthly_revenue.csv`
