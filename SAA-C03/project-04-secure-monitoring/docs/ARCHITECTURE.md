# Architecture — Secure Monitoring (Outline)

```mermaid
flowchart TD
    Users[IAM Users/Roles] -->|least privilege| Resources[EC2 S3 Lambda]
    KMS[KMS CMK] -->|encrypt| S3[S3]
    KMS -->|encrypt| EBS[EBS]
    API[All API calls] --> CloudTrail[CloudTrail]
    CloudTrail --> S3Logs[Audit S3 Bucket]
    Metrics[EC2 Metrics] --> CW[CloudWatch Alarms]
    CW --> SNS[SNS Email Alert]
    GuardDuty[GuardDuty] --> SNS
```

## Layers

| Layer | Control |
|-------|---------|
| Identity | IAM policies, roles per service |
| Encryption | KMS CMK on S3 + EBS |
| Audit | CloudTrail multi-region |
| Detect | GuardDuty findings |
| Alert | CloudWatch → SNS |

## Prerequisite

Hạ tầng từ [Project 1](../project-01-3tier-ha-web/) hoặc tương đương.
