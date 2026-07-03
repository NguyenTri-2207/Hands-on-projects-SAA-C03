# Upwork Profile Summary — Draft

> Chỉnh theo giọng của bạn trước khi paste lên Upwork.

---

## Title (70 ký tự max)

```
AWS Cloud Architect | GenAI Bedrock | Serverless & AI Agents
```

---

## Overview (pitch 2 đoạn)

**Đoạn 1 — Who:**
AWS Solutions Architect với hands-on portfolio gồm serverless pipelines, high-availability web architecture, GenAI trên Amazon Bedrock, và AI agents tự động hóa browser/UI. Thiết kế hướng production: security, cost optimization, IaC.

**Đoạn 2 — What I deliver:**
- Triển khai AWS từ zero → demo: VPC, Lambda, ECS, Step Functions, RDS
- GenAI: RAG, agent với tool use, CI/CD code review bot
- Automation: Playwright + Bedrock cho workflow CRM / web scraping có kiểm soát
- Tài liệu: architecture diagram, runbook, handover rõ ràng

---

## Case study template (1 project)

Dùng file này cho mỗi project khi pitch job liên quan.

```markdown
## [Tên project]

**Client need:** [Bài toán khách hàng — map từ job post]

**Solution:** [Kiến trúc 2–3 câu]

**Stack:** AWS [services], [languages]

**Outcome:** [Metric hoặc deliverable cụ thể]

**Demo:** [GitHub link / screenshot / video]
```

Lưu case study hoàn chỉnh tại: `portfolio/upwork/case-studies/<project-slug>.md`

---

## Hourly vs Fixed — gợi ý scope

| Loại job Upwork | Project portfolio match |
|-----------------|-------------------------|
| "Setup AWS serverless API" | SAA P2, GenAI P1 |
| "Bedrock RAG chatbot" | GenAI P2 |
| "CI/CD + automation" | GenAI P3 |
| "Web automation bot" | AIAgent P1 |
| "AWS architecture review" | SAA P1, P4, P9 |

---

## Red flags — đừng nhận nếu

- Bot scrape site vi phạm ToS / không có human-in-loop
- Yêu cầu credentials trong chat (dùng Secrets Manager)
- Scope không có teardown plan → chi phí AWS phát sinh
