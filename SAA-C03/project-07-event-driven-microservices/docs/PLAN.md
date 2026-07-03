# Plan — Event-Driven (Outline)

## Phase A — Messaging

- [ ] SNS topic `order-placed`
- [ ] 3 SQS queues subscribe to topic

## Phase B — Consumers

- [ ] Lambda payment / email / inventory handlers
- [ ] Event source mapping SQS → Lambda

## Phase C — Error handling

- [ ] DLQ cho mỗi queue
- [ ] Simulate 1 consumer fail → others still process

## Phase D — Test

- [ ] Publish test order event
- [ ] Verify 3 Lambdas invoked independently

## Done khi

Demo fan-out + isolated failure + DLQ message.
