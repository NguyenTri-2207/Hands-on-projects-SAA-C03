# Plan — Deal Hunter (Outline)

> Bắt đầu sau khi Project 1 MVP xong và được duyệt tiếp.

## Phase A — Reuse từ P1

- [ ] Tách Playwright utils từ CRM project
- [ ] Mock e-commerce store (Next.js): listing, product, cart, checkout

## Phase B — Local orchestration

- [ ] Script: search → add cart → checkout (hard-coded)
- [ ] Dashboard đọc log file local (giả lập timeline)

## Phase C — AWS

- [ ] ECS Fargate + Playwright image
- [ ] Step Functions state machine
- [ ] DynamoDB campaign + action log
- [ ] S3 screenshots

## Phase D — Human-in-loop

- [ ] Detect CAPTCHA (screenshot + heuristic hoặc Bedrock vision)
- [ ] SNS notification
- [ ] Resume workflow sau khi user confirm

## Phase E — Live dashboard

- [ ] WebSocket hoặc polling → timeline real-time
- [ ] Demo video

## Definition of Done (MVP)

Tạo campaign trên dashboard → agent tự tìm sản phẩm trên **mock store** → thêm giỏ → dừng trước thanh toán thật → timeline hiển thị đầy đủ bước.
