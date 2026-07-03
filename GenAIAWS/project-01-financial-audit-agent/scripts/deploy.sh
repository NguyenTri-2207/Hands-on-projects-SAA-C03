#!/usr/bin/env bash
set -euo pipefail

ENV="${1:-dev}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
TEMPLATE_DIR="$PROJECT_DIR/infrastructure/templates"
STACK_NAME="financial-audit-agent-${ENV}"
PROFILE="${AWS_PROFILE:-saa-c03-dev}"
REGION="${AWS_REGION:-us-east-1}"

PARAMS_FILE="$PROJECT_DIR/infrastructure/parameters/${ENV}.json"

if [[ ! -f "$PARAMS_FILE" ]]; then
  echo "Error: Parameters file not found: $PARAMS_FILE"
  exit 1
fi

ENVIRONMENT=$(jq -r '.Environment' "$PARAMS_FILE")
PROJECT_NAME=$(jq -r '.ProjectName' "$PARAMS_FILE")
BEDROCK_MODEL_ID=$(jq -r '.BedrockModelId' "$PARAMS_FILE")

echo "Deploying stack: $STACK_NAME"
echo "  Region:  $REGION"
echo "  Profile: $PROFILE"
echo "  Model:   $BEDROCK_MODEL_ID"

# Upload nested templates to S3 (required for nested stacks with TemplateURL)
# For local dev, use --template-file with sam/cfn deploy after packaging.
# Phase 1: deploy storage stack standalone for faster iteration:
#
# aws cloudformation deploy \
#   --template-file "$TEMPLATE_DIR/storage.yaml" \
#   --stack-name "${STACK_NAME}-storage" \
#   --parameter-overrides Environment="$ENVIRONMENT" ProjectName="$PROJECT_NAME" \
#   --profile "$PROFILE" --region "$REGION"

aws cloudformation deploy \
  --template-file "$TEMPLATE_DIR/master.yaml" \
  --stack-name "$STACK_NAME" \
  --parameter-overrides \
    Environment="$ENVIRONMENT" \
    ProjectName="$PROJECT_NAME" \
    BedrockModelId="$BEDROCK_MODEL_ID" \
  --capabilities CAPABILITY_NAMED_IAM \
  --profile "$PROFILE" \
  --region "$REGION"

echo ""
echo "Stack deployed. Fetching outputs..."
aws cloudformation describe-stacks \
  --stack-name "$STACK_NAME" \
  --query "Stacks[0].Outputs" \
  --output table \
  --profile "$PROFILE" \
  --region "$REGION"
