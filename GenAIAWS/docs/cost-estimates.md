# Cost Estimates

Ước tính chi phí dev/demo. Giá thay đổi theo region và thời điểm — dùng [AWS Pricing Calculator](https://calculator.aws/) để verify.

## Project 1 — Financial Audit Agent (dev/demo)

| Service | Usage giả định | Ước tính/tháng |
|---------|----------------|----------------|
| **Bedrock (Claude)** | 50 audit runs × ~5K input + 2K output tokens | $2–8 |
| **Lambda** | 500 invocations, 512MB, 30s avg | Free tier / < $1 |
| **Step Functions** | 50 executions × 10 states | < $0.50 |
| **S3** | 1 GB storage, 200 requests | < $0.50 |
| **DynamoDB** | On-demand, 1000 RCU/WCU | Free tier / < $1 |
| **CloudWatch Logs** | 500 MB | < $1 |
| **Tổng** | | **~$5–15/tháng** |

### Cách giảm chi phí

- Set `max_tokens` thấp trong Bedrock Converse calls
- Xóa stacks sau khi demo (`aws cloudformation delete-stack`)
- Dùng budget alert $10–15
- Test với JSON sample trước, PDF/Excel sau (ít token hơn)
- Giới hạn agent loop: max 5 tool-use rounds

## Project 2 — Enterprise RAG (ước tính khi triển khai)

| Service | Usage giả định | Ước tính/tháng |
|---------|----------------|----------------|
| **OpenSearch Serverless** | 2 OCUs minimum | $50–100+ |
| **Bedrock Knowledge Bases** | Ingestion + query | $5–20 |
| **Titan Embeddings** | 100K tokens ingest | $1–3 |
| **S3 + KMS** | 5 GB | $1–2 |
| **Cognito** | < 50K MAU | Free |
| **WAF** | Basic rules | $5–10 |
| **Tổng** | | **~$60–130/tháng** |

> OpenSearch Serverless là cost driver lớn nhất. Chỉ bật khi sẵn sàng demo P2; tắt collection khi không dùng.

## Project 3 — DevOps Testing Agent

| Service | Usage giả định | Ước tính/tháng |
|---------|----------------|----------------|
| **CodePipeline** | 1 pipeline, 30 runs | $1 |
| **CodeBuild** | 30 builds × 5 min (general1.small) | $3–5 |
| **Bedrock** | 30 PR reviews | $1–5 |
| **SNS** | 100 notifications | < $0.10 |
| **Tổng** | | **~$5–10/tháng** |

## Free Tier highlights (12 tháng đầu)

- Lambda: 1M requests/tháng
- DynamoDB: 25 GB storage
- S3: 5 GB standard
- CodeBuild: 100 build minutes/tháng

## Budget alert khuyến nghị

| Giai đoạn | Budget |
|-----------|--------|
| P1 dev only | $15/tháng |
| P1 + P2 demo | $50/tháng |
| Full 3 projects | $80/tháng |

## Cleanup commands

```bash
# Xóa toàn bộ stack P1
aws cloudformation delete-stack \
  --stack-name financial-audit-agent-dev \
  --profile saa-c03-dev \
  --region us-east-1

# Empty S3 buckets trước nếu có ObjectLock/versioning
```
