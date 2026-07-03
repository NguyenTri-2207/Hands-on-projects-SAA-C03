# Implementation Plan — Financial Audit Agent

Phased plan align với tuần cuối tháng (song song ôn SAA-C03).

## Overview

| Phase | Thời gian ước tính | Mục tiêu |
|-------|-------------------|----------|
| 0 — Setup | 2–4 giờ | AWS account, Bedrock access, budget |
| 1 — Foundation | 4–6 giờ | S3 + DynamoDB + CFN deploy |
| 2 — Extract | 6–8 giờ | Parse file → JSON staging |
| 3 — Agent core | 8–12 giờ | Bedrock Converse + 2 tools |
| 4 — Orchestration | 6–8 giờ | Step Functions end-to-end |
| 5 — Polish | 4–6 giờ | Monitoring, demo, interview prep |

**Tổng:** ~30–44 giờ (1 tuần part-time hoặc 3–4 ngày full focus)

---

## Phase 0 — Setup

**Mục tiêu:** Môi trường AWS sẵn sàng.

### Checklist

- [ ] Hoàn thành [aws-prerequisites.md](../../docs/aws-prerequisites.md)
- [ ] Verify Bedrock model access (Claude Sonnet)
- [ ] Ghi lại `BedrockModelId` thực tế vào `infrastructure/parameters/dev.json`
- [ ] Tạo budget alert $15/tháng
- [ ] Test Bedrock Converse từ CLI hoặc script đơn giản

### Verify command

```bash
aws bedrock-runtime converse \
  --model-id <YOUR_MODEL_ID> \
  --messages '[{"role":"user","content":[{"text":"Hello"}]}]' \
  --region us-east-1 \
  --profile saa-c03-dev
```

### Deliverable

- AWS CLI configured
- Model ID documented trong `dev.json`

---

## Phase 1 — Foundation

**Mục tiêu:** Deploy storage layer qua CloudFormation.

### Tasks

- [ ] Review `infrastructure/templates/storage.yaml`
- [ ] Deploy master stack (storage only trước, hoặc full skeleton)
- [ ] Verify S3 buckets created (input, staging, output)
- [ ] Verify DynamoDB table `jobs` created
- [ ] Upload test file thủ công vào input bucket
- [ ] Confirm DynamoDB có thể read/write từ CLI

### Deploy

```bash
cd scripts
./deploy.sh dev
```

### Deliverable

- 3 S3 buckets + 1 DynamoDB table live trên AWS
- CFN outputs saved (bucket names, table name)

### SAA-C03 focus

- S3 bucket policies, encryption, block public access
- DynamoDB on-demand vs provisioned
- CloudFormation nested stacks

---

## Phase 2 — Extract

**Mục tiêu:** Lambda parse file → structured JSON.

### Tasks

- [ ] Implement `document-extractor` Lambda (Python)
- [ ] Phase 2a: Parse JSON/CSV sample (đơn giản, test nhanh)
- [ ] Phase 2b: Parse Excel với `openpyxl` (Lambda layer)
- [ ] Phase 2c: Parse PDF với `pdfplumber` (optional, sau)
- [ ] Output schema chuẩn → `staging/{jobId}/extracted.json`
- [ ] Unit test local với sample data

### JSON output schema (minimum)

```json
{
  "jobId": "uuid",
  "sourceFile": "report.xlsx",
  "period": "Q4-2025",
  "lineItems": [
    { "category": "Revenue", "label": "Total Revenue", "value": 1500000, "unit": "USD" },
    { "category": "Assets", "label": "Current Assets", "value": 800000, "unit": "USD" }
  ],
  "metadata": { "extractedAt": "ISO8601", "parser": "openpyxl-v1" }
}
```

### Deliverable

- Upload sample → Lambda extract → JSON trên S3 staging
- Có thể invoke Lambda thủ công (chưa cần Step Functions)

### SAA-C03 focus

