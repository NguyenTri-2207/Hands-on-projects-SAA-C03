# report-generator

**Trigger:** Step Functions task (after agent audit completes)

## Responsibility

1. Query DynamoDB: all `AUDIT#*` items + `METADATA` for jobId
2. Compile findings into Markdown report (template in `docs/DATA-MODEL.md`)
3. Write `reports/{jobId}/audit-report.md` to output bucket
4. Write DynamoDB `JOB#<jobId> / REPORT` item
5. Update `METADATA.status` → `COMPLETED` or `NEEDS_REVIEW`

## Input

```json
{
  "jobId": "abc-123-def",
  "auditStatus": "COMPLETED",
  "findingsCount": 2
}
```

## Output

```json
{
  "jobId": "abc-123-def",
  "s3OutputKey": "reports/abc-123-def/audit-report.md",
  "status": "COMPLETED"
}
```

## Environment variables

| Var | Description |
|-----|-------------|
| `OUTPUT_BUCKET` | Report output bucket |
| `JOBS_TABLE` | DynamoDB table |

## Report sections

1. Header (jobId, source, period, status)
2. Summary (pass/warn/fail counts)
3. Findings (sorted by severity)
4. Audit trail table (all tool calls)
