# AWS Prerequisites

Checklist trước khi deploy bất kỳ dự án nào trong monorepo.

## 1. AWS Account

- [ ] Tạo AWS account (hoặc dùng account dev cá nhân)
- [ ] Bật MFA cho root user
- [ ] Tạo IAM user `saa-c03-dev` với programmatic access (không dùng root cho daily work)
- [ ] Gắn policy: `AdministratorAccess` (dev only) hoặc scoped policy cho CFN deploy

## 2. AWS CLI

```bash
aws configure --profile saa-c03-dev
# Region: us-east-1
# Output: json
```

Verify:

```bash
aws sts get-caller-identity --profile saa-c03-dev
```

## 3. Amazon Bedrock Model Access

1. Vào **AWS Console → Amazon Bedrock → Model access**
2. Request access cho:
   - **Anthropic Claude** (Sonnet — dùng cho P1, P2, P3)
   - **Amazon Titan Text Embeddings** (chỉ cần khi làm P2)
3. Đợi approval (thường vài phút đến vài giờ)

Verify model ID:

```bash
aws bedrock list-foundation-models \
  --region us-east-1 \
  --by-provider anthropic \
  --query "modelSummaries[?contains(modelId,'claude')].modelId" \
  --profile saa-c03-dev
```

> **Lưu ý:** Tên "Claude Sonnet 5" trong tài liệu marketing có thể khác model ID trên Bedrock. Luôn dùng ID từ console, truyền qua CloudFormation parameter `BedrockModelId`.

## 4. Budget Alert

1. **AWS Billing → Budgets → Create budget**
2. Type: Cost budget — $15/tháng (điều chỉnh theo nhu cầu)
3. Alert tại 50%, 80%, 100%
4. Email notification

## 5. Region

| Region | Khuyến nghị | Lý do |
|--------|-------------|-------|
| `us-east-1` | **Default** | Bedrock model availability tốt nhất |
| `ap-southeast-1` | Optional | Gần VN, nhưng ít model hơn |

## 6. Quyền IAM tối thiểu cho deploy P1

IAM user/role cần quyền tạo:

- CloudFormation stacks (full)
- S3, DynamoDB, Lambda, IAM roles, Step Functions
- Bedrock `InvokeModel`, `Converse`
- CloudWatch Logs

## 7. Local dev tools

- [ ] Python 3.12+
- [ ] `pip` / `venv`
- [ ] AWS CLI v2
- [ ] Git
- [ ] Editor (VS Code / Cursor)

Optional cho P1 Phase 2:

- `openpyxl` (Excel parsing)
- `pdfplumber` (PDF parsing)

## 8. Security checklist

- [ ] Không commit `.env`, credentials, access keys
- [ ] Dùng IAM role cho Lambda (không hardcode keys)
- [ ] Sample data chỉ dùng số liệu giả (dummy)
- [ ] Xóa resources sau khi demo xong (tránh chi phí phát sinh)

## Next step

→ [project-01-financial-audit-agent/docs/PLAN.md](../project-01-financial-audit-agent/docs/PLAN.md) — Phase 0
