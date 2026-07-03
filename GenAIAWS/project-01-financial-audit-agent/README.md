# Project 1: Autonomous Financial Audit Agent

AI Agent tự trị đọc báo cáo tài chính, tính toán/xác thực số liệu qua Bedrock Tool Use, tự kiểm toán và xuất report.

## Mục tiêu

- Tận dụng **Structured Reasoning** và **Multi-step tool use** của Claude trên Bedrock
- Workflow agentic: Đọc → Tính toán (tool) → So sánh → Self-audit → Report
- Orchestration bằng Step Functions, state tracking bằng DynamoDB

## AWS Services

| Service | Vai trò |
|---------|---------|
| Amazon S3 | Input (PDF/Excel) + Output (report) + Staging (JSON) |
| AWS Lambda | Extract, orchestrate, calculate, report |
| Amazon Bedrock | Claude Converse API + Tool Use |
| AWS Step Functions | Multi-step workflow orchestration |
| Amazon DynamoDB | Job status + audit trail |
| AWS IAM | Least-privilege roles |
| Amazon CloudWatch | Logs + alarms (Phase 5) |

## Cấu trúc thư mục

```
project-01-financial-audit-agent/
├── docs/           # ARCHITECTURE, PLAN, DATA-MODEL, RUNBOOK
├── infrastructure/   # CloudFormation nested stacks
├── src/            # Lambda code + agent prompts/tools
├── samples/        # Dummy financial data
└── scripts/        # Deploy & test scripts
```

## Quick links

- [ARCHITECTURE.md](docs/ARCHITECTURE.md) — System design
- [PLAN.md](docs/PLAN.md) — Implementation phases 0–5
- [DATA-MODEL.md](docs/DATA-MODEL.md) — DynamoDB + S3 layout
- [RUNBOOK.md](docs/RUNBOOK.md) — Deploy, test, troubleshoot
- [INTERVIEW-TALKING-POINTS.md](docs/INTERVIEW-TALKING-POINTS.md) — Phỏng vấn

## Trạng thái

| Phase | Status |
|-------|--------|
| 0 — Setup | ⬜ Chưa bắt đầu |
| 1 — Foundation | ⬜ |
| 2 — Extract | ⬜ |
| 3 — Agent core | ⬜ |
| 4 — Orchestration | ⬜ |
| 5 — Polish | ⬜ |

## Deploy (sau khi implement)

```bash
cd scripts
./deploy.sh dev
```

Xem chi tiết: [docs/RUNBOOK.md](docs/RUNBOOK.md)
