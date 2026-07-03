# Plan — Secure Monitoring (Outline)

## Phase A — IAM

- [ ] Review và tighten IAM policies
- [ ] Service roles cho EC2/Lambda (không dùng access keys)

## Phase B — Encryption

- [ ] Tạo KMS CMK
- [ ] Enable encryption S3 bucket + EBS volumes

## Phase C — Audit & detect

- [ ] Enable CloudTrail → S3
- [ ] Enable GuardDuty
- [ ] CloudWatch alarm CPU > 80% → SNS email

## Phase D — Verify

- [ ] Trigger alarm test
- [ ] Xem GuardDuty / CloudTrail sample events

## Done khi

Giải thích được least privilege + encryption + audit trail trên hạ tầng thật.
