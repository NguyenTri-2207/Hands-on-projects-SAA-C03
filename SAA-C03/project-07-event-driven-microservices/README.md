# Project 7: Event-Driven Microservices

Order processing decoupled — SNS fan-out → SQS → Lambda.

**Trạng thái:** Chờ triển khai

## Mục tiêu

- Order placed event → SNS topic
- Fan-out: payment queue, email queue, inventory queue
- Lambda consumers xử lý async, fail isolated

## AWS Services

SNS, SQS, Lambda, EventBridge (optional)

## SAA-C03 focus

Decoupling applications — câu hỏi kinh điển đề thi

## Docs

- [ARCHITECTURE.md](docs/ARCHITECTURE.md)
- [PLAN.md](docs/PLAN.md)
