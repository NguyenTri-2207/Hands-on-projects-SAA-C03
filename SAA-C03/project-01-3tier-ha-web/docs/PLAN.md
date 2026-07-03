# Project Implementation Plan: 3-Tier Highly Available Web Architecture

## 📌 Phase 1: Networking & Core Infrastructure (VPC)

- [ ] **Create Custom VPC:** CIDR block `10.0.0.0/16`.
- [ ] **Subnet Segmentation:** Designate 6 subnets across 2 Availability Zones (AZ-a & AZ-b):
  - 2 Public Subnets (CIDR `10.0.1.0/24`, `10.0.2.0/24`) for Application Load Balancers (ALB) and NAT Gateways.
  - 2 Private Subnets (CIDR `10.0.3.0/24`, `10.0.4.0/24`) for EC2 Application Instances.
  - 2 Isolated Database Subnets (CIDR `10.0.5.0/24`, `10.0.6.0/24`) for RDS.
- [ ] **Internet Connectivity:** Deploy 1 Internet Gateway (IGW) attached to the VPC.
- [ ] **Outbound Connectivity (NAT):** Deploy 2 NAT Gateways (one per AZ in public subnets) to ensure _high availability_ and avoid single points of failure for private EC2 instances downloading dependencies.
- [ ] **Routing Tables:** - Configure Public Route Table (associated with public subnets) pointing to IGW (`0.0.0.0/0`).
  - Configure 2 Private Route Tables pointing to their respective NAT Gateways.

## 💻 Phase 2: Security & Compute Layer (EC2 & ASG)

- [ ] **Security Group (SG) Layering:**
  - `ALB-SG`: Allow HTTP/HTTPS (`80/443`) from `0.0.0.0/0`.
  - `Web-App-SG`: Allow HTTP (`80`) only from `ALB-SG`.
- [ ] **IAM Role Creation:** Create an EC2 Instance Profile with minimal permissions (e.g., AmazonSSMManagedInstanceCore) to avoid using SSH keys.
- [ ] **User Data Script:** Draft a bash script to automatically update OS, install Apache/Nginx, and fetch a dynamic `index.html` displaying the Instance ID and Availability Zone (crucial for visual demonstration in your video).
- [ ] **Launch Template Configuration:** Define AMI (Amazon Linux 3), Instance Type (t2.micro/t3.micro), SG, IAM Role, and User Data.
- [ ] **Auto Scaling Group (ASG) Deployment:** - Target private subnets across both AZs.
  - Set capacity limits: Desired = 2, Min = 2, Max = 4.
  - Target Tracking Policy: Scale out when average CPU utilization > 70%.

## 🔀 Phase 3: Traffic Management (ALB & Route 53)

- [ ] **Application Load Balancer:** Deploy an internet-facing ALB across public subnets.
- [ ] **Target Group:** Create a Target Group (HTTP port 80) and register the ASG.
- [ ] **Health Checks:** Configure path `/` with a 5-second interval and a healthy threshold of 2 consecutive successes.
- [ ] **Route 53 DNS Configuration:** Create a Public Hosted Zone for your domain and configure an **Alias Record** pointing directly to the ALB DNS name.

## 🗄️ Phase 4: Database Tier (RDS Multi-AZ)

- [ ] **Security Group Config:** `DB-SG` allowing MySQL/Aurora traffic (port `3306`) strictly from `Web-App-SG`.
- [ ] **DB Subnet Group:** Group the two isolated database subnets.
- [ ] **RDS Provisioning:** Launch a MySQL instance utilizing the **Multi-AZ deployment** feature (creates a synchronous secondary standby in the alternate AZ).
- [ ] **Application Integration:** Inject the RDS endpoint, username, and database credentials into the EC2 instances via environment variables or AWS Systems Manager Parameter Store.

## 🧪 Phase 5: Verification, Failover Testing & Teardown

- [ ] **DNS Resolution:** Verify the domain resolves correctly and the ALB balances traffic evenly between AZ-a and AZ-b upon browser refreshes.
- [ ] **ASG Auto-Healing Test:** Manually terminate one EC2 instance via the AWS Console. Observe if the ASG automatically provisions a replacement instance to maintain the desired state.
- [ ] **RDS Failover Test:** Initiate a manual reboot with failover on the RDS console. Measure downtime/recovery behavior of the web app.
- [ ] **Resource Teardown:** Script or document the cleanup sequence (ALB -> ASG -> RDS -> VPC) to avoid unexpected costs.
