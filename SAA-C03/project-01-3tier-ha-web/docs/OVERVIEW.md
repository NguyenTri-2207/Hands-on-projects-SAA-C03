# Overview — Dự án này làm gì?

## Một câu

Xây **website chạy trên AWS** theo mô hình **3 tầng**, chịu lỗi được (high availability): khi 1 server chết, user **vẫn truy cập bình thường**.

---

## Bối cảnh (bài toán)

Một startup có web app đơn giản (hiển thị thông tin, kết nối database). Ban đầu chạy **1 con EC2** — server hỏng là **sập toàn bộ**.

Yêu cầu:
- Traffic internet vào ổn định
- Nhiều app server phía sau, tự thay thế khi hỏng
- Database không mất dữ liệu khi sự cố ở 1 data center (AZ)

**Dự án này giải bài toán đó trên AWS** — dùng cho học SAA-C03 và làm portfolio.

---

## Hệ thống gồm những gì?

```text
Internet
   ↓
Route 53 (domain — optional)
   ↓
Application Load Balancer     ← Tầng 1: Web (public)
   ↓
EC2 × 2+ (Auto Scaling Group) ← Tầng 2: App (private)
   ↓
RDS MySQL Multi-AZ            ← Tầng 3: Database (private)
```

| Tầng | AWS service | Vai trò |
|------|-------------|---------|
| **Web** | ALB | Nhận HTTP, phân tải, health check |
| **App** | EC2 + ASG | Chạy web app, tự scale / tự heal |
| **Data** | RDS Multi-AZ | Lưu dữ liệu, failover sang AZ dự phòng |

Thêm: **VPC** (mạng riêng), **NAT Gateway** (EC2 private ra internet tải patch), **Security Groups** (firewall từng tầng).

---

## User thấy gì khi demo?

1. Mở URL (ALB hoặc domain) → thấy trang web
2. Trang hiển thị **Instance ID** và **Availability Zone** (vd. `us-east-1a`)
3. **F5 liên tục** → ID/AZ đổi → chứng minh ALB đang cân bằng tải
4. (Optional) Form đọc/ghi dữ liệu từ RDS — chứng minh 3-tier end-to-end

**Chaos demo (video portfolio):**  
Admin terminate 1 EC2 trên Console → trang web **vẫn mở được** → vài phút sau ASG tạo server mới.

---

## Bạn (developer) làm gì trong project?

| Việc | Mô tả |
|------|--------|
| Thiết kế mạng | VPC 2 AZ, subnet public/private/database |
| Deploy hạ tầng | CloudFormation — **1 lệnh**, không click Console |
| Viết app nhỏ | Web server + (optional) kết nối MySQL |
| Test HA | Kill EC2, test RDS failover |
| Đóng gói | Video 2 phút + case study + GitHub repo |

---

## Đầu ra cuối cùng (deliverables)

| Loại | Cụ thể |
|------|--------|
| **Kỹ thuật** | Repo GitHub: IaC + app + docs |
| **Demo** | Video: deploy → F5 → kill instance → self-heal |
| **Marketing** | Case study LinkedIn, `showcase.md` cho khách |

Chi tiết: [strategy/deliverables.md](../strategy/deliverables.md)

---

## Dự án này **không** phải

- Production app phức tạp (microservices, K8s)
- SaaS multi-tenant
- Ứng dụng mobile / frontend fancy

## Dự án này **là**

- **Bằng chứng hands-on** bạn thiết kế và vận hành được kiến trúc AWS chuẩn enterprise POC
- Nền tảng cho phỏng vấn, Upwork, và thi SAA-C03 (domain Resilient + Secure)

---

## Docs liên quan

| File | Nội dung |
|------|----------|
| [ARCHITECTURE.md](ARCHITECTURE.md) | Diagram chi tiết, subnet CIDR |
| [PLAN.md](PLAN.md) | Checklist kỹ thuật từng phase |
| [strategy/timeline.md](../strategy/timeline.md) | Lịch 7–14 ngày |
| [strategy/Outcome.md](../strategy/Outcome.md) | Tại sao nên hoàn thành |
| [strategy/CostEstimation.md](../strategy/CostEstimation.md) | Chi phí/tháng (enterprise) |
