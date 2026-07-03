# Project 1: 3-Tier Highly Available Web Architecture

> **Dự án này làm gì?** → Xây website trên AWS 3 tầng (Load Balancer → App servers → Database) sao cho **1 server hoặc 1 AZ lỗi, user vẫn truy cập được**.  
> Đọc chi tiết: **[docs/OVERVIEW.md](docs/OVERVIEW.md)**

**Trạng thái:** Chờ triển khai

---

## Tóm tắt

| | |
|---|---|
| **Bài toán** | Web app không được sập khi 1 EC2 chết |
| **Giải pháp** | ALB + Auto Scaling (≥2 EC2) + RDS Multi-AZ trên VPC 2 AZ |
| **Demo** | F5 thấy AZ đổi; kill EC2 → site vẫn chạy |
| **Deploy** | CloudFormation — một lệnh |
| **Mục đích** | SAA-C03 hands-on + portfolio (GitHub, video, case study) |

---

## Luồng đơn giản

```text
User → ALB → EC2 (ASG) → RDS MySQL
         ↑        ↑            ↑
      public   private      private
               2 AZ         Multi-AZ
```

---

## AWS Services

VPC, EC2, ALB, ASG, RDS (Multi-AZ), NAT Gateway, Route 53 (optional)

---

## Docs

| File | Mô tả |
|------|--------|
| [docs/OVERVIEW.md](docs/OVERVIEW.md) | **Mô tả dự án — đọc đầu tiên** |
| [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) | Diagram & thiết kế kỹ thuật |
| [docs/PLAN.md](docs/PLAN.md) | Checklist triển khai |
| [strategy/](strategy/) | Timeline, cost, deliverables, outcome |

---

## SAA-C03 focus

Resilient architectures — load balancing, auto scaling, Multi-AZ, VPC segmentation
