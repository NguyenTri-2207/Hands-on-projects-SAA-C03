# Interview Master Guide

Talking points gộp cho cả 3 dự án — dùng khi phỏng vấn Solutions Architect, Cloud Engineer, hoặc GenAI Engineer.

## Elevator pitch (30 giây)

> "Tôi đang ôn SAA-C03 và xây 3 dự án GenAI trên AWS: một agent tự kiểm toán báo cáo tài chính với Bedrock Tool Use, một enterprise RAG có bảo mật đa lớp, và một bot review PR tự động sinh test. Tất cả dùng serverless, IaC bằng CloudFormation, thiết kế theo least-privilege IAM."

---

## Project 1: Financial Audit Agent

**One-liner:** AI agent đọc báo cáo tài chính, gọi Python tools để xác thực số liệu, tự phát hiện lệch và xuất audit report.

### Điểm mạnh khi nói

| Chủ đề | Cách trình bày |
|--------|----------------|
| Agentic architecture | Không phải 1-shot prompt — model **reason → act (tool) → observe → reflect** |
| Self-correcting | Khi tool trả discrepancy, agent ghi nhận và quyết định retry hoặc flag `NEEDS_REVIEW` |
| Tool Use | Bedrock Converse API với tool definitions JSON Schema → Lambda handlers |
| Orchestration | Step Functions quản lý dependency chain, retry Bedrock throttle |
| Audit trail | Mọi tool call lưu DynamoDB `AUDIT#<step>` — traceable |

### Câu hỏi phỏng vấn thường gặp

**Q: Tại sao không để model tự tính toán?**
A: LLM hallucinate số. Tool Use đảm bảo phép tính chạy deterministic Python, model chỉ interpret và so sánh.

**Q: Lambda timeout 15 phút — agent loop dài thì sao?**
A: Mỗi Step Functions state = 1 Converse round. State machine loop cho đến `stop_reason != tool_use` hoặc max iterations.

**Q: Xử lý PDF phức tạp?**
A: Phase approach — JSON/CSV trước, PDF sau với extraction layer riêng. Agent không parse raw PDF.

→ Chi tiết: [project-01/docs/INTERVIEW-TALKING-POINTS.md](../project-01-financial-audit-agent/docs/INTERVIEW-TALKING-POINTS.md)

---

## Project 2: Enterprise RAG

**One-liner:** Trợ lý tra cứu tài liệu nội bộ với encryption, WAF, Cognito, Guardrails — đáp ứng enterprise compliance.

### Điểm mạnh khi nói

| Chủ đề | Cách trình bày |
|--------|----------------|
| Data residency | Data ở S3 account của bạn, Bedrock không train trên customer data |
| Defense in depth | WAF → Cognito → API GW → Bedrock Guardrails → Knowledge Base |
| Multi-tenant | Prefix `tenantId/` trên S3, filter metadata trên OpenSearch |
| Hallucination control | Retrieve top-K chunks → grounded generation với citation |
| KMS CMK | Customer managed keys — audit key usage qua CloudTrail |

### Câu hỏi phỏng vấn thường gặp

**Q: RAG vs fine-tuning?**
A: RAG cho knowledge thay đổi thường xuyên, không cần retrain. Fine-tuning cho style/behavior, không phải facts.

**Q: Làm sao chặn PII leak?**
A: Bedrock Guardrails (PII filter) + pre-ingestion redaction + output scanning.

---

## Project 3: DevOps Testing Agent

**One-liner:** AI bot trong CI/CD — review PR, phát hiện security issue, tự sinh Cypress test.

### Điểm mạnh khi nói

| Chủ đề | Cách trình bày |
|--------|----------------|
| DevSecOps | Shift-left security — catch trước khi merge |
| Developer productivity | Auto-generate test scaffold, dev chỉ refine |
| CI integration | Webhook → Pipeline → comment on PR + SNS alert |
| Scoped analysis | Chỉ gửi diff + context file, không dump cả repo |

### Câu hỏi phỏng vấn thường gặp

**Q: AI review có thay human review?**
A: Không — augment, không replace. Bot flag issues, human quyết định merge.

**Q: False positive?**
A: Prompt engineering + severity levels + chỉ block merge cho CRITICAL.

---

## SAA-C03 badge + GenAI combo

Khi recruiter hỏi "SAA-C03 + GenAI khác gì chỉ có cert?":

1. **Cert** chứng minh bạn biết *design patterns* và *service selection*
2. **Hands-on** chứng minh bạn *implement được* — IAM policies, CFN, error handling
3. **Demo** cho thấy bạn hiểu *trade-offs thực tế* (cost, latency, security)

## Demo script gợi ý (5 phút)

1. Upload file Excel mẫu → S3 (30s)
2. Show Step Functions execution graph (1 min)
3. Show DynamoDB audit trail — tool calls + discrepancies (1 min)
4. Open output report trên S3 (1 min)
5. Giải thích architecture diagram (1.5 min)

## Resources

- [AWS Bedrock Converse API](https://docs.aws.amazon.com/bedrock/latest/userguide/conversation-inference.html)
- [Step Functions Error Handling](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-error-handling.html)
- [Bedrock Knowledge Bases](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base.html)
