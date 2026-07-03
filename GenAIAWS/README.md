# Hands-on Projects — SAA-C03 + GenAI on AWS

Monorepo chứa 3 dự án GenAI trên AWS, thiết kế để song song với việc ôn thi **AWS Solutions Architect Associate (SAA-C03)** và chuẩn bị portfolio phỏng vấn.

## 3 Dự án

| # | Dự án | Trạng thái | Ưu tiên |
|---|-------|-----------|---------|
| 1 | [Financial Audit Agent](project-01-financial-audit-agent/) | **Đang triển khai** | ★ Chính |
| 2 | [Enterprise RAG](project-02-enterprise-rag/) | Skeleton | Mở rộng sau P1 |
| 3 | [DevOps Testing Agent](project-03-devops-testing-agent/) | Skeleton | Mở rộng sau P1 |

## Roadmap đề xuất

```
Tuần 1–3  → Ôn SAA-C03 (lý thuyết + practice exams)
Tuần 4    → Project 1 Phase 0–2 (Foundation + Extract)
Tuần cuối → Project 1 Phase 3–5 (Agent + Orchestration + Demo)
Sau thi   → Mở rộng Project 2 hoặc 3 tùy hướng ứng tuyển
```

## Cấu trúc repo

```
├── docs/                              # Tài liệu chung
├── project-01-financial-audit-agent/  # Agent kiểm toán tài chính (chi tiết)
├── project-02-enterprise-rag/         # RAG doanh nghiệp + bảo mật
├── project-03-devops-testing-agent/   # AI review PR + sinh test
└── shared/                            # CloudFormation conventions dùng chung
```

## Bắt đầu nhanh

1. Đọc [docs/aws-prerequisites.md](docs/aws-prerequisites.md) — setup account, Bedrock, budget alert
2. Xem [docs/saa-c03-service-mapping.md](docs/saa-c03-service-mapping.md) — map services → exam domains
3. Vào [project-01-financial-audit-agent/docs/PLAN.md](project-01-financial-audit-agent/docs/PLAN.md) — checklist từng phase
4. Chuẩn bị phỏng vấn: [docs/interview-master-guide.md](docs/interview-master-guide.md)

## Tech stack

- **IaC:** CloudFormation (YAML nested stacks)
- **Runtime:** Python 3.12 (Lambda)
- **AI:** Amazon Bedrock — Claude (Converse API + Tool Use)
- **Orchestration:** AWS Step Functions

## Chi phí ước tính

Xem [docs/cost-estimates.md](docs/cost-estimates.md). Dev/demo P1: ~$5–15/tháng với budget alert.

## Lưu ý

- Không commit credentials, file tài chính thật, hoặc PII
- Verify Bedrock model ID trong console trước khi deploy (model availability thay đổi theo region)
- Region khuyến nghị: `us-east-1`
