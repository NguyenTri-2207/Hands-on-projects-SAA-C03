# agent-orchestrator

**Trigger:** Step Functions task

## Responsibility

Core agent loop — Bedrock Converse API with Tool Use:

1. Load `staging/{jobId}/extracted.json` from S3
2. Build messages with system prompt + financial data context
3. Call `bedrock-runtime:Converse` with `toolConfig`
4. If `stopReason == tool_use`:
   - Parse tool use blocks
   - Invoke `calculation-tools` Lambda (or inline handler)
   - Append tool results to messages
   - Loop (max `MAX_AGENT_ROUNDS`)
5. If `stopReason == end_turn`:
   - Parse final audit summary from model response
6. Write each tool call to DynamoDB `AUDIT#<step>`
7. Return audit status + findings count

## Input

```json
{
  "jobId": "abc-123-def",
  "s3StagingKey": "staging/abc-123-def/extracted.json"
}
```

## Output

```json
{
  "jobId": "abc-123-def",
  "auditStatus": "COMPLETED",
  "findingsCount": 2,
  "materialDiscrepancies": 1,
  "roundsUsed": 4
}
```

## Environment variables

| Var | Description |
|-----|-------------|
| `STAGING_BUCKET` | Staging JSON bucket |
| `JOBS_TABLE` | DynamoDB table |
| `BEDROCK_MODEL_ID` | Bedrock model ID |
| `CALCULATION_TOOLS_ARN` | Calculation Lambda ARN |
| `MAX_AGENT_ROUNDS` | Max tool-use iterations (default 10) |

## Key implementation notes

- Use `boto3.client('bedrock-runtime').converse()`
- Tool definitions loaded from `src/agent/tools/*.json`
- System prompt loaded from `src/agent/prompts/system.md`
- Never log raw financial values — only jobId + toolName
