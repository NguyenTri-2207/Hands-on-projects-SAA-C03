# Architecture — CloudFront CDN (Outline)

```mermaid
flowchart LR
    User[Global Users] --> CF[CloudFront Edge]
    WAF[WAF] --> CF
    CF -->|OAC| S3[S3 Origin]
    R53[Route 53] --> CF
    ACM[ACM Cert] --> CF
```

## Key configs

- **OAC:** S3 bucket policy chỉ allow CloudFront distribution
- **Cache behaviors:** TTL cho static assets (CSS/JS/images)
- **WAF:** AWS Managed Rules (Common, SQLi)
- **ACM:** Cert ở `us-east-1` nếu CloudFront global

## Exam hooks

- CloudFront vs API Gateway caching
- OAC vs OAI (legacy)
- Price class / edge locations
