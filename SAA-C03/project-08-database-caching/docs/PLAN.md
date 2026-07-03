# Plan — Database Caching (Outline)

## Phase A — Baseline

- [ ] RDS + EC2 app (query DB direct)
- [ ] Measure response time (no cache)

## Phase B — ElastiCache

- [ ] Redis cluster (private subnet)
- [ ] Security group: EC2 → Redis only

## Phase C — App code

- [ ] Implement cache-aside trong app
- [ ] TTL + cache invalidation on write

## Phase D — Compare

- [ ] Load test: cache hit vs miss latency
- [ ] Document hit ratio

## Done khi

Cache hit nhanh hơn rõ rệt, giải thích được 3 caching options trên đề thi.
