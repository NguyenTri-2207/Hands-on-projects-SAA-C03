# Technical Design Document: 3-Tier Highly Available Web Architecture

## 1. Overview

This Technical Design Document (TDD) describes the implementation of a production-ready, highly available web architecture on Amazon Web Services (AWS). The architecture follows the industry-standard 3-tier model, separating presentation, application, and data layers across multiple Availability Zones to ensure fault tolerance and high availability.

The architecture diagram illustrates the complete infrastructure topology, showing the Custom VPC (10.0.0.0/16) spanning two Availability Zones, with traffic flowing from Web Users through Route 53 and the Internet Gateway to the Application Load Balancer, which distributes requests to EC2 App Tier instances managed by Auto Scaling Groups in private subnets, ultimately connecting to an RDS MySQL Primary/Standby pair with synchronous replication.

---

## 2. Goals and Non-Goals

### 2.1 Goals

- **High Availability**: Achieve 99.9%+ uptime through multi-AZ deployment of all critical components
- **Automatic Failover**: Enable seamless failover for both application (via ASG) and database (via RDS Multi-AZ) tiers
- **Scalability**: Support horizontal scaling of the application tier based on CPU utilization metrics
- **Security**: Implement defense-in-depth with layered security groups and network isolation
- **Cost Optimization**: Utilize right-sized instances (t2.micro/t3.micro) suitable for development/demonstration workloads
- **Operational Simplicity**: Leverage managed services (ALB, RDS, ASG) to reduce operational overhead

### 2.2 Non-Goals

- **Multi-Region Deployment**: This design is scoped to a single AWS region with two Availability Zones
- **Container Orchestration**: EC2-based deployment is used; Kubernetes/ECS integration is out of scope
- **CDN Integration**: CloudFront distribution is not included in this iteration
- **Advanced Monitoring**: While basic health checks are configured, comprehensive observability (APM, distributed tracing) is deferred
- **Database Read Replicas**: Only Multi-AZ standby is implemented; read scaling is not addressed

---

## 3. Architecture

### 3.1 Architecture Overview

The architecture implements a classic 3-tier pattern distributed across two Availability Zones (AZ-a and AZ-b) within a single AWS region.

| Tier             | Components                        | Subnet Type | Purpose                                               |
| ---------------- | --------------------------------- | ----------- | ----------------------------------------------------- |
| **Presentation** | Route 53, ALB, Internet Gateway   | Public      | DNS resolution, load balancing, internet connectivity |
| **Application**  | EC2 instances (ASG), NAT Gateways | Private     | Business logic execution, outbound internet access    |
| **Data**         | RDS MySQL (Primary/Standby)       | Isolated DB | Persistent data storage with synchronous replication  |

### 3.2 Network Architecture

#### 3.2.1 VPC Design

| Resource               | Configuration                     |
| ---------------------- | --------------------------------- |
| **VPC CIDR**           | 10.0.0.0/16 (65,536 IP addresses) |
| **Availability Zones** | 2 (AZ-a, AZ-b)                    |
| **Total Subnets**      | 6                                 |

#### 3.2.2 Subnet Allocation

| Subnet           | CIDR Block  | AZ   | Type     | Purpose                   |
| ---------------- | ----------- | ---- | -------- | ------------------------- |
| Public Subnet A  | 10.0.1.0/24 | AZ-a | Public   | ALB Node A, NAT Gateway A |
| Public Subnet B  | 10.0.2.0/24 | AZ-b | Public   | ALB Node B, NAT Gateway B |
| Private Subnet A | 10.0.3.0/24 | AZ-a | Private  | EC2 App Tier (ASG)        |
| Private Subnet B | 10.0.4.0/24 | AZ-b | Private  | EC2 App Tier (ASG)        |
| DB Subnet A      | 10.0.5.0/24 | AZ-a | Isolated | RDS MySQL Primary         |
| DB Subnet B      | 10.0.6.0/24 | AZ-b | Isolated | RDS MySQL Standby         |

#### 3.2.3 Routing Configuration

**Public Route Table:**

| Destination | Target           |
| ----------- | ---------------- |
| 10.0.0.0/16 | local            |
| 0.0.0.0/0   | Internet Gateway |

