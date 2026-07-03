# Implementation Plan — DevOps Testing Agent (Outline)

> **Status:** Skeleton — chưa bắt đầu implement.

## Prerequisites

- Hoàn thành Project 1 (hoặc ít nhất Phase 0 — Bedrock access)
- GitHub account + sample repo
- Slack workspace (optional, cho SNS notification)

## Phases (planned)

| Phase | Mục tiêu | Deliverable |
|-------|----------|-------------|
| **0 — Setup** | Sample repo, Bedrock access, GitHub webhook | Repo + webhook configured |
| **1 — Review bot** | CodeBuild + Bedrock security review | PR comment với findings |
| **2 — Test generation** | Cypress test file generation | Generated test in PR comment |
| **3 — Notification** | SNS → Slack integration | Team alert on review complete |
| **4 — Pipeline** | Full CodePipeline hoặc GitHub Actions workflow | End-to-end automated |
| **5 — Polish** | Severity gating, demo script | Interview-ready demo |

## Phase 0 — Setup

- [ ] Tạo sample microservice repo (1 REST API, 3–5 endpoints)
- [ ] Thêm intentional security issues cho demo (SQL injection pattern, hardcoded secret)
- [ ] Configure GitHub webhook hoặc CodeStar connection
- [ ] Verify Bedrock access

## Phase 1 — Security Review Bot

- [ ] CodeBuild project với buildspec.yml
- [ ] Script: extract PR diff → format prompt
- [ ] Bedrock call với `security-review` prompt
- [ ] Parse response → markdown comment
- [ ] GitHub API: post PR comment
- [ ] Test: tạo PR với vulnerable code → bot phát hiện

## Phase 2 — Test Generation

- [ ] Prompt: analyze new endpoints → generate Cypress tests
- [ ] Output: `cypress/e2e/{feature}.cy.js` content
- [ ] Post generated test as PR comment (hoặc commit to branch)
- [ ] Test: PR thêm endpoint mới → bot sinh test scaffold

## Phase 3 — SNS Notification

- [ ] SNS topic `pr-review-complete`
- [ ] Slack incoming webhook subscription
- [ ] Message: PR URL, findings summary, severity counts

## Phase 4 — Full Pipeline

- [ ] CodePipeline: Source → Build → Deploy (notify only)
- [ ] Trigger: PR opened, synchronize
- [ ] Buildspec stages: lint → review → notify
- [ ] Error handling: Bedrock timeout, GitHub API rate limit

## Phase 5 — Polish

- [ ] Severity-based behavior: CRITICAL → warning label on PR
- [ ] Exclude patterns: không review generated files, lock files
- [ ] Demo script: tạo PR → show bot comment trong 2 phút
- [ ] Interview talking points

## Sample buildspec.yml (outline)

```yaml
version: 0.2
phases:
  pre_build:
    commands:
      - pip install boto3 requests
      - python scripts/extract_diff.py
  build:
    commands:
      - python scripts/bedrock_review.py --type security
      - python scripts/bedrock_review.py --type test-gen
  post_build:
    commands:
      - python scripts/post_pr_comment.py
      - python scripts/notify_sns.py
```

## Risks

| Risk | Mitigation |
|------|------------|
| AI false positives | Severity levels, advisory mode default |
| GitHub API rate limit | Cache, batch comments |
| Large PR diff exceeds token limit | Chunk by file, prioritize changed lines |
| Generated tests không chạy được | Scaffold only, dev refine |

## Definition of Done

1. Tạo PR → bot comment security findings trong < 3 phút
2. Bot sinh Cypress test scaffold cho endpoint mới
3. Slack notification khi review xong
4. Giải thích DevSecOps value trong 5 phút phỏng vấn
