# SAA-C03 Service Mapping

Map services trong 3 dự án GenAI → 4 domains của đề thi SAA-C03.

## Domain 1: Design Resilient Architectures

| Concept | Project 1 | Project 2 | Project 3 |
|---------|-----------|-----------|-----------|
| Decoupling | S3 event → Lambda → Step Functions | API Gateway → Lambda → OpenSearch | Webhook → Pipeline stages |
| Retry & backoff | Step Functions `Retry` on Bedrock throttle | OpenSearch retry policy | CodeBuild retry on fail |
| Multi-AZ | DynamoDB (managed) | OpenSearch Serverless (managed HA) | Pipeline multi-region (optional) |
| Disaster recovery | S3 versioning on input bucket | S3 cross-region replication (optional) | Pipeline artifact backup |

**Câu hỏi ôn tập:** Khi Bedrock throttle, bạn retry ở đâu — Lambda hay Step Functions? Tại sao?

## Domain 2: Design High-Performing Architectures

| Concept | Project 1 | Project 2 | Project 3 |
|---------|-----------|-----------|-----------|
| Serverless scaling | Lambda auto-scale per upload | OpenSearch Serverless OCUs | CodeBuild parallel builds |
| Caching | DynamoDB DAX (optional, overkill cho demo) | OpenSearch query cache | Build cache in CodeBuild |
| Async processing | Step Functions orchestration | Async ingestion via Knowledge Bases | Async PR review pipeline |
| Right-sizing | Lambda memory tuning for extract | Vector dimension / chunk size | CodeBuild compute type |

**Câu hỏi ôn tập:** Tại sao agent loop nên orchestrate bằng Step Functions thay vì 1 Lambda dài?

## Domain 3: Design Secure Applications

| Concept | Project 1 | Project 2 | Project 3 |
|---------|-----------|-----------|-----------|
| Encryption at rest | S3 SSE-S3 / KMS | KMS CMK on S3 + OpenSearch | Secrets Manager for tokens |
| Encryption in transit | HTTPS (presigned URL) | TLS end-to-end | HTTPS webhook |
| IAM least privilege | Per-Lambda execution roles | Cognito + IAM fine-grained | CI/CD service roles |
| Network security | S3 bucket policy | WAF + VPC endpoints | OIDC for GitHub Actions |
| Data privacy | No PII in logs | Bedrock Guardrails, no model training | Scan for secrets in PR |

**Câu hỏi ôn tập:** Enterprise RAG cần gì để đảm bảo data không train lại public model?

## Domain 4: Design Cost-Optimized Architectures

| Concept | Project 1 | Project 2 | Project 3 |
|---------|-----------|-----------|-----------|
| Pay-per-use | Lambda + Step Functions | Serverless OpenSearch OCUs | CodeBuild per-minute |
| Storage tiering | S3 Intelligent-Tiering (optional) | S3 lifecycle for old docs | S3 for artifacts |
| Right resource | On-demand DynamoDB | OCUs scale to zero | Spot instances (optional) |
| Monitoring cost | CloudWatch + Budget alert | CloudWatch + Cost Explorer | SNS throttling |

## Service checklist theo dự án

### Project 1 — Financial Audit Agent

- [x] Amazon S3
- [x] AWS Lambda
- [x] Amazon DynamoDB
- [x] AWS Step Functions
- [x] Amazon Bedrock
- [x] AWS IAM
- [x] Amazon CloudWatch

### Project 2 — Enterprise RAG

- [ ] Amazon S3 + KMS
- [ ] Amazon Bedrock Knowledge Bases
- [ ] Amazon Titan Embeddings
- [ ] Amazon OpenSearch Serverless
- [ ] Amazon Cognito
- [ ] AWS WAF
- [ ] Amazon API Gateway
- [ ] Bedrock Guardrails

### Project 3 — DevOps Testing Agent

- [ ] AWS CodePipeline
- [ ] AWS CodeBuild
- [ ] Amazon SNS
- [ ] Amazon Bedrock
- [ ] (Optional) GitHub Actions thay CodePipeline

## Ôn thi song song

Khi làm hands-on, ghi chú lại:

1. **Service nào thay thế được service nào?** (ví dụ: Step Functions vs SQS+Lambda cho orchestration)
2. **Failure mode** của từng service
3. **Pricing model** (per request, per GB, per hour)

→ Ghi chú cá nhân có thể thêm vào `docs/notes/` (tạo sau nếu cần).
