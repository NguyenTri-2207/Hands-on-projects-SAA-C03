# Runbook — Financial Audit Agent

Deploy, test, troubleshoot cho Project 1.

## Prerequisites

- Hoàn thành [aws-prerequisites.md](../../docs/aws-prerequisites.md)
- AWS CLI profile `saa-c03-dev` configured
- Region: `us-east-1`

## Deploy

### 1. Cập nhật parameters

Edit `infrastructure/parameters/dev.json`:

```json
{
  "Environment": "dev",
  "ProjectName": "financial-audit-agent",
  "BedrockModelId": "<YOUR_MODEL_ID_FROM_CONSOLE>"
}
```

### 2. Deploy stack

```bash
cd project-01-financial-audit-agent/scripts
chmod +x deploy.sh
./deploy.sh dev
```

Hoặc thủ công:

```bash
aws cloudformation deploy \
  --template-file infrastructure/templates/master.yaml \
  --stack-name financial-audit-agent-dev \
  --parameter-overrides \
    Environment=dev \
    ProjectName=financial-audit-agent \
    BedrockModelId=<YOUR_MODEL_ID> \
  --capabilities CAPABILITY_NAMED_IAM \
  --region us-east-1 \
  --profile saa-c03-dev
```

### 3. Lưu outputs

```bash
aws cloudformation describe-stacks \
  --stack-name financial-audit-agent-dev \
  --query "Stacks[0].Outputs" \
  --region us-east-1 \
  --profile saa-c03-dev \
  > cfn-outputs/dev.json
```

## Test End-to-End

### Phase 1 — Storage only

```bash
# Upload test file
aws s3 cp samples/financial-reports/sample-report.json \
  s3://<INPUT_BUCKET>/uploads/manual-test/sample-report.json \
  --profile saa-c03-dev

# Verify
aws s3 ls s3://<INPUT_BUCKET>/uploads/ --profile saa-c03-dev
```

### Phase 2 — Extract only

```bash
aws lambda invoke \
  --function-name financial-audit-agent-dev-document-extractor \
  --payload '{"jobId":"test-001","s3InputKey":"uploads/manual-test/sample-report.json"}' \
  --profile saa-c03-dev \
  response.json

cat response.json
```

### Phase 3 — Agent only

```bash
aws lambda invoke \
  --function-name financial-audit-agent-dev-agent-orchestrator \
  --payload '{"jobId":"test-001"}' \
  --profile saa-c03-dev \
  response.json
```

### Phase 4 — Full flow

```bash
# Upload triggers entire pipeline
aws s3 cp samples/financial-reports/sample-report.json \
  s3://<INPUT_BUCKET>/uploads/$(uuidgen)/sample-report.json \
  --profile saa-c03-dev

# Monitor Step Functions
aws stepfunctions list-executions \
  --state-machine-arn <STATE_MACHINE_ARN> \
  --profile saa-c03-dev

# Check DynamoDB
aws dynamodb get-item \
  --table-name financial-audit-agent-dev-jobs \
  --key '{"PK":{"S":"JOB#<jobId>"},"SK":{"S":"METADATA"}}' \
  --profile saa-c03-dev

# Download report
aws s3 cp s3://<OUTPUT_BUCKET>/reports/<jobId>/audit-report.md ./report.md \
  --profile saa-c03-dev
```

## Monitor

### CloudWatch Logs

```bash
# Ingest trigger logs
aws logs tail /aws/lambda/financial-audit-agent-dev-ingest-trigger \
  --follow --profile saa-c03-dev

# Agent orchestrator logs
aws logs tail /aws/lambda/financial-audit-agent-dev-agent-orchestrator \
  --follow --profile saa-c03-dev
```

### Step Functions Console

1. AWS Console → Step Functions → `financial-audit-agent-dev-orchestrator`
2. Click execution → Visual graph
3. Inspect input/output mỗi state

## Troubleshoot

### Bedrock AccessDeniedException

**Symptom:** Lambda log shows `AccessDeniedException` on `bedrock:Converse`

**Fix:**
1. Verify model access enabled in Bedrock console
2. Check Lambda execution role has `bedrock:InvokeModel` + `bedrock:Converse`
3. Verify `BedrockModelId` parameter matches enabled model
4. Check region — model phải available trong region deploy

### Bedrock ThrottlingException

**Symptom:** Intermittent failures during agent loop

**Fix:**
1. Step Functions retry policy should handle (check orchestration.yaml)
2. Giảm `max_tokens` trong Converse call
3. Thêm delay giữa rounds nếu vẫn throttle

### S3 Event Not Firing

**Symptom:** Upload file nhưng không có Step Functions execution

**Fix:**
1. Check S3 event notification config trên input bucket
2. Verify ingest-trigger Lambda permission cho S3 invoke
3. Check CloudWatch logs của ingest-trigger
4. File phải upload vào prefix `uploads/`

### Extraction Returns Empty JSON

**Symptom:** `extracted.json` rỗng hoặc missing lineItems

**Fix:**
1. Test với `sample-report.json` trước (Phase 2a)
2. Check file format — Excel cần openpyxl layer
3. Review parser logs trong document-extractor CloudWatch

### DynamoDB ConditionalCheckFailed

**Symptom:** Duplicate job creation error

**Fix:**
- Expected behavior cho idempotency — check nếu job đã tồn tại
- Nếu stuck ở `PROCESSING`, manually update status hoặc re-run

### Lambda Timeout

**Symptom:** `Task timed out after 30.00 seconds`

**Fix:**
1. Tăng timeout trong compute.yaml (max 900s)
2. Giảm agent maxRounds
3. Split agent loop across Step Functions states (recommended)

## Teardown

```bash
# Empty buckets first
aws s3 rm s3://<INPUT_BUCKET> --recursive --profile saa-c03-dev
aws s3 rm s3://<STAGING_BUCKET> --recursive --profile saa-c03-dev
aws s3 rm s3://<OUTPUT_BUCKET> --recursive --profile saa-c03-dev

# Delete stack
aws cloudformation delete-stack \
  --stack-name financial-audit-agent-dev \
  --region us-east-1 \
  --profile saa-c03-dev

# Wait for completion
aws cloudformation wait stack-delete-complete \
  --stack-name financial-audit-agent-dev \
  --profile saa-c03-dev
```

## Local Development

```bash
cd project-01-financial-audit-agent/scripts
./local-test.sh
```

Local test chạy calculation-tools logic và prompt rendering mà không cần AWS (chi tiết trong script).

## Useful Links

- [ARCHITECTURE.md](ARCHITECTURE.md)
- [DATA-MODEL.md](DATA-MODEL.md)
- [PLAN.md](PLAN.md)
- [AWS Bedrock Converse API](https://docs.aws.amazon.com/bedrock/latest/userguide/conversation-inference.html)