- Lambda execution role, environment variables
- Lambda layers cho dependencies
- S3 event notifications (setup trong Phase 4)

---

## Phase 3 — Agent Core

**Mục tiêu:** Bedrock Converse + Tool Use hoạt động.

### Tasks

- [ ] Viết system prompt → `src/agent/prompts/system.md`
- [ ] Định nghĩa 2 tools ban đầu:
  - `calculate_financial_ratio`
  - `reconcile_line_items`
- [ ] Implement `calculation-tools` Lambda handlers
- [ ] Implement `agent-orchestrator` Lambda:
  - Load staging JSON từ S3
  - Call Bedrock Converse với toolConfig
  - Dispatch tool calls → calculation-tools
  - Loop until `end_turn` hoặc maxRounds=10
- [ ] Lưu mỗi tool call vào DynamoDB `AUDIT#<step>`
- [ ] Test với 1 sample report

### Deliverable

- Invoke orchestrator thủ công → audit findings in DynamoDB
- Console log hoặc local output showing tool use rounds

### SAA-C03 focus

- IAM: Bedrock `bedrock:InvokeModel` + `bedrock:Converse`
- Lambda-to-Lambda invoke permissions
- Error handling: Bedrock throttling

---

## Phase 4 — Orchestration

**Mục tiêu:** End-to-end workflow tự động.

### Tasks

- [ ] Implement `ingest-trigger` Lambda (S3 event → start SFN)
- [ ] Implement `report-generator` Lambda
- [ ] Deploy `orchestration.yaml` — Step Functions state machine
- [ ] Wire S3 event notification → ingest-trigger
- [ ] Test full flow: upload → extract → audit → report
- [ ] Verify DynamoDB status transitions: `PENDING → PROCESSING → COMPLETED`

### State transitions

```
PENDING → PROCESSING → COMPLETED
                    → NEEDS_REVIEW
                    → FAILED
```

### Deliverable

- Upload file → tự động nhận report trên S3 output bucket
- Step Functions execution graph hiển thị đầy đủ steps

### SAA-C03 focus

- Step Functions: Task, Choice, Catch, Retry states
- S3 event → Lambda → Step Functions pattern
- Idempotency trong ingest-trigger

---

## Phase 5 — Polish

**Mục tiêu:** Production-ready demo + interview.

### Tasks

- [ ] Deploy `monitoring.yaml` — CloudWatch alarms (Lambda errors, SFN failures)
- [ ] Thêm 2 tools còn lại: `cross_validate_periods`, `generate_audit_finding`
- [ ] Sanitize logs (không log financial values)
- [ ] Viết demo script 5 phút
- [ ] Record GIF/video demo (optional)
- [ ] Review [INTERVIEW-TALKING-POINTS.md](INTERVIEW-TALKING-POINTS.md)
- [ ] Cleanup test: delete stack + verify no orphaned resources

### Deliverable

- README updated với screenshots
- Demo reproducible trong < 5 phút
- Interview talking points rehearsed

### SAA-C03 focus

- CloudWatch metrics & alarms
- Cost review via Cost Explorer
- Resource cleanup best practices

---

## Risk Register

| Risk | Impact | Mitigation |
|------|--------|------------|
| Model ID không tồn tại | Block Phase 3 | Parameter hóa, verify Phase 0 |
| PDF extraction khó | Delay Phase 2 | JSON/CSV first |
| Agent loop quá dài | Lambda timeout | 1 round per SFN state |
| Chi phí Bedrock | Budget overrun | max_tokens, budget alert |
| CFN deploy fail | Delay | Deploy từng nested stack |

---

## Definition of Done

Project 1 hoàn thành khi:

1. Upload sample financial file → automatic audit report
2. DynamoDB có full audit trail (tool calls + findings)
3. Step Functions graph shows successful execution
4. CloudFormation deploy + destroy reproducible
5. Có thể giải thích architecture trong 5 phút phỏng vấn
