# E-commerce Sales & Customer Behavior Analytics

## Project Overview

This portfolio project analyzes sales performance, customer behavior, profitability, payment methods, and shipping efficiency for an e-commerce business.

The goal is to demonstrate an end-to-end Data Analyst workflow:

- Data Audit
- Data Cleaning
- Data Modeling
- Data Warehouse Design
- ETL Pipeline
- Data Validation
- SQL Analytics
- Business Insights
- Power BI Dashboard

## Current Status

| Phase | Status | Main Deliverables |
|---|---|---|
| Phase 1 - Data Audit | Completed | `notebooks/01_data_audit.ipynb`, `docs/data_dictionary.md`, `reports/data_audit_summary.md` |
| Phase 2 - Data Cleaning | Completed | `notebooks/02_data_cleaning.ipynb` |
| Phase 3 - Data Modeling | Completed | ERD, data model documentation |
| Phase 4 - Data Warehouse | Completed | `sql/01_create_schema.sql` |
| Phase 5 - ETL Pipeline | Not started | ETL SQL scripts |
| Phase 6 - Data Validation | Not started | Validation SQL scripts |
| Phase 7 - SQL Analytics | Not started | Business analysis SQL scripts |
| Phase 8 - Business Insights | Not started | Executive summary and recommendations |
| Phase 9 - Power BI Dashboard | Not started | `.pbix` file and dashboard screenshots |
| Phase 10 - Final Repository | Not started | Final README and complete portfolio documentation |

## Repository Structure

```text
Portfolio/
|-- README.md
|-- E-commerce Dataset.csv
|-- docs/
|   |-- data_dictionary.md
|   `-- github_upload_guide.md
|-- notebooks/
|   `-- 01_data_audit.ipynb
`-- reports/
    |-- data_audit_summary.md
    `-- data_audit_tables/
```

## Phase 1 Summary

Dataset audit results:

| Metric | Value |
|---|---:|
| Rows | 51,290 |
| Columns | 16 |
| Date range | 2018-01-01 to 2018-12-30 |
| Duplicate rows | 0 |
| Unique customers | 38,997 |
| Unique products | 42 |
| Unique product categories | 4 |

Key findings:

- Dataset quality is good enough for portfolio analytics.
- Missing values are minimal but appear in business-critical fields.
- `Payment_method` contains one `not_defined` value.
- Raw data does not contain an `Order_Id`, so a surrogate key will be needed later.
- `Fashion` is the largest product category by revenue and profit.

## GitHub Upload Rule

After each phase, upload only polished files that create portfolio value.

Do upload:

- Completed notebooks
- SQL scripts
- Documentation
- ERD diagrams
- Dashboard screenshots
- Business insight reports

Do not upload:

- Draft notebooks
- Backup files
- Temporary files
- Error screenshots
- Multiple versions of the same dataset
- Test scripts

Detailed guide: [docs/github_upload_guide.md](docs/github_upload_guide.md)

## Phase Upload Checklist

| Phase | Files To Upload | Commit Message |
|---|---|---|
| Phase 1 | `notebooks/01_data_audit.ipynb`, `docs/data_dictionary.md` | `Phase 1 - Data Audit & Data Understanding` |
| Phase 2 | `notebooks/02_data_cleaning.ipynb` | `Phase 2 - Data Cleaning & Feature Engineering` |
| Phase 3 | `images/erd.png`, `docs/data_model.md` | `Phase 3 - Data Modeling & Star Schema Design` |
| Phase 4 | `sql/01_create_schema.sql` | `Phase 4 - Data Warehouse Schema Implementation` |
| Phase 5 | `sql/02_etl_pipeline.sql` | `Phase 5 - ETL Pipeline Development` |
| Phase 6 | `sql/03_data_validation.sql` | `Phase 6 - Data Validation & Quality Assurance` |
| Phase 7 | SQL analytics scripts | `Phase 7 - Business Analytics with SQL` |
| Phase 8 | `reports/executive_summary.md`, `reports/business_recommendations.md` | `Phase 8 - Business Insights & Recommendations` |
| Phase 9 | `dashboard/Ecommerce_Analytics.pbix`, dashboard screenshots | `Phase 9 - Power BI Dashboard Development` |

## How To Review This Project

Start with:

1. `notebooks/01_data_audit.ipynb`
2. `docs/data_dictionary.md`
3. `reports/data_audit_summary.md`

Then follow each phase in order as the project grows.
