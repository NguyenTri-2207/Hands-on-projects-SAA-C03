# Plan — Serverless Pipeline (Outline)

## Phase A — Storage + DB

- [ ] S3 bucket + DynamoDB table
- [ ] Sample CSV/JSON test file

## Phase B — Ingest

- [ ] Lambda parser (S3 trigger)
- [ ] Test upload → items in DynamoDB

## Phase C — API

- [ ] Cognito User Pool
- [ ] API Gateway + Cognito authorizer
- [ ] Lambda query handler

## Phase D — Test

- [ ] Upload + query end-to-end
- [ ] Verify unauthorized request bị reject

## Done khi

Upload file → data queryable qua API có auth.
