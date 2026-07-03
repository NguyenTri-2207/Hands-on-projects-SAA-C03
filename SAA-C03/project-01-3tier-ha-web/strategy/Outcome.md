# Outcome — Tại sao phải hoàn thành dự án này?

> **Cert chỉ mở cửa. Project này khiến họ mời bạn vào phòng.**

Bạn không build một lab cho vui. Bạn đang đúc **bằng chứng sống** rằng mình làm được — không chỉ đọc được đề SAA-C03.

---

## Sau 7 ngày, bạn cầm trong tay gì?

| Asset | Sức mạnh |
|-------|----------|
| **GitHub repo + CloudFormation** | 1 lệnh = cả hệ thống HA — recruiter nhìn là tin |
| **Video 2 phút** | Kill EC2 → hệ thống tự sống — Upwork client không cần hỏi thêm |
| **Case study LinkedIn** | 500 người thấy bạn *build*, không phải *học* |
| **Trải nghiệm debug thật** | NAT sai, SG sai, RDS timeout — **đề thi và phỏng vấn hỏi đúng chỗ này** |

Không hoàn thành = vẫn là "đang ôn SAA".  
Hoàn thành = **"tôi đã deploy production-like architecture trên AWS."**

---

## 3 giá trị không ai lấy đi được

### 1. Từ "biết lý thuyết" → "đã từng sửa lỗi lúc 2h sáng"

Đề thi: Route 53 Alias, NAT Gateway, Multi-AZ — nghe quen, làm dễ.

Thực tế bạn sẽ dính:
- EC2 private subnet **không pull được package** → Route Table / NAT
- App **timeout RDS** → Security Group inbound
- ALB **502** → Target Group / health check

**Mỗi lỗi fix xong = 1 câu trả lời phỏng vấn tự tin.**  
Đó là khoảng cách giữa người pass cert và Cloud Engineer thật.

### 2. Upwork / Fiverr — thắng bid bằng bằng chứng, không bằng lời hứa

Job: *"Setup AWS environment for my startup"*

| 90% đối thủ | Bạn |
|-------------|-----|
| "I have SAA certification" | GitHub + video: 1 lệnh IaC → HA stack → terminate EC2 → self-heal |

Client không trả tiền cho cert. Client trả tiền cho **giảm rủi ro**. Video 2 phút = rủi ro về zero.

### 3. CV / phỏng vấn — 1 project cover 4 domain SAA

| Domain | Bạn chứng minh bằng |
|--------|---------------------|
| **Networking** | VPC 2 AZ, public/private, NAT |
| **Security** | SG layering ALB → EC2 → RDS |
| **High Availability** | ALB + ASG + RDS Multi-AZ |
| **Operational excellence** | IaC, deploy/teardown, cost estimate |

Recruiter hỏi: *"Bạn có hands-on không?"*  
Bạn gửi link. **Hết câu hỏi.**

---

## Trước vs Sau

| Trước | Sau khi xong project |
|-------|----------------------|
| "Em đang học AWS" | "Em đã deploy 3-tier HA bằng IaC" |
| Sợ câu hỏi troubleshooting | Đã debug NAT, SG, ASG thật |
| Portfolio trống | Repo + video + case study |
| Bid Upwork giá thấp | Bid cao hơn vì có demo |

---

## Cam kết nhỏ — đọc khi muốn bỏ cuộc

```
Ngày 3 khó vì IaC?        → Ngày 7 video sẽ khiến mọi giờ đau đầu đáng giá.
Muốn skip video?          → Đó là phần Upwork trả tiền cho bạn.
Muốn skip teardown?       → $110/tháng NAT + RDS nhắc bạn: FINISH STRONG.
```

**Một lệnh deploy. Một lần kill instance. Một video. Một bài LinkedIn.**  
Bốn thứ đó tách bạn khỏi hàng nghìn người chỉ có badge PDF.

---

## Definition of Done — không dừng ở "chạy được"

- [ ] CloudFormation deploy + teardown reproducible
- [ ] F5 web → thấy Instance ID / AZ đổi
- [ ] Terminate EC2 → site vẫn up, ASG heal
- [ ] Video 2 phút upload + link trong README
- [ ] Case study publish + `portfolio/PROJECT-INDEX` = `demo`

**Tick hết 5 dòng = project DONE. Mở champagne (hoặc teardown stack).**

---

## Liên kết

- Làm gì hôm nay → [timeline.md](timeline.md)
- Deliverable cụ thể → [deliverables.md](deliverables.md)
- Báo giá khách → [CostEstimation.md](CostEstimation.md)

**Bắt đầu Day 1. Không ngày mai.**
