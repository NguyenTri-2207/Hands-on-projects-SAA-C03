# Sample Financial Reports

Thư mục chứa dữ liệu mẫu để test Financial Audit Agent. **Chỉ dùng dummy data — không commit dữ liệu tài chính thật.**

## Files

| File | Mô tả | Phase sử dụng |
|------|-------|---------------|
| `sample-report.json` | Báo cáo mẫu đầy đủ (line items + ratios + prior period) | Phase 2a, 3, 4 |

## Cách tạo dummy data

### Option 1: Dùng sample có sẵn

```bash
# Upload trực tiếp JSON (bypass extract trong Phase 2a)
aws s3 cp sample-report.json s3://<INPUT_BUCKET>/uploads/test-001/sample-report.json
```

### Option 2: Tạo Excel mẫu (Phase 2b)

Tạo file `dummy-Q4-2025.xlsx` với 2 sheets:

**Sheet "Income Statement":**

| Line Item | Value (USD) |
|-----------|-------------|
| Product Revenue | 1,200,000 |
| Service Revenue | 300,000 |
| Total Revenue | 1,500,000 |
| Net Income | 250,000 |

**Sheet "Balance Sheet":**

| Line Item | Value (USD) |
|-----------|-------------|
| Current Assets | 800,000 |
| Current Liabilities | 533,333 |
| Total Equity | 2,000,000 |

> **Cố ý đặt discrepancy:** Current Ratio thực = 800000/533333 = 1.50, nhưng `reportedRatios.current_ratio` trong JSON = 1.48 → agent sẽ phát hiện material finding.

### Option 3: Tạo CSV đơn giản

```csv
id,category,label,value,parentId
rev-total,Income Statement,Total Revenue,1500000,
rev-product,Income Statement,Product Revenue,1200000,rev-total
rev-service,Income Statement,Service Revenue,300000,rev-total
```

## Discrepancies có sẵn trong sample-report.json

Dùng để verify agent hoạt động đúng:

| Check | Expected result |
|-------|-----------------|
| `reconcile_line_items` (rev-total) | PASS — 1.2M + 0.3M = 1.5M |
| `calculate_financial_ratio` (current_ratio) | FAIL — calculated 1.50 vs reported 1.48 |
| `cross_validate_periods` (revenue) | PASS — +7.14% YoY |

## Git ignore

File `.xlsx`, `.pdf`, `.csv` thật bị ignore bởi `.gitignore`. Chỉ `sample-report.json` và `README.md` được commit.

## Lưu ý bảo mật

- Không dùng báo cáo tài chính thật của công ty
- Không dùng tên công ty / người thật
- Nếu cần test realistic hơn, randomize số liệu từ sample có sẵn
