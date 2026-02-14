Created: 2026-02-15  00:25
___
Note:

>[! Important]
>definition



---

## Core Concepts

- **Developer-centric deployment service** → you upload code, AWS provisions infrastructure
- Uses underlying services: **EC2 + Auto Scaling Group + ELB + RDS + CloudWatch**
- Managed service → AWS handles provisioning, scaling, health monitoring, configuration
- You pay for underlying resources (Beanstalk itself is free)
- Full control over configuration still available

### Components

- **Application** → logical container for environments and versions
- **Application Version** → specific iteration of code
- **Environment** → collection of AWS resources running ONE application version
- Multiple environments supported (dev / test / prod)

### Environment Tiers

1. **Web Server Tier**
    - Uses ELB + ASG + EC2
    - Handles HTTP/HTTPS traffic
    - Scales based on metrics (CPU, etc.)
        
2. **Worker Tier**
    - Uses SQS queue
    - EC2 instances pull messages
    - Scales based on queue depth

---

## Deployment Modes

- **Single Instance** → one EC2 (dev, low cost, no HA)
- **High Availability** → ELB + ASG across Multi-AZ (production)    

High Availability = multi-AZ + Load Balancer + ASG

---

## Scaling Model

Beanstalk relies on:

- Auto Scaling Group (min / desired / max capacity)
- Launch Template (AMI, instance type, IAM role, SG, User Data)
- CloudWatch Alarms for scaling
    

### Scaling Policies (exam critical)

- Target Tracking → keep CPU at X%
- Step Scaling → react to alarm thresholds
- Scheduled Scaling → predictable events
- Predictive Scaling → forecasted load

Cooldown period default: 300 seconds

---

## Health Monitoring

- ELB performs health checks (HTTP 200 expected)
- Unhealthy instances are replaced by ASG
- Beanstalk monitors application health automatically

---

## Supported Platforms

- Java, Tomcat
- .NET (Windows / Linux)
- Node.js
- Python
- PHP
- Ruby
- Go
- Docker (single & multi-container)

---

## Instantiating Applications Quickly (Architectural Context)

Beanstalk combines:

- Golden AMI (pre-baked app)
- User Data (bootstrap configuration)
- ASG + ELB provisioning

Alternative acceleration patterns:

- RDS restore from snapshot
- EBS restore from snapshot

---

## Critical Rules / Defaults

- Beanstalk ≠ Serverless (still EC2 underneath)
- You must design for stateless architecture
- Store session data externally (ElastiCache / DB)
- Multi-AZ required for high availability
- Worker tier requires SQS
- ASG automatically re-creates terminated instances

---

## Common Exam Traps

- Thinking Beanstalk removes need for ASG → it configures ASG
- Assuming Beanstalk is cheaper → cost equals underlying resources
- Confusing Beanstalk with Lambda (Lambda = serverless, no EC2)
- Forgetting Multi-AZ for production
- Storing state on EC2 instance

---

## Exam Question Patterns

- "Developers don’t want to manage infrastructure" → Elastic Beanstalk
- "Deploy web app quickly with scaling and health checks" → Beanstalk
- "Background job processing with queue" → Worker Tier + SQS
- "Production-ready environment with HA" → ELB + ASG (Beanstalk HA mode)
- "Minimal ops overhead but still EC2-based" → Beanstalk

---

## Comparison Logic (Decision Tree)

If requirement is:

- Full EC2 control → EC2 + ASG manually
- Managed PaaS for web app → Beanstalk
- Containers with orchestration control → ECS / EKS
- Event-driven compute → Lambda


___
Metadata:

```yaml
---
type: tool    # concept | service | comparison
language: aws
---
```

Status: #pending
Tags: #aws
