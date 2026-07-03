# Timeline — 3-Tier HA Web (14 ngày)

> **Nguyên tắc:** Diagram & docs trước → Console học → IaC → Test → Showcase cuối.  
> Video quay **sau khi IaC ổn định**, không quay bản click-console.

---

## Day 0 — Design trước khi build ⭐

| Task                                | Output                                                   |
| ----------------------------------- | -------------------------------------------------------- |
| Vẽ architecture diagram v1          | `docs/ARCHITECTURE.md` (Mermaid) hoặc Draw.io export PNG |
| Chốt danh sách services + SG flow   | Ghi trong ARCHITECTURE                                   |
| Viết video script / storyboard nháp | 3 act: diagram → deploy → chaos                          |
| Outline case study (bullet)         | Problem / Solution / Trade-off / Lesson learned          |
| Setup AWS: budget alert, region     | Checklist trong notebook                                 |

**Vì sao làm trước:** Diagram sai sớm = build sai hết. Case study + video có khung sẵn, cuối project chỉ điền kết quả thật.

| Task | Done |
| ---- | ---- |

## Days 1–3 — Mạng & Compute (Console, học concept)

## Days 4–5 — Data & App layer

| VPC + 6 subnets (2 AZ: public / private / DB) | [ ] |
| IGW + 2 NAT GW (1/AZ) + route tables | [ ] |
| SG layering: ALB → Web → DB (draft) | [ ] |
| EC2 + User Data: hiển thị **Instance ID + AZ** | [ ] |
| ALB + Target Group + health check | [ ] |
| ASG (min 2, max 4) gắn private subnets | [ ] |
| Test F5: thấy AZ-a / AZ-b đổi nhau | [ ] |

**Chưa cần:** RDS, domain, IaC.
| Cập nhật diagram v2 (khớp thực tế) | [ ] |

---

## Days 4–5 — Data & App layer

## Days 6–8 — IaC (bước nâng tầm portfolio)

| Task | Done |
| DB subnet group + RDS MySQL Multi-AZ | [ ] |
| SG DB: chỉ port 3306 từ Web-SG | [ ] |
| App đọc/ghi RDS (`src/` — Node hoặc Python) | [ ] |
| IAM role EC2 (SSM, không SSH key nếu được) | [ ] |
| Cập nhật diagram v2 (khớp thực tế) | [ ] |

**Lưu ý:** Video final phải show IaC deploy — đoạn này quay sẵn 60s footage.

## Days 6–8 — IaC (bước nâng tầm portfolio)

## Days 9–11 — Test, DNS & ổn định demo

| Code CloudFormation (khớp repo convention) | [ ] |
| `deploy.sh` + `teardown.sh` | [ ] |
| Destroy stack click-console → deploy lại **chỉ bằng IaC** | [ ] |
| README: hướng dẫn deploy 1 lệnh | [ ] |
| Dry-run: ghi lại màn hình deploy (footage cho video) | [ ] |

**Lưu ý:** Video final phải show IaC deploy — đoạn này quay sẵn 60s footage.
| ACM + HTTPS trên ALB (optional) | [ ] |
| Ghi chú metric: downtime khi failover (cho case study) | [ ] |
| Chạy thử **toàn bộ video script** 1 lần (không edit) | [ ] |

## Days 9–11 — Test, DNS & ổn định demo

---

| Chaos: Terminate 1 EC2 → ASG self-heal | [ ] |
| RDS failover test (manual reboot with failover) | [ ] |
| Route 53 alias → ALB (domain hoặc subdomain test) | [ ] |
| ACM + HTTPS trên ALB (optional) | [ ] |
| Ghi chú metric: downtime khi failover (cho case study) | [ ] |
| Chạy thử **toàn bộ video script** 1 lần (không edit) | [ ] |
| Cập nhật `docs/PLAN.md` checklist | [ ] |
|------|------|
| Diagram v3 (đẹp): Draw.io / CloudCraft — dùng trong video + case study | [ ] |
| Polish `ARCHITECTURE.md`, `README.md` | [ ] |

## Days 12–14 — Showcase (Marketing)

### Day 12 — Diagram & docs final

### Day 13 — Video

| Diagram v3 (đẹp): Draw.io / CloudCraft — dùng trong video + case study | [ ] |
| Polish `ARCHITECTURE.md`, `README.md` | [ ] |
| Viết `showcase.md` (1 trang client-facing) | [ ] |
| Edit + nhạc / voice EN (optional) | [ ] |

### Day 13 — Video

### Day 14 — Case study & publish

| Quay theo storyboard (CapCut / Camtasia) | [ ] |
| Act 1 (30s): diagram | [ ] |
| Act 2 (60s): IaC deploy + web F5 Instance/AZ | [ ] |
| Act 3 (30s): terminate EC2 + ASG heal | [ ] |
| Edit + nhạc / voice EN (optional) | [ ] |
| Upload unlisted YouTube + link vào README | [ ] |

### Day 14 — Case study & publish

## Checklist đồng bộ 3 file

| Viết case study LinkedIn/Medium (800–1200 từ) | [ ] |
| Nội dung: SG layering, HA, chaos test kết quả, cost | [ ] |
|-------|------|
| Cập nhật `portfolio/cv-bullets.md` | [ ] |
| **Teardown** AWS hoặc stop instances — tránh phí | [ ] |
| Lịch theo ngày | `strategy/timeline.md` (file này) |

---

## Checklist đồng bộ 3 file

| Nguồn                                                         | File                              |
| ------------------------------------------------------------- | --------------------------------- | ----------------------------- | ---- | -------- |
| Kỹ thuật chi tiết                                             | `docs/PLAN.md`                    |
| Đầu ra marketing                                              | `strategy/deliverables.md`        |
| Lịch theo ngày                                                | `strategy/timeline.md` (file này) | ## Đánh giá nhanh timeline cũ | Điểm | Đánh giá |
| ------                                                        | ----------                        |
| Console → IaC → Test → Marketing                              | Hợp lý                            |
| 14 ngày part-time                                             | Vừa đủ                            |
| Thiếu Day 0 diagram                                           | Đã bổ sung                        |
| Thiếu case study riêng                                        | Đã thêm Day 14                    |
| Thiếu ASG/NAT trong days 1–3                                  | Đã bổ sung                        |
| Thiếu dry-run video trước khi quay                            | Đã thêm Day 11                    |
| Video days 12–14 only 3 ngày cho cả video + case study + docs | Tách Day 12/13/14                 |
