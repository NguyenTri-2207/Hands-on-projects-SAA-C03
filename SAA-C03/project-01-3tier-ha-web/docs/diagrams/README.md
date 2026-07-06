# Architecture Diagrams

## Draw.io

| File | Mô tả |
|------|--------|
| [3tier-ha-architecture.drawio](3tier-ha-architecture.drawio) | Sơ đồ kiến trúc chính — import vào [draw.io](https://app.diagrams.net/) |

### Cách mở

1. Vào https://app.diagrams.net/ (hoặc Draw.io desktop)
2. **File → Open from → Device**
3. Chọn `3tier-ha-architecture.drawio`

Hoặc kéo thả file vào trình duyệt.

### Thư viện icon (AWS 2026)

Diagram dùng style `mxgraph.aws4.*` (bộ icon AWS 2026 built-in của draw.io). Khi mở file, nếu icon hiển thị ô vuông trống:

1. **More Shapes** (góc dưới trái) → mục **Networking**
2. Bật **AWS 2026** → **Apply**
3. Đóng/mở lại file nếu cần

### Chỉnh sửa sau khi import

- Export PNG/SVG cho video demo (Act 1 — 30s diagram)
- Đồng bộ CIDR với [ARCHITECTURE.md](../ARCHITECTURE.md) nếu đổi subnet

### Nội dung diagram

- Users → Route 53 → ALB
- VPC 2 AZ: Public / Private / DB subnets
- EC2 (ASG), NAT Gateway, RDS Primary + Standby
- Security Groups legend
- Luồng: load balance, MySQL 3306, sync replication, NAT outbound
