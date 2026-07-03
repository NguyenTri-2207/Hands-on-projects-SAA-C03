# Cost Estimation — 3-Tier HA Web

Ước tính **1 tháng hoạt động 24/7** (730 giờ). Region `us-east-1`, **On-Demand**, **không áp dụng Free Tier**.

> **Giả định:** Tài khoản doanh nghiệp (AWS Organizations) — không có 750h EC2/RDS miễn phí. Dùng con số này khi báo giá khách hàng hoặc xin budget nội bộ.

Verify: [AWS Pricing Calculator](https://calculator.aws/)

Kiến trúc: ALB + ASG (2× `t3.micro`) + RDS MySQL + NAT Gateway.

---

## Tổng nhanh (1 tháng — full price)

| Kịch bản | NAT | RDS | **Tổng/tháng** |
|----------|-----|-----|----------------|
| **A — Full HA** | 2 × Multi-AZ | Multi-AZ | **~$135–150** |
| **B — Dev HA** | 1 × Multi-AZ | Multi-AZ | **~$100–110** |
| **C — Single-AZ DB** | 1 | Single-AZ | **~$88–95** |

Quy đổi tham khảo: **~2.5–3.7 triệu VNĐ/tháng** (tỷ giá ~25.000 VNĐ/USD).

> **Cost driver:** NAT Gateway > RDS Multi-AZ > ALB > EC2.

---

## Chi tiết từng dịch vụ (24/7, không Free Tier)

| Dịch vụ | Đơn giá (us-east-1) | / tháng |
|---------|---------------------|---------|
| EC2 `t3.micro` × 2 | ~$0.0104/giờ × 2 × 730h | **~$15** |
| ALB (fixed + LCU thấp) | ~$0.0225/giờ + ~1 LCU | **~$22** |
| RDS `db.t3.micro` Single-AZ | ~$0.017/giờ × 730h + 20GB gp3 | **~$15** |
| RDS `db.t3.micro` **Multi-AZ** | ~×2 compute + 20GB storage | **~$28–30** |
| NAT Gateway × 1 | $0.045/giờ × 730h + data ~$3 | **~$36** |
| NAT Gateway × 2 | ×2 | **~$72** |
| EBS gp3 8GB × 2 | ~$0.08/GB-tháng | **~$1.3** |
| Route 53 Hosted Zone | $0.50/zone | **~$0.50** |
| CloudWatch / logs (tối thiểu) | — | **~$2–5** |
| Data transfer (traffic thấp) | — | **~$2–5** |

*Chưa gồm: thuế, Support plan (Business/Enterprise), domain registration, WAF, ACM (free cert).*

---

## 3 kịch bản — bảng giá khách hàng

### A — Full HA (production-like)

```
2 NAT (1/AZ) + RDS Multi-AZ + ALB + ASG min 2
```

| Hạng mục | $/tháng |
|----------|---------|
| NAT × 2 | $72 |
| RDS Multi-AZ | $29 |
| ALB | $22 |
| EC2 × 2 | $15 |
| EBS + Route 53 + monitoring + transfer | $8 |
| **Tổng** | **~$146** |

Phù hợp: môi trường staging/POC enterprise cần đúng chuẩn HA đa AZ.

### B — Dev / POC HA (khuyến nghị báo giá tối thiểu)

```
1 NAT + RDS Multi-AZ + ALB + ASG min 2
```

| Hạng mục | $/tháng |
|----------|---------|
| NAT × 1 | $36 |
| RDS Multi-AZ | $29 |
| ALB | $22 |
| EC2 × 2 | $15 |
| EBS + khác | $8 |
| **Tổng** | **~$110** |

Trade-off: 1 NAT — mất HA outbound ở cấp NAT (ghi rõ trong proposal).

### C — POC rút gọn (chỉ demo ALB + ASG)

```
1 NAT + RDS Single-AZ + ALB + ASG min 2
```

| Hạng mục | $/tháng |
|----------|---------|
| NAT × 1 | $36 |
| RDS Single-AZ | $15 |
| ALB | $22 |
| EC2 × 2 | $15 |
| EBS + khác | $7 |
| **Tổng** | **~$95** |

Trade-off: không có RDS failover — không đủ cho cam kết RTO database.

---

## Chi phí theo thời gian sử dụng (pro-rata)

Dùng khi stack **không** chạy 24/7 (lab, demo có lịch):

| Thời gian bật/tháng | Kịch bản B (~$110 full) |
|---------------------|-------------------------|
| 730h (24/7) | ~$110 |
| 240h (~8h/ngày × 30) | ~$36 |
| 80h (lab cuối tuần) | ~$12 |
| 0h (teardown) | $0 |

Công thức nhanh: **`$110 × (giờ bật / 730)`** — NAT/RDS/EC2/ALB đều tính theo giờ.

---

## Tối ưu chi phí (enterprise)

| Biện pháp | Tiết kiệm/tháng | Trade-off |
|-----------|-----------------|-----------|
| Stop/destroy stack ngoài giờ làm việc | Pro-rata | Không demo 24/7 |
| 1 NAT thay 2 | ~$36 | NAT không HA |
| RDS Single-AZ | ~$14 | Mất DB failover |
| Reserved Instance / Savings Plan (1 năm) | EC2/RDS −30~40% | Cam kết dài hạn |
| VPC Endpoint S3/Gateway (thay NAT cho AWS API) | Giảm NAT data processing | Phức tạp hơn |
| `t3.small` → giữ `t3.micro` cho POC | — | Đủ cho demo |

**Không khuyến nghị cho production:** ASG min=1, bỏ ALB, public EC2 thay private.

---

## Budget & billing (doanh nghiệp)

| Mục | Khuyến nghị |
|-----|-------------|
| Budget alert POC | **$120–160** (kịch bản A) |
| Budget alert dev HA | **$115** (kịch bản B) |
| Cost allocation tag | `Project=3tier-ha`, `Environment=poc`, `Owner=...` |
| Billing | AWS Cost Explorer + monthly report cho khách |

---

## Teardown

POC xong → destroy stack trước kỳ billing tiếp theo.

```text
ALB → ASG → RDS → NAT GW → VPC
```

---

## Ghi proposal / case study cho khách

- Báo giá **full On-Demand**, không assume Free Tier
- NAT ~**$36/tháng/NAT** — chi phí cố định dù traffic thấp
- RDS Multi-AZ ~**$29/tháng** — justify bằng RTO/RPO SLA
- POC 1 tháng Full HA: budget **~$150 USD** an toàn (buffer monitoring + transfer)
- Teardown sau POC — chi phí về **$0**
