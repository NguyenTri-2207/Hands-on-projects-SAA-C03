# SAA-C03 Hands-on Projects

10 dự án thực hành bám sát 4 domain đề thi **AWS Solutions Architect Associate (SAA-C03)**.

**Trạng thái:** Chờ triển khai — docs skeleton.

## 10 Dự án

| # | Dự án | Domain chính | Tuần gợi ý |
|---|-------|--------------|------------|
| 1 | [3-Tier HA Web](project-01-3tier-ha-web/) | Resilient | 1 |
| 2 | [Serverless Data Pipeline](project-02-serverless-data-pipeline/) | Serverless / Cost | 1 |
| 3 | [Hybrid Storage Migration](project-03-hybrid-storage-migration/) | Storage / Cost | 1 |
| 4 | [Secure + Monitoring](project-04-secure-monitoring/) | Security | 2 |
| 5 | [ECS Fargate](project-05-ecs-fargate/) | Containers | 2 |
| 6 | [CloudFront CDN](project-06-cloudfront-cdn/) | Performance / Edge | 3 |
| 7 | [Event-Driven Microservices](project-07-event-driven-microservices/) | Decoupling | 3 |
| 8 | [Database Caching](project-08-database-caching/) | Performance / DB | 2 |
| 9 | [Cross-Region DR](project-09-cross-region-dr/) | Reliability / DR | 3 |
| 10 | [Log Analytics](project-10-log-analytics/) | Analytics / Ops | 3 |

## Bắt đầu

1. [docs/overview.md](docs/overview.md) — review, lộ trình 30 ngày, map domain
2. Ý tưởng gốc: [docs.md](docs.md)

## Lộ trình 30 ngày (tóm tắt)

```
Tuần 1 → P1, P2, P3   (VPC, Serverless, Storage)
Tuần 2 → P4, P5, P8   (Security, Containers, Caching)
Tuần 3 → P6, P7, P9, P10 (CDN, Events, DR, Logs)
Tuần 4 → Practice exams (4–5 bộ full)
```

## Liên quan

- [GenAIAWS](../GenAIAWS/) — Dự án GenAI trên Bedrock
- [AIAgentAWS](../AIAgentAWS/) — AI Agent browser automation

## IaC (khi triển khai)

CloudFormation YAML — thống nhất với các track khác trong repo.
