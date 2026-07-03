# Project 3: AI-Powered DevOps & Automated Testing Agent

AI Bot tích hợp Git workflow — tự review code, phát hiện security issues, sinh Cypress test khi có Pull Request.

## Trạng thái

**Skeleton** — mở rộng sau khi hoàn thành Project 1.

## Mục tiêu

- Tự động review PR: security vulnerabilities, code smells
- Sinh file test Cypress/Katalon cho features mới
- Comment kết quả trực tiếp lên PR
- Thông báo team qua SNS → Slack/Teams

## AWS Services

| Service | Vai trò |
|---------|---------|
| AWS CodePipeline | CI/CD orchestration |
| AWS CodeBuild | Build + gọi Bedrock review |
| Amazon Bedrock (Claude) | Code analysis + test generation |
| Amazon SNS | Notification → Slack/Teams |
| (Alt) GitHub Actions | Thay CodePipeline nếu prefer |

## Docs

- [ARCHITECTURE.md](docs/ARCHITECTURE.md) — System design outline
- [PLAN.md](docs/PLAN.md) — Implementation phases (chưa bắt đầu)

## Điểm nhấn phỏng vấn

- DevSecOps — shift-left security
- AI augment (không replace) human code review
- CI/CD integration pattern
- Developer productivity scaling

## Chi phí ước tính

~$5–10/tháng. Xem [cost-estimates.md](../docs/cost-estimates.md).

## Scope giới hạn

- 1 microservice sample (C#/.NET hoặc Node.js)
- Cypress test generation (không Katalon ban đầu)
- GitHub làm source repo (webhook trigger)
