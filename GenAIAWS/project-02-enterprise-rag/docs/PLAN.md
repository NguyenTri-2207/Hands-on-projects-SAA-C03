# Implementation Plan — Enterprise RAG (Outline)

> **Status:** Skeleton — chưa bắt đầu implement.

## Prerequisites

- Hoàn thành Project 1
- Bedrock access: Claude + Titan Embeddings
- Budget alert $50–80/tháng (OpenSearch cost cao)

## Phases (planned)

| Phase | Mục tiêu | Deliverable |
|-------|----------|-------------|
| **0 — Setup** | KMS CMK, S3 bucket, Cognito user pool | Encrypted storage + auth |
| **1 — Knowledge Base** | Bedrock KB + Titan embed + OpenSearch | Document ingestion pipeline |
| **2 — Query API** | API Gateway + Lambda + RetrieveAndGenerate | Working Q&A endpoint |
| **3 — Security** | WAF, Guardrails, IAM tenant isolation | PII blocked, rate limited |
| **4 — Multi-tenant** | Tenant prefix, metadata filter | 2 tenants demo |
| **5 — Polish** | Citation UI, monitoring, demo script | Interview-ready demo |

## Phase 0 — Setup (chi tiết khi bắt đầu)

- [ ] Tạo KMS CMK với key policy
- [ ] S3 bucket encrypted với CMK
- [ ] Cognito User Pool + App Client
- [ ] Upload 3–5 sample internal docs (dummy)

## Phase 1 — Knowledge Base

- [ ] Tạo OpenSearch Serverless collection (VECTORSEARCH)
- [ ] Tạo Bedrock Knowledge Base → link S3 + OpenSearch
- [ ] Sync data source → verify chunks trong OpenSearch
- [ ] Test retrieval quality với sample queries

## Phase 2 — Query API

- [ ] API Gateway + Cognito authorizer
- [ ] Lambda: `RetrieveAndGenerate` với Claude
- [ ] Response format: answer + citations + confidence
- [ ] Test end-to-end Q&A

## Phase 3 — Security

- [ ] WAF Web ACL: rate limit, SQLi protection
- [ ] Bedrock Guardrails: PII filter, denied topics
- [ ] CloudTrail logging cho KMS key usage
- [ ] Test: gửi câu hỏi chứa PII → bị chặn

## Phase 4 — Multi-tenant

- [ ] 2 Cognito users thuộc 2 tenants
- [ ] Tenant A không retrieve được docs của Tenant B
- [ ] IAM policies với `tenantId` condition

## Phase 5 — Polish

- [ ] CloudWatch dashboard
- [ ] Demo script 5 phút
- [ ] Interview talking points

## Risks

| Risk | Mitigation |
|------|------------|
| OpenSearch cost cao | Tắt collection khi không dùng, minimum OCUs |
| Poor retrieval quality | Tune chunk size, test với diverse queries |
| Guardrails false positive | Tune sensitivity, whitelist topics |

## Definition of Done

1. Upload doc → auto-indexed → queryable
2. Authenticated user nhận grounded answer với citations
3. PII query bị Guardrails chặn
4. 2 tenants isolated
5. Giải thích security architecture trong 5 phút
