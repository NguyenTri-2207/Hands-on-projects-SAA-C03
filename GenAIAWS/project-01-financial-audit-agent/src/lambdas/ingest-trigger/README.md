# ingest-trigger

**Trigger:** S3 `ObjectCreated` event on input bucket (`uploads/` prefix)

## Responsibility

1. Parse S3 event → extract bucket, key, fileName
2. Generate `jobId` (UUID v4)
3. Idempotency check — skip if job already exists for same key
4. Write DynamoDB `JOB#<jobId> / METADATA` with `status: PENDING`
5. Start Step Functions execution with payload `{ jobId, s3InputKey, fileName }`
6. Update status → `PROCESSING`

## Input (S3 event)

```json
{
  "Records": [{
    "s3": {
      "bucket": { "name": "financial-audit-agent-dev-input-123" },
      "object": { "key": "uploads/abc-123/report.xlsx" }
    }
  }]
}
```

## Output

```json
{
  "jobId": "abc-123-def",
  "executionArn": "arn:aws:states:..."
}
```

## Environment variables

| Var | Description |
|-----|-------------|
| `JOBS_TABLE` | DynamoDB table name |
| `STATE_MACHINE_ARN` | Step Functions ARN |
| `INPUT_BUCKET` | Input bucket name |

## Files

- `handler.py` — Lambda entry point (implement Phase 4)
- `requirements.txt` — empty (stdlib only)
