# Plan — Log Analytics (Outline)

## Phase A — Log collection

- [ ] EC2 với sample app generating logs
- [ ] Install CloudWatch Logs Agent
- [ ] Verify logs trong CloudWatch console

## Phase B — Streaming

- [ ] Kinesis Firehose delivery stream
- [ ] Subscription filter on Log Group

## Phase C — Analytics

- [ ] OpenSearch domain (t3.small.search — dev only)
- [ ] Firehose → OpenSearch index
- [ ] Create index pattern + basic dashboard

## Phase D — Query

- [ ] Generate errors → find in dashboard
- [ ] Teardown OpenSearch domain

## Done khi

Log flow end-to-end, query được ERROR logs trên dashboard.