**Private Route Table A:**

| Destination | Target        |
| ----------- | ------------- |
| 10.0.0.0/16 | local         |
| 0.0.0.0/0   | NAT Gateway A |

**Private Route Table B:**

| Destination | Target        |
| ----------- | ------------- |
| 10.0.0.0/16 | local         |
| 0.0.0.0/0   | NAT Gateway B |

### 3.3 Compute Architecture

#### 3.3.1 Launch Template Specification

| Parameter          | Value                                             |
| ------------------ | ------------------------------------------------- |
| **AMI**            | Amazon Linux 3 (latest)                           |
| **Instance Type**  | t2.micro / t3.micro                               |
| **IAM Role**       | EC2InstanceProfile (AmazonSSMManagedInstanceCore) |
| **Security Group** | Web-App-SG                                        |
| **User Data**      | Bootstrap script (see Section 3.3.2)              |

#### 3.3.2 User Data Bootstrap Script

```bash
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Fetch instance metadata
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
AZ=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)

# Generate dynamic index.html
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head><title>3-Tier Architecture Demo</title></head>
<body>
<h1>Hello from AWS!</h1>
<p><strong>Instance ID:</strong> ${INSTANCE_ID}</p>
<p><strong>Availability Zone:</strong> ${AZ}</p>
</body>
</html>
EOF
```

#### 3.3.3 Auto Scaling Group Configuration

| Parameter                     | Value                              |
| ----------------------------- | ---------------------------------- |
| **Desired Capacity**          | 2                                  |
| **Minimum Capacity**          | 2                                  |
| **Maximum Capacity**          | 4                                  |
| **Target Subnets**            | Private Subnet A, Private Subnet B |
| **Health Check Type**         | ELB                                |
| **Health Check Grace Period** | 300 seconds                        |

**Scaling Policy:**

- **Type**: Target Tracking
- **Metric**: Average CPU Utilization
- **Target Value**: 70%
- **Scale-out Cooldown**: 300 seconds
- **Scale-in Cooldown**: 300 seconds

### 3.4 Load Balancing Architecture

#### 3.4.1 Application Load Balancer

| Parameter           | Value                            |
| ------------------- | -------------------------------- |
| **Scheme**          | Internet-facing                  |
| **IP Address Type** | IPv4                             |
| **Subnets**         | Public Subnet A, Public Subnet B |
| **Security Group**  | ALB-SG                           |

#### 3.4.2 Target Group Configuration

| Parameter                 | Value                   |
| ------------------------- | ----------------------- |
| **Target Type**           | Instance                |
| **Protocol**              | HTTP                    |
| **Port**                  | 80                      |
| **Health Check Path**     | /                       |
| **Health Check Interval** | 5 seconds               |
| **Healthy Threshold**     | 2 consecutive successes |
| **Unhealthy Threshold**   | 2 consecutive failures  |

### 3.5 Database Architecture

#### 3.5.1 RDS Configuration

| Parameter              | Value                     |
| ---------------------- | ------------------------- |
| **Engine**             | MySQL 8.0                 |
| **Deployment**         | Multi-AZ                  |
| **Instance Class**     | db.t3.micro               |
| **Storage**            | 20 GB gp3                 |
| **DB Subnet Group**    | DB Subnet A + DB Subnet B |
| **Security Group**     | DB-SG                     |
| **Backup Retention**   | 7 days                    |
| **Maintenance Window** | Sunday 03:00-04:00 UTC    |

#### 3.5.2 Replication Topology

As shown in the architecture diagram, the RDS MySQL Primary in DB Subnet A (10.0.5.0/24) maintains synchronous replication to the RDS MySQL Standby in DB Subnet B (10.0.6.0/24). Both EC2 App Tier instances perform R/W operations against the Primary endpoint.

---

## 4. Data Model

### 4.1 Infrastructure State

| Entity             | Storage                    | Lifecycle  |
| ------------------ | -------------------------- | ---------- |
| VPC Configuration  | AWS Control Plane          | Persistent |
| EC2 Instance State | Ephemeral (instance store) | Transient  |
| Application Data   | RDS MySQL                  | Persistent |
| Session Data       | Not implemented            | N/A        |

