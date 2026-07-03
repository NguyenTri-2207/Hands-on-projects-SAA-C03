# Architecture — Event-Driven (Outline)

```mermaid
flowchart TD
    Order[Order Placed] --> SNS[SNS Topic]
    SNS --> Q1[SQS Payment]
    SNS --> Q2[SQS Email]
    SNS --> Q3[SQS Inventory]
    Q1 --> L1[Lambda Payment]
    Q2 --> L2[Lambda Email]
    Q3 --> L3[Lambda Inventory]
```

## Pattern: SNS → SQS fan-out

- Mỗi subscriber = 1 SQS queue (durability + retry)
- Lambda poll SQS (batch size, DLQ on fail)
- 1 service fail không block service khác

## vs EventBridge

| SNS+SQS | EventBridge |
|---------|-------------|
| Simple fan-out | Complex routing rules |
| Push to SQS | Event bus pattern |

## Exam hooks

- SQS visibility timeout
- DLQ configuration
- FIFO vs Standard queue
