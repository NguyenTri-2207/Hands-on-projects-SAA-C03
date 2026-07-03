# Architectural Design Document: 3-Tier Highly Available Web Architecture

> Chưa rõ dự án làm gì? Đọc trước: **[OVERVIEW.md](OVERVIEW.md)**

## 📊 Overview & Structural Layout

Kiến trúc này tuân thủ chặt chẽ **AWS Well-Architected Framework**, đảm bảo tính cô lập tối đa giữa các tầng mạng và khả năng tự phục hồi (_self-healing_) khi xảy ra sự cố ở cấp độ hạ tầng hoặc toàn bộ một Availability Zone (AZ).

```mermaid
graph TD
    User([🌐 Web Traffic / Users]) -->|DNS Query| R53[Route 53]
    R53 -->|Resolve Domain| ALB

    subgraph VPC [Custom VPC - 10.0.0.0/16]
        subgraph AZ_A [Availability Zone A]
            subgraph Pub_Subnet_A [Public Subnet A - 10.0.1.0/24]
                ALB_A[ALB Node A]
                NAT_A[NAT Gateway A]
            end
            subgraph Priv_Subnet_A [Private Subnet A - 10.0.3.0/24]
                EC2_A[EC2 Instance - App Tier]
            end
            subgraph DB_Subnet_A [DB Subnet A - 10.0.5.0/24]
                RDS_Primary[(RDS MySQL - Primary)]
            end
        end

        subgraph AZ_B [Availability Zone B]
            subgraph Pub_Subnet_B [Public Subnet B - 10.0.2.0/24]
                ALB_B[ALB Node B]
                NAT_B[NAT Gateway B]
            end
            subgraph Priv_Subnet_B [Private Subnet B - 10.0.4.0/24]
                EC2_B[EC2 Instance - App Tier]
            end
            subgraph DB_Subnet_B [DB Subnet B - 10.0.6.0/24]
                RDS_Standby[(RDS MySQL - Standby)]
            end
        end
    end

    User -->|HTTP/HTTPS| ALB[Application Load Balancer]
    ALB -->|Route Traffic| EC2_A
    ALB -->|Route Traffic| EC2_B
    EC2_A -->|Read/Write| RDS_Primary
    EC2_B -->|Read/Write| RDS_Primary
    RDS_Primary -.->|Synchronous Replication| RDS_Standby

    classDef public fill:#e1f5fe,stroke:#01579b,stroke-width:2px;
    classDef private fill:#efebe9,stroke:#4e342e,stroke-width:2px;
    classDef db fill:#efe8e0,stroke:#e65100,stroke-width:2px;
    class Pub_Subnet_A,Pub_Subnet_B public;
    class Priv_Subnet_A,Priv_Subnet_B private;
    class DB_Subnet_A,DB_Subnet_B db;
```
