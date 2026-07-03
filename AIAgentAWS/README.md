# AI Agent AWS — UI Automation & CRM

Track dự án AI Agent điều khiển trình duyệt (browser automation) trên AWS — bổ sung cho [GenAIAWS](../GenAIAWS/) (Bedrock backend/agent).

**Trạng thái:** Chờ duyệt — docs skeleton, chưa triển khai.

## 2 Dự án

| # | Dự án | Compute | Độ phức tạp |
|---|-------|---------|-------------|
| 1 | [CRM Automation](project-01-crm-automation/) | Lambda + Playwright (Docker) | Trung bình — làm trước |
| 2 | [Deal Hunter](project-02-deal-hunter/) | ECS Fargate + Step Functions | Cao — làm sau P1 |

## Bắt đầu

1. Đọc [docs/overview.md](docs/overview.md) — review & so sánh 2 dự án
2. Ý tưởng gốc: [doc.md](doc.md)

## Tech stack (dự kiến)

- **Frontend:** React / Next.js
- **AI:** Amazon Bedrock (Claude) — intent → JSON action plan
- **Browser:** Playwright (headless)
- **AWS:** Lambda, ECS Fargate, Step Functions, S3, DynamoDB, Secrets Manager, SNS

## Liên quan

- [GenAIAWS](../GenAIAWS/) — 3 dự án GenAI (Financial Audit, RAG, DevOps)
- [SAA-C03](../SAA-C03/) — Ôn thi (nếu có)
