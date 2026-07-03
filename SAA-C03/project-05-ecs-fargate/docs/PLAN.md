# Plan — ECS Fargate (Outline)

## Phase A — Local

- [ ] Dockerize app nhỏ (Node/Python static)
- [ ] Test `docker run` local

## Phase B — ECR

- [ ] Create ECR repo
- [ ] Push image

## Phase C — ECS

- [ ] Cluster (Fargate)
- [ ] Task definition + service (desired count 2)
- [ ] ALB + target group

## Phase D — Test

- [ ] Kill task → service replaces
- [ ] Scale desired count
- [ ] Stop service khi xong lab

## Done khi

ALB serve traffic từ ≥2 Fargate tasks, unhealthy task auto-replaced.
