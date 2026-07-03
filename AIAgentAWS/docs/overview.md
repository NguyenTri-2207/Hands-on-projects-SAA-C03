# Review — 2 Dự Án AI Agent UI Automation

> Tài liệu sơ bộ để trình Sếp. Chi tiết triển khai sau khi duyệt.

## Tóm tắt

| | Project 1 — CRM Automation | Project 2 — Deal Hunter |
|---|---------------------------|-------------------------|
| **Mục tiêu** | Chat tiếng Việt → tự động thao tác CRM nội bộ | Săn deal e-commerce → đặt hàng tự động |
| **UI** | Chat + CRM giả lập (tự build) | Dashboard + live timeline |
| **AI** | Bedrock: intent → JSON action plan + vision (screenshot) | Bedrock: điều phối flow mua hàng |
| **Browser** | Playwright trên Lambda (Docker) | Playwright trên Fargate (long-running) |
| **Orchestration** | Đơn giản (API → Lambda) | Step Functions (search → cart → checkout) |
| **Human-in-loop** | Ít (CRM nội bộ, kiểm soát được) | Bắt buộc (CAPTCHA → SNS alert) |

## Điểm mạnh

**Project 1**
- Scope kiểm soát được — CRM do mình build, không phụ thuộc site bên thứ 3
- Thể hiện full-stack (Next.js) + agent + browser automation
- Vision feedback loop (screenshot → Bedrock) là điểm nhấn kỹ thuật rõ
- Lambda đủ cho flow ngắn (login → fill form → submit)

**Project 2**
- Thể hiện kiến trúc phức tạp hơn: Fargate, Step Functions, SNS
- Human-in-the-loop pattern thực tế (CAPTCHA, xác nhận thanh toán)
- Dashboard live timeline — demo ấn tượng cho stakeholder
- Map tốt SAA-C03: HA, state machine, async long-running task

## Rủi ro cần lưu ý (khi trình duyệt)

| Rủi ro | P1 | P2 |
|--------|----|----|
| Playwright trên Lambda (cold start, 15min timeout, Docker image size) | Trung bình | Không dùng Lambda cho browser chính |
| ToS / pháp lý khi bot trên site thương mại thật | Thấp (CRM giả lập) | **Cao** — nên demo trên site test / mock |
| CAPTCHA / anti-bot | Thấp | Cao — cần human-in-loop |
| Chi phí Fargate chạy lâu | — | Trung bình — cần budget + auto-stop |
| Bảo mật credentials | Secrets Manager | Secrets Manager + không log payment info |

## Thứ tự đề xuất

```
1. P1 local: Next.js CRM + Playwright chạy local (hard-coded actions)
2. P1 AWS: Bedrock intent parsing + Lambda Playwright + Secrets Manager
3. P1 nâng cao: Vision loop (screenshot → self-correct)
4. P2: Chỉ bắt đầu sau khi P1 demo ổn — reuse Playwright patterns
```

## Phân biệt với GenAIAWS

| GenAIAWS | AIAgentAWS |
|----------|------------|
| AI xử lý data (PDF, RAG, code review) | AI điều khiển UI / trình duyệt |
| Serverless thuần (Lambda, Step Functions) | Lambda + **container** (Fargate) |
| Không có frontend phức tạp | **Full-stack** (Chat, Dashboard) |

Hai track bổ sung nhau trên CV: backend GenAI + agent UI automation.

## Timeline gợi ý (1 tháng, sau khi duyệt)

- **Tuần 1–2:** P1 full-stack local + Playwright
- **Tuần 3:** P1 AWS integration (Bedrock + Lambda)
- **Tuần 4:** P1 polish demo HOẶC bắt đầu P2 skeleton

## Quyết định cần Sếp duyệt

- [ ] Làm P1 trước, P2 sau (recommended)
- [ ] P2 demo trên mock store hay site thật (recommend: mock)
- [ ] Budget AWS ước tính (~$20–50/tháng dev)
- [ ] Scope MVP P1: những action CRM nào (login, tạo lead, cập nhật contact?)
