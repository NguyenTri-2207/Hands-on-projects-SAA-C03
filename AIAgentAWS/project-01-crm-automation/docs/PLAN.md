# Plan — CRM Automation (Outline)

## Phase A — Local (chưa AWS)

- [ ] Next.js: trang CRM mock (login + form lead)
- [ ] Next.js: chat UI (gửi message, hiển thị kết quả)
- [ ] Playwright script hard-coded: login + tạo lead
- [ ] Chạy Playwright local, CRM chạy localhost

## Phase B — Bedrock

- [ ] Prompt: tiếng Việt → action plan JSON
- [ ] Thay hard-coded script bằng dynamic plan từ Bedrock
- [ ] Test 2–3 câu lệnh mẫu

## Phase C — AWS

- [ ] Lambda Planner + API Gateway
- [ ] Lambda Runner (Playwright Docker image → ECR)
- [ ] Secrets Manager cho credentials
- [ ] S3 lưu screenshots

## Phase D — Vision & polish

- [ ] Gửi screenshot khi action fail → Bedrock vision gợi ý sửa
- [ ] Demo script + ghi hình

## Definition of Done (MVP)

User chat 1 câu tiếng Việt → hệ thống tự login CRM mock và tạo lead thành công.
