# Project 1: AI-Driven CRM Automation

Chat tiếng Việt → Bedrock hiểu intent → JSON action plan → Playwright tự động thao tác trên CRM giả lập.

**Trạng thái:** Chờ duyệt

## Mục tiêu

- Giao diện Chat (React/Next.js) + trang CRM mock (Login, Form)
- User nhập lệnh tự nhiên: *"Đăng nhập CRM và tạo lead tên Nguyễn Văn A"*
- AI parse → thực thi trên browser headless
- Gửi screenshot về Bedrock để tự sửa khi click sai

## AWS Services (dự kiến)

| Service | Vai trò |
|---------|---------|
| Amazon Bedrock | Intent parsing, action plan JSON, vision |
| AWS Lambda | API + Playwright runner (Docker image) |
| AWS Secrets Manager | CRM credentials |
| Amazon S3 | Lưu screenshots |
| Amazon API Gateway | REST/WebSocket cho chat |
| (optional) DynamoDB | Lịch sử chat / action log |

## Docs

- [ARCHITECTURE.md](docs/ARCHITECTURE.md)
- [PLAN.md](docs/PLAN.md)

## MVP scope (đề xuất)

- [ ] Login CRM
- [ ] Tạo lead mới (fill form)
- [ ] 1–2 lệnh tiếng Việt mẫu
- [ ] Screenshot feedback khi lỗi
