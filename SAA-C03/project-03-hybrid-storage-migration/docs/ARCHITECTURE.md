# Architecture — Hybrid Storage (Outline)

```mermaid
flowchart LR
    Local[On-Prem / Local FS] -->|NFS/SMB| SGW[Storage Gateway]
    SGW --> S3[S3 Standard]
    S3 -->|30 days| IA[S3 Standard-IA]
    IA -->|90 days| Glacier[Glacier Flexible / Deep Archive]
```

## Lifecycle policy (ví dụ)

| Age | Transition |
|-----|------------|
| 0–30 days | S3 Standard |
| 30–90 days | S3 Standard-IA |
| 90+ days | Glacier Flexible Retrieval |

## Lưu ý

- Storage Gateway cần VM/agent — có thể simulate bằng AWS console upload nếu không có on-prem
- Glacier retrieval có latency + cost — hiểu retrieval tiers cho thi

## Chưa làm

- CFN lifecycle rules
- Storage Gateway setup guide chi tiết
