# 📚 Tài liệu Hệ thống (Documentation)

Thư mục này chứa các tài liệu quy chuẩn kỹ thuật (Technical Spec), từ điển dữ liệu (Data Dictionary) và sơ đồ kiến trúc (Architecture) của hệ thống.

## Danh sách Tài liệu

### 1. `data_dictionary.md`
Giải thích chi tiết ý nghĩa nghiệp vụ của từng cột trong file dữ liệu gốc, giúp bất kỳ Data Analyst hoặc Business User nào mới tham gia dự án cũng có thể hiểu ngữ cảnh dữ liệu một cách chuẩn xác.
- Bao gồm: Tên cột, kiểu dữ liệu kỳ vọng và mô tả nghiệp vụ kinh doanh.

### 2. `data_model.md`
Tài liệu cốt lõi giải thích chiến lược thiết kế cơ sở dữ liệu.
- **Lý do thiết kế:** Tại sao lại cần Star Schema thay vì dùng bảng Flat File gốc.
- **Sơ đồ ERD (Entity-Relationship Diagram):** Trực quan hóa cấu trúc bảng Fact (`fact_sales`) bao quanh bởi các bảng Dimension (`dim_customer`, `dim_product`, `dim_date`) sử dụng Mermaid.js.
- **Quyết định kỹ thuật:** Giải thích lý do giữ lại một số trường dữ liệu đặc thù (Degenerate Dimensions) trực tiếp trên bảng Fact thay vì tách ra.

### 3. `github_upload_guide.md`
Cẩm nang quản lý version control nội bộ của dự án.
- Đưa ra các quy tắc nghiêm ngặt về việc "Được upload file nào", "Không được upload file nào".
- Định dạng Commit Message mẫu chuẩn hóa cho từng Phase của dự án nhằm giữ cho Portfolio luôn chuyên nghiệp, sạch sẽ và thân thiện với nhà tuyển dụng.
