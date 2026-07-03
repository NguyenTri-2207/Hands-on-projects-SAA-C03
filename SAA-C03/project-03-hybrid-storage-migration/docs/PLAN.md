# Plan — Hybrid Storage (Outline)

## Phase A — S3 foundation

- [ ] S3 bucket + versioning
- [ ] Lifecycle policy (Standard → IA → Glacier)

## Phase B — Upload simulation

- [ ] Upload test files với metadata dates (hoặc đợi transition)
- [ ] Verify storage class trong S3 console

## Phase C — Storage Gateway (optional)

- [ ] Deploy File Gateway VM / appliance
- [ ] Mount share → backup lên S3

## Phase D — Cost review

- [ ] So sánh chi phí Standard vs IA vs Glacier trong Cost Explorer

## Done khi

Hiểu và demo được lifecycle transitions + giải thích storage class trade-offs.
