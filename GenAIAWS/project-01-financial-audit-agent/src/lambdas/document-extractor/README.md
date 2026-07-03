# document-extractor

**Trigger:** Step Functions task

## Responsibility

1. Read source file from S3 input bucket
2. Parse based on file type:
   - `.json` — direct load (Phase 2a)
   - `.xlsx` — openpyxl (Phase 2b)
   - `.pdf` — pdfplumber (Phase 2c, optional)
3. Normalize to extracted JSON schema (see `docs/DATA-MODEL.md`)
4. Write `staging/{jobId}/extracted.json` to staging bucket
5. Update DynamoDB metadata with `period`, `parser` info

## Input

```json
{
  "jobId": "abc-123-def",
  "s3InputKey": "uploads/abc-123-def/report.xlsx",
  "fileName": "report.xlsx"
}
```

## Output

```json
{
  "jobId": "abc-123-def",
  "s3StagingKey": "staging/abc-123-def/extracted.json",
  "lineItemCount": 12,
  "status": "extracted"
}
```

## Environment variables

| Var | Description |
|-----|-------------|
| `INPUT_BUCKET` | Source file bucket |
| `STAGING_BUCKET` | Extracted JSON bucket |
| `JOBS_TABLE` | DynamoDB table name |

## Dependencies (Phase 2b+)

```
openpyxl>=3.1.0
pdfplumber>=0.10.0
```

Package as Lambda layer for Excel/PDF support.
