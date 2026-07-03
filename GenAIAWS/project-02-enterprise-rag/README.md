# Project 2: Enterprise RAG with Advanced Edge Security

Trợ lý ảo tra cứu tài liệu nội bộ cho doanh nghiệp lớn — bảo mật đa lớp, data residency, chống hallucination.

## Trạng thái

**Skeleton** — mở rộng sau khi hoàn thành Project 1.

## Mục tiêu

- RAG pipeline: ingest → chunk → embed → vector search → grounded generation
- Enterprise security: KMS, WAF, Cognito, Bedrock Guardrails
- Multi-tenant support
- Không train lại model công cộng trên customer data

## AWS Services

| Service | Vai trò |
|---------|---------|
| Amazon S3 + KMS CMK | Lưu tài liệu mật, encryption at-rest |
| Amazon Bedrock Knowledge Bases | Pipeline chunk + embed + index |
| Amazon Titan Text Embeddings | Vector hóa tài liệu |
| Amazon OpenSearch Serverless | Vector index |
| Amazon Cognito | User authentication |
| AWS WAF | Edge protection |
| Amazon API Gateway | API front door |
| Bedrock Guardrails | Chặn PII, sensitive content |
| Claude Sonnet (Bedrock) | Grounded answer generation |

## Docs

- [ARCHITECTURE.md](docs/ARCHITECTURE.md) — System design outline
- [PLAN.md](docs/PLAN.md) — Implementation phases (chưa bắt đầu)

## Điểm nhấn phỏng vấn

- Data privacy & residency — data không rời AWS account
- Defense in depth: WAF → Cognito → API GW → Guardrails → RAG
- Multi-tenant RAG pattern
- RAG vs fine-tuning trade-offs

## Chi phí ước tính

~$60–130/tháng (OpenSearch Serverless là cost driver chính). Xem [cost-estimates.md](../docs/cost-estimates.md).
