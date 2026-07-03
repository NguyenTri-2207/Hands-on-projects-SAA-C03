# Project 1: 3-Tier Highly Available Web Architecture

Web 3 tầng HA + fault tolerance trên 2 Availability Zones.

**Trạng thái:** Chờ triển khai

## Mục tiêu

- Custom VPC: public + private subnets × 2 AZ
- ALB (public) → ASG EC2 (private) → RDS MySQL Multi-AZ
- Route 53 trỏ domain tới ALB

## AWS Services

VPC, EC2, ALB, ASG, Route 53, RDS (Multi-AZ)

## SAA-C03 focus

Resilient architectures — load balancing, auto scaling, Multi-AZ

## Docs

- [ARCHITECTURE.md](docs/ARCHITECTURE.md)
- [PLAN.md](docs/PLAN.md)
