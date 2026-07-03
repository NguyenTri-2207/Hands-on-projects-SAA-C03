# Plan — 3-Tier HA Web (Outline)

## Phase A — VPC

- [ ] VPC + 2 AZ + public/private subnets
- [ ] Internet Gateway + NAT Gateway
- [ ] Route tables

## Phase B — Compute

- [ ] Launch template + ASG (min 2)
- [ ] ALB + target group + listener
- [ ] Security groups

## Phase C — Database

- [ ] RDS MySQL Multi-AZ (private subnet group)
- [ ] App connect string via env

## Phase D — DNS & test

- [ ] Route 53 alias → ALB
- [ ] Test failover: terminate 1 EC2 → ASG replaces
- [ ] Teardown hoặc stop để tiết kiệm

## Done khi

ALB phục vụ traffic qua ≥2 EC2, RDS Multi-AZ active, ASG auto-heal khi kill instance.
