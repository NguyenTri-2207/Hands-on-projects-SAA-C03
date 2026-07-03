# Project 2: Autonomous E-Commerce Deal Hunter

AI agent săn deal trên e-commerce — tìm hàng, thêm giỏ, checkout. Human-in-loop khi gặp CAPTCHA.

**Trạng thái:** Chờ duyệt — làm sau Project 1

## Mục tiêu

- Dashboard quản lý chiến dịch săn deal
- Live timeline: hành động AI đang làm trên browser
- Step Functions: Search → Select → Address → Purchase
- SNS alert khi cần human (CAPTCHA, xác nhận thanh toán)

## AWS Services (dự kiến)

| Service | Vai trò |
|---------|---------|
| Amazon ECS Fargate | Container Playwright chạy lâu |
| AWS Step Functions | Orchestrate purchase flow |
| Amazon Bedrock | Quyết định bước tiếp theo / parse trang |
| Amazon DynamoDB | Campaign state, action log |
| Amazon S3 | Screenshots, artifacts |
| Amazon SNS | Alert email/SMS — human-in-loop |
| (optional) API Gateway + WebSocket | Live timeline tới dashboard |

## Docs

- [ARCHITECTURE.md](docs/ARCHITECTURE.md)
- [PLAN.md](docs/PLAN.md)

## Lưu ý

- **Không recommend** bot trên site thương mại thật trong MVP — dùng mock store hoặc site test
- Chi phí Fargate cao hơn Lambda — cần auto-stop task khi idle
