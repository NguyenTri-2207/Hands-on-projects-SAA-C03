# Deliverables — 3-Tier HA Web

Đầu ra dự án chia **2 nhóm**: sản phẩm kỹ thuật và tài liệu quảng bá.

---

## 1. Product Artifacts (Kỹ thuật)

### GitHub Repository

| Thư mục | Nội dung |
|---------|----------|
| `docs/` | `PLAN.md`, `ARCHITECTURE.md` |
| `infrastructure/` | CloudFormation — deploy 1 lệnh, **không click Console** |
| `src/` | Web app đơn giản (Node.js/Python) kết nối RDS, chứng minh 3-tier hoạt động thật |

### Live Demo (optional — điểm cộng lớn)

- Domain thật qua Route 53 → ALB → hệ thống

### Checklist

- [ ] IaC deploy end-to-end
- [ ] App đọc/ghi RDS
- [ ] Hiển thị Instance ID + AZ khi refresh
- [ ] Teardown script / hướng dẫn xóa resource

---

## 2. Showcase Artifacts (Quảng bá)

### Video demo (1.5–3 phút)

| Phần | Thời lượng | Nội dung |
|------|------------|----------|
| Kiến trúc | 30s | Diagram (Mermaid / Draw.io / CloudCraft) |
| Deploy + demo | 60s | IaC deploy + web hiển thị Instance ID / AZ khi F5 |
| Chaos test | 30s | Terminate 1 EC2 → ASG self-heal + RDS failover |

### Kịch bản quay chi tiết

1. Show màn hình CloudFormation và chạy lệnh deploy (`aws cloudformation deploy` hoặc script).
2. Mở web, **F5 liên tục** — Instance ID / AZ thay đổi giữa `AZ-a` và `AZ-b` (chứng minh ALB).
3. Vào Console **Terminate** 1 EC2 → web vẫn chạy → ASG tạo instance mới (self-healing).
4. (Optional) Demo RDS Multi-AZ failover.

### Case study (LinkedIn / Medium)

- Security Group layering (ALB → EC2 → RDS)
- High Availability: Multi-AZ, ALB, ASG
- Cost: `t3.micro` free tier, teardown khi không dùng

### Checklist

- [ ] Video quay xong, upload (YouTube unlisted / portfolio)
- [ ] Case study publish
- [ ] Cập nhật `portfolio/PROJECT-INDEX.md` → status `demo`
- [ ] Viết `showcase.md` 1 trang cho khách hàng

---

## 3. Pitch — 5 phút (Recruiter / Upwork / Khách)

### Elevator pitch (30s)

> "Tôi xây web 3 tầng highly available trên AWS: VPC 2 AZ, ALB phân tải, Auto Scaling tự heal khi instance chết, RDS Multi-AZ failover. Toàn bộ deploy bằng CloudFormation một lệnh — không setup tay trên Console."

### Cấu trúc present (3 phút)

| Bước | Nội dung |
|------|----------|
| **Problem** | Web single-instance: downtime khi EC2 chết, không scale khi traffic tăng |
| **Solution** | 3-tier: public ALB → private ASG → RDS Multi-AZ, 2 AZ |
| **Trade-off** | ALB (L7) vs NLB; Multi-AZ RDS (cost) vs Single-AZ (risk) |
| **Demo** | F5 thấy AZ đổi + terminate EC2 → hệ thống vẫn sống |

### Theo đối tượng

| Người nghe | Nhấn mạnh |
|------------|-----------|
| **Recruiter AWS** | SAA-C03 resilient domain, IaC, không click-console |
| **Upwork client** | Deploy nhanh, HA sẵn sàng, có video chứng minh |
| **Technical interviewer** | SG layering, health check, ASG policy, RDS failover |

### Câu hỏi thường gặp — gợi ý trả lời

**Tại sao ALB mà không NLB?**
→ Cần L7 routing + health check HTTP cho web app.

**EC2 chết thì sao?**
→ ALB route sang instance còn sống; ASG launch instance mới.

**RDS AZ primary down?**
→ Multi-AZ automatic failover sang standby (vài phút).

**Chi phí?**
→ Dev dùng `t3.micro` + teardown; prod scale theo ASG.

### Đóng (30s)

> "Repo có IaC, architecture doc và video demo chaos test. Phù hợp nếu team cần baseline HA trước khi mở rộng microservices hoặc DR cross-region."

### Checklist trước khi pitch

- [ ] Demo chạy được hoặc có video backup
- [ ] Không lộ Account ID / credentials trên slide
- [ ] Sẵn sàng teardown sau demo live

### Gửi sau meeting

1. Link GitHub (folder project này)
2. `docs/ARCHITECTURE.md` hoặc export diagram
3. Link video demo
4. (Optional) CV 1 trang
