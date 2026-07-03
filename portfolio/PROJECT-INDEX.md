# Portfolio — Project Index

Bảng tổng hợp **15 dự án** — dùng cho CV, Upwork, phỏng vấn, pitch khách hàng.

> Cập nhật cột `Status` và `Demo` khi hoàn thành từng dự án.

## Legend

| Status | Ý nghĩa |
|--------|---------|
| `idea` | Chỉ có docs skeleton |
| `wip` | Đang code |
| `demo` | Có demo chạy được |
| `prod` | Đã deploy / khách hàng dùng |

---

## Track 1 — SAA-C03 Classic Architecture (10)

| # | Project | One-liner | Stack | Status | Folder |
|---|---------|-----------|-------|--------|--------|
| 1 | 3-Tier HA Web | Web 3 tầng Multi-AZ, ALB + ASG + RDS | VPC, ALB, ASG, RDS, Route 53 | idea | [SAA-C03/project-01](../SAA-C03/project-01-3tier-ha-web/) |
| 2 | Serverless Pipeline | Upload CSV → Lambda → DynamoDB → API | S3, Lambda, DynamoDB, API GW, Cognito | idea | [project-02](../SAA-C03/project-02-serverless-data-pipeline/) |
| 3 | Hybrid Storage | On-prem backup + S3 lifecycle → Glacier | Storage Gateway, S3, Glacier | idea | [project-03](../SAA-C03/project-03-hybrid-storage-migration/) |
| 4 | Secure Monitoring | IAM + KMS + CloudTrail + GuardDuty | IAM, KMS, CloudWatch, GuardDuty | idea | [project-04](../SAA-C03/project-04-secure-monitoring/) |
| 5 | ECS Fargate | Container web app serverless | ECS, Fargate, ECR, ALB | idea | [project-05](../SAA-C03/project-05-ecs-fargate/) |
| 6 | CloudFront CDN | Global static site + WAF + OAC | CloudFront, S3, ACM, WAF | idea | [project-06](../SAA-C03/project-06-cloudfront-cdn/) |
| 7 | Event-Driven | Order SNS fan-out → SQS → Lambda | SNS, SQS, Lambda | idea | [project-07](../SAA-C03/project-07-event-driven-microservices/) |
| 8 | DB Caching | ElastiCache Redis cache-aside + RDS | RDS, ElastiCache, EC2 | idea | [project-08](../SAA-C03/project-08-database-caching/) |
| 9 | Cross-Region DR | Failover Region A → B | Route 53, S3 CRR, RDS CRR | idea | [project-09](../SAA-C03/project-09-cross-region-dr/) |
| 10 | Log Analytics | Logs → Firehose → OpenSearch | CloudWatch, Firehose, OpenSearch | idea | [project-10](../SAA-C03/project-10-log-analytics/) |

**Pitch SAA track:** *"Hands-on 10 kiến trúc AWS bám 4 domain đề thi SAA-C03 — từ VPC 3-tier đến DR cross-region."*

---

## Track 2 — GenAI on AWS (3)

| # | Project | One-liner | Stack | Status | Folder |
|---|---------|-----------|-------|--------|--------|
| 1 | Financial Audit Agent | AI audit báo cáo tài chính + Tool Use | Bedrock, Lambda, Step Functions, S3, DynamoDB | wip | [GenAIAWS/project-01](../GenAIAWS/project-01-financial-audit-agent/) |
| 2 | Enterprise RAG | RAG nội bộ + KMS + WAF + Guardrails | Bedrock KB, OpenSearch, Cognito | idea | [project-02](../GenAIAWS/project-02-enterprise-rag/) |
| 3 | DevOps Testing Agent | AI review PR + sinh Cypress test | Bedrock, CodePipeline, SNS | idea | [project-03](../GenAIAWS/project-03-devops-testing-agent/) |

**Pitch GenAI track:** *"Production-grade GenAI trên Bedrock — agent có tool use, enterprise RAG, DevSecOps automation."*

---

## Track 3 — AI Agent UI Automation (2)

| # | Project | One-liner | Stack | Status | Folder |
|---|---------|-----------|-------|--------|--------|
| 1 | CRM Automation | Chat tiếng Việt → Playwright tự thao tác CRM | Bedrock, Lambda, Playwright, Next.js | idea | [AIAgentAWS/project-01](../AIAgentAWS/project-01-crm-automation/) |
| 2 | Deal Hunter | Agent săn deal + human-in-loop CAPTCHA | Fargate, Step Functions, SNS, Playwright | idea | [AIAgentAWS/project-02](../AIAgentAWS/project-02-deal-hunter/) |

**Pitch Agent track:** *"AI agent điều khiển browser — từ chat CRM automation đến long-running deal hunter với human-in-the-loop."*

---

## Top 5 đưa lên CV / Upwork (khi demo xong)

Ưu tiên show theo đối tượng:

| Đối tượng | Projects nên highlight |
|-----------|------------------------|
| **Recruiter AWS/Cloud** | SAA P1 + P9, GenAI P1, GenAI P2 |
| **Recruiter AI/ML** | GenAI P1, GenAI P2, AIAgent P1 |
| **Khách Upwork (automation)** | AIAgent P1, GenAI P3 |
| **Khách enterprise** | GenAI P2, SAA P4, SAA P1 |

---

## Cấu trúc tài liệu mỗi project (chuẩn repo)

```
project-XX-name/
├── README.md           → elevator pitch (đọc đầu tiên)
├── docs/
│   ├── ARCHITECTURE.md → diagram + components
│   └── PLAN.md         → phases / checklist
├── infrastructure/     → CloudFormation (khi có)
├── src/                → code (khi có)
└── showcase.md         → (tạo khi demo xong) 1-pager cho khách hàng
```

Khi project đạt `demo`, tạo thêm:
- `showcase.md` trong folder project
- `portfolio/demos/<project-slug>/` — screenshot, GIF, link video