### 4.2 Credential Management

| Credential Type      | Storage Location    | Access Method                  |
| -------------------- | ------------------- | ------------------------------ |
| RDS Master Password  | AWS Secrets Manager | IAM-based retrieval            |
| DB Connection String | SSM Parameter Store | Environment variable injection |
| EC2 Instance Access  | SSM Session Manager | IAM role (no SSH keys)         |

---

## 5. API Design

### 5.1 External Interfaces

| Endpoint     | Protocol | Port | Source   |
| ------------ | -------- | ---- | -------- |
| Route 53 DNS | DNS      | 53   | Internet |
| ALB HTTPS    | HTTPS    | 443  | Internet |
| ALB HTTP     | HTTP     | 80   | Internet |

### 5.2 Internal Interfaces

| Interface | Protocol | Port | Source → Destination         |
| --------- | -------- | ---- | ---------------------------- |
| ALB → EC2 | HTTP     | 80   | ALB-SG → Web-App-SG          |
| EC2 → RDS | MySQL    | 3306 | Web-App-SG → DB-SG           |
| EC2 → NAT | HTTPS    | 443  | Private Subnet → NAT Gateway |

---

## 6. Security Considerations

### 6.1 Network Security

#### 6.1.1 Security Group Rules

**ALB-SG (Application Load Balancer):**

| Type     | Protocol | Port | Source    | Description         |
| -------- | -------- | ---- | --------- | ------------------- |
| Inbound  | TCP      | 80   | 0.0.0.0/0 | HTTP from internet  |
| Inbound  | TCP      | 443  | 0.0.0.0/0 | HTTPS from internet |
| Outbound | All      | All  | 0.0.0.0/0 | Allow all outbound  |

**Web-App-SG (EC2 Instances):**

| Type     | Protocol | Port | Source    | Description        |
| -------- | -------- | ---- | --------- | ------------------ |
| Inbound  | TCP      | 80   | ALB-SG    | HTTP from ALB only |
| Outbound | All      | All  | 0.0.0.0/0 | Allow all outbound |

**DB-SG (RDS):**

| Type     | Protocol | Port | Source     | Description              |
| -------- | -------- | ---- | ---------- | ------------------------ |
| Inbound  | TCP      | 3306 | Web-App-SG | MySQL from app tier only |
| Outbound | None     | -    | -          | No outbound required     |

### 6.2 Identity and Access Management

- **EC2 Instance Profile**: Minimal permissions via `AmazonSSMManagedInstanceCore` managed policy
- **No SSH Keys**: Instance access exclusively through AWS Systems Manager Session Manager
- **RDS Authentication**: Username/password stored in AWS Secrets Manager with rotation enabled

### 6.3 Data Protection

| Data State                       | Protection Mechanism             |
| -------------------------------- | -------------------------------- |
| Data at Rest (RDS)               | AWS KMS encryption (AES-256)     |
| Data in Transit (ALB → EC2)      | HTTP (internal VPC)              |
| Data in Transit (Internet → ALB) | TLS 1.2+ (when HTTPS configured) |

### 6.4 Network Isolation

- Database subnets have no route to the Internet Gateway
- Private subnets access internet only through NAT Gateways (outbound only)
- All cross-tier communication is restricted by security group references

---

## 7. Testing Strategy

### 7.1 Infrastructure Validation

| Test Case              | Method                            | Expected Result                 |
| ---------------------- | --------------------------------- | ------------------------------- |
| VPC Connectivity       | Deploy test EC2 in each subnet    | Successful ping between subnets |
| Internet Gateway       | curl from public subnet instance  | External connectivity confirmed |
| NAT Gateway            | curl from private subnet instance | Outbound connectivity confirmed |
| Route Table Validation | VPC Reachability Analyzer         | All paths verified              |

### 7.2 Load Balancer Testing

| Test Case            | Method                      | Expected Result                             |
| -------------------- | --------------------------- | ------------------------------------------- |
| DNS Resolution       | `nslookup <domain>`         | Returns ALB DNS name                        |
| Traffic Distribution | Multiple browser refreshes  | Instance ID alternates between AZs          |
| Health Check         | Stop Apache on one instance | Instance marked unhealthy, traffic rerouted |

