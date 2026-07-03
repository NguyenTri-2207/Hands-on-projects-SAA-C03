# Interview Talking Points — Financial Audit Agent

## 30-Second Pitch

> "Tôi xây một autonomous financial audit agent trên AWS. User upload báo cáo tài chính lên S3, Step Functions orchestrate workflow extract → audit → report. Core là Bedrock Claude với Tool Use — model không tự tính toán mà gọi Python Lambda để xác thực số liệu deterministic, rồi tự so sánh và phát hiện discrepancy. Mọi bước audit lưu vào DynamoDB làm audit trail."

---

## Deep Dive Topics

### 1. Agentic Architecture vs Simple Prompt Chain

| Simple chain | Agentic (this project) |
|-------------|------------------------|
| 1 prompt → 1 response | Multi-turn: reason → act → observe → reflect |
| Model tự tính (hallucinate risk) | Model gọi tools (deterministic) |
| Không self-correct | Phát hiện discrepancy → retry hoặc flag |
| Không traceable | Full audit trail trong DynamoDB |

**Cách nói:** "Tôi không hỏi model 'kiểm tra báo cáo này' một lần. Tôi thiết kế agent loop với tool definitions — model quyết định tool nào gọi, nhận kết quả, rồi reflect. Đây là pattern ReAct / tool-use agent trên production AWS."

### 2. Self-Correcting Mechanism

```
Tool output: current_ratio = 1.50
Source data: current_ratio = 1.48
Delta: 1.35% → severity = "material"

Agent decision:
  - minor (<1%) → log warning, continue
  - material → flag NEEDS_REVIEW, include in report
  - critical → stop, status FAILED
```

**Cách nói:** "Self-correcting không có nghĩa model sửa số liệu gốc. Nghĩa là hệ thống tự phát hiện lỗi, phân loại severity, và quyết định tiếp tục hay dừng — không cần human trong loop cho minor issues."

### 3. Dependency Chains trong Step Functions

**Sequential (audit steps):**
```
Extract → Agent Round 1 → Agent Round 2 → ... → Report
```

**Parallel (future):**
```
Extract → [Validate Ratios | Reconcile Items | Cross-validate Periods] → Merge → Report
```

**Cách nói:** "Step Functions quản lý dependency chain phức tạp. Mỗi state có retry policy riêng — Bedrock throttle retry ở agent state, extraction fail catch ở extract state. Tách orchestration khỏi business logic trong Lambda."

### 4. Lambda 15min vs Step Functions

| Approach | Pros | Cons |
|----------|------|------|
| 1 Lambda dài | Đơn giản | Timeout 15min, khó debug, no retry per step |
| Step Functions loop | Per-step retry, visual graph, no timeout limit | Phức tạp hơn, thêm cost |

**Cách nói:** "Agent loop có thể 5–10 rounds Bedrock calls. Tôi chọn Step Functions orchestrate mỗi round là 1 state — tránh Lambda timeout, dễ monitor, và retry granular."

### 5. Why Tool Use (Not RAG, Not Fine-tuning)

- **RAG:** Cho tra cứu tài liệu — không phù hợp tính toán
- **Fine-tuning:** Cho behavior/style — không đảm bảo math accuracy
- **Tool Use:** Model reason + gọi deterministic code → best for audit

### 6. Security & Compliance Talking Points

- Data không rời AWS account (Bedrock không train trên customer data)
- S3 encryption at rest, TLS in transit
- IAM least-privilege per Lambda
- Không log PII/financial values — chỉ jobId + step metadata
- Audit trail đầy đủ trong DynamoDB (compliance requirement)

---

## SAA-C03 Exam Hooks

Khi interviewer hỏi về cert, map sang project:

| Exam topic | Your answer |
|------------|-------------|
| "Thiết kế decoupled architecture" | S3 event → Lambda → Step Functions — mỗi component độc lập scale |
| "Xử lý failure" | Step Functions Catch + Retry, DynamoDB status tracking |
| "IAM best practices" | Per-Lambda roles, resource-scoped policies |
| "Cost optimization" | Serverless pay-per-use, budget alerts, on-demand DynamoDB |
| "Chọn database" | DynamoDB vì access pattern rõ (PK/SK per job), không cần relational |

---

## Common Interview Questions

**Q: Tại sao không dùng ECS/Fargate cho agent?**
A: Workload event-driven, sporadic (upload-triggered). Lambda + Step Functions rẻ hơn, zero idle cost, auto-scale. Fargate justify khi cần long-running process liên tục.

**Q: Làm sao đảm bảo model không hallucinate số?**
A: Model không tính toán — chỉ interpret. Mọi phép tính qua `calculation-tools` Lambda (Python deterministic). Model so sánh kết quả tool với source data.

**Q: Scale lên 1000 reports/day?**
A: S3 + Lambda auto-scale. Bottleneck = Bedrock rate limit → SQS buffer trước Step Functions, request quota increase, hoặc multi-region.

**Q: Multi-tenant?**
A: Thêm `tenantId` prefix trên S3 keys + DynamoDB PK (`TENANT#x#JOB#y`). IAM condition keys restrict access per tenant.

**Q: Testing strategy?**
A: Unit test calculation-tools (pure Python). Integration test orchestrator với mock Bedrock. E2E test với sample data trên dev stack.

---

## Demo Flow (5 phút)

1. **Show architecture diagram** (30s) — "đây là flow từ upload đến report"
2. **Upload sample file** (30s) — CLI hoặc console
3. **Step Functions graph** (1 min) — highlight states, retry
4. **DynamoDB audit trail** (1 min) — show tool calls, discrepancy
5. **Output report** (1 min) — findings, severity
6. **Trade-off discussion** (1 min) — tại sao agentic, tại sao serverless

---

## Red Flags to Avoid

- Đừng nói "AI tự kiểm toán 100% chính xác" — luôn mention human review cho material findings
- Đừng claim model tính toán — emphasize tool use
- Đừng ignore cost — mention budget alert và token limits
- Đừng skip security — mention encryption, IAM, no PII in logs
