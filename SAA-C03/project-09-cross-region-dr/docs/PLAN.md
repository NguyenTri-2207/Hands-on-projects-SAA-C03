# Plan — Cross-Region DR (Outline)

## Phase A — Primary (Region A)

- [ ] Minimal app stack (có thể reuse P1 đơn giản hóa)
- [ ] S3 bucket + RDS

## Phase B — Replication

- [ ] Enable S3 CRR → Region B bucket
- [ ] Create RDS cross-region read replica

## Phase C — Secondary (Region B)

- [ ] Standby app (scaled down hoặc stopped)
- [ ] Verify replica lag

## Phase D — Failover drill

- [ ] Route 53 health check + failover policy
- [ ] Simulate primary down
- [ ] Promote replica + verify traffic shift

## Phase E — Teardown

- [ ] Delete secondary resources first
- [ ] Delete primary

## Done khi

Giải thích được RPO/RTO + 4 DR strategies + demo failover concept.