### 7.3 Auto Scaling Testing

| Test Case    | Method                    | Expected Result                                |
| ------------ | ------------------------- | ---------------------------------------------- |
| Auto-Healing | Terminate EC2 via console | Replacement instance launched within 5 minutes |
| Scale-Out    | Stress test (CPU > 70%)   | Additional instance launched                   |
| Scale-In     | Remove load               | Instance count returns to desired (2)          |

### 7.4 Database Failover Testing

| Test Case           | Method                             | Expected Result                         |
| ------------------- | ---------------------------------- | --------------------------------------- |
| Multi-AZ Failover   | RDS console → Reboot with failover | Standby promoted; downtime < 60 seconds |
| Connection Recovery | Monitor application logs           | Automatic reconnection to new primary   |

---

## 8. Rollout Plan

### 8.1 Deployment Sequence

```
Phase 1: Networking (Day 1)
├── 1.1 Create VPC (10.0.0.0/16)
├── 1.2 Create 6 Subnets (Public, Private, DB × 2 AZs)
├── 1.3 Deploy Internet Gateway
├── 1.4 Deploy NAT Gateways (2)
└── 1.5 Configure Route Tables (3)

Phase 2: Security & Compute (Day 2)
├── 2.1 Create Security Groups (ALB-SG, Web-App-SG, DB-SG)
├── 2.2 Create IAM Role and Instance Profile
├── 2.3 Create Launch Template
└── 2.4 Deploy Auto Scaling Group

Phase 3: Traffic Management (Day 3)
├── 3.1 Deploy Application Load Balancer
├── 3.2 Create Target Group
├── 3.3 Register ASG with Target Group
└── 3.4 Configure Route 53 Alias Record

Phase 4: Database (Day 4)
├── 4.1 Create DB Subnet Group
├── 4.2 Deploy RDS Multi-AZ Instance
└── 4.3 Configure application connection strings

Phase 5: Validation (Day 5)
├── 5.1 Execute all test cases
├── 5.2 Document results
└── 5.3 Obtain sign-off
```

### 8.2 Rollback Procedures

| Phase   | Rollback Action                                             | Estimated Time |
| ------- | ----------------------------------------------------------- | -------------- |
| Phase 4 | Delete RDS instance, remove subnet group                    | 15 minutes     |
| Phase 3 | Delete ALB, Target Group, Route 53 record                   | 10 minutes     |
| Phase 2 | Delete ASG, Launch Template, IAM resources, Security Groups | 10 minutes     |
| Phase 1 | Delete NAT Gateways, IGW, Subnets, VPC                      | 15 minutes     |

### 8.3 Resource Teardown Sequence

To avoid dependency conflicts and unexpected charges, resources must be deleted in reverse order:

1. **Route 53** — Delete Alias record
2. **ALB** — Delete load balancer and target group
3. **ASG** — Delete Auto Scaling Group (terminates EC2 instances)
4. **Launch Template** — Delete template
5. **RDS** — Delete database instance (skip final snapshot for dev)
6. **NAT Gateways** — Delete both NAT Gateways
7. **Elastic IPs** — Release associated EIPs
8. **Internet Gateway** — Detach and delete
9. **Subnets** — Delete all 6 subnets
10. **Route Tables** — Delete custom route tables
11. **Security Groups** — Delete in order: DB-SG → Web-App-SG → ALB-SG
12. **VPC** — Delete VPC

---

## 9. Appendix

### 9.1 Cost Estimation (Monthly, us-east-1)

| Resource                    | Quantity | Estimated Cost     |
| --------------------------- | -------- | ------------------ |
| NAT Gateway                 | 2        | $65.00             |
| ALB                         | 1        | $22.00             |
| EC2 (t3.micro)              | 2        | $15.00             |
| RDS (db.t3.micro, Multi-AZ) | 1        | $28.00             |
| Data Transfer               | ~10 GB   | $1.00              |
| **Total**                   |          | **~$131.00/month** |

### 9.2 Reference Documents

- AWS Well-Architected Framework — Reliability Pillar
- Amazon VPC User Guide
- Amazon EC2 Auto Scaling User Guide
- Amazon RDS User Guide — Multi-AZ Deployments
