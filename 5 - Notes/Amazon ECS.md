Created: 2026-02-04  20:50
___
Note:

>[! Important]
>AWSowy orkiestrator kontenerów, prosty i w pełni zarządzany przez AWS


• **Docker Support:** ECS allows you to launch Docker containers, which are packaged applications that run the same regardless of the environment.

• **Cluster:** A logical grouping of tasks or services.

• **ECS Tasks:** These are the running instances of your containers defined in a **Task Definition**.

![[Pasted image 20260224090752.png]]

# ECS Launch Types

AWS offers two primary ways to launch your containerized applications:

• **EC2 Launch Type:**
    ◦ You are responsible for provisioning and maintaining the underlying infrastructure (EC2 instances).
    ◦ Each EC2 instance must run the **ECS Agent** to register itself with the ECS Cluster.
    ◦ You manage the cost and optimization of the instances.

• **Fargate Launch Type (Serverless):**
    ◦ You do not manage or provision servers.
    ◦ It is all **Serverless**; you just define the CPU and RAM requirements for your tasks.
    ◦ AWS automatically runs and scales the tasks for you.
    ◦ _(Wyjaśnienie: Fargate to model bezserwerowy – nie widzisz maszyn EC2 pod spodem, po prostu płacisz za działające kontenery)._

![[Pasted image 20260224090830.png]]

# ECS IAM Roles

Security is managed through specific IAM roles assigned at different levels:

• **EC2 Instance Profile (EC2 Launch Type only):** Used by the ECS agent to make API calls to the ECS service, send logs to CloudWatch, and pull images from Amazon ECR.

• **ECS Task Role:** Allows the application inside the container to access other AWS services like S3 or DynamoDB. This is defined in the Task Definition.

• _(Wskazówka: Zawsze używaj Task Role dla uprawnień specyficznych dla aplikacji, zamiast nadawać uprawnienia całej instancji EC2)._

![[Pasted image 20260224090913.png]]

# ECS Auto Scaling

ECS supports scaling at two different levels to handle varying traffic:

• **ECS Service Auto Scaling (Task Level):** Automatically increases or decreases the number of ECS tasks based on metrics like **Average CPU Utilization**, **Average Memory Utilization**, or **ALB Request Count**.

• **EC2 Auto Scaling (Infrastructure Level):** For the EC2 launch type, you must scale the underlying instances using an **Auto Scaling Group (ASG)** or **ECS Cluster Capacity Providers**.

• **Capacity Providers:** Used to automatically provision and scale the infrastructure for your ECS tasks based on their requirements.

# ECS Storage and Data Volumes

While containers are ephemeral, ECS supports persistent storage:

• **Amazon EFS (Elastic File System):** You can mount EFS file systems directly onto ECS tasks.

• **Compatibility:** This works for both EC2 and Fargate launch types.

• **Multi-AZ:** Tasks running in different Availability Zones can share the same data in the EFS file system.

• **Note:** Amazon S3 **cannot** be mounted as a native file system in ECS.

Load Balancer Integrations

ECS integrates tightly with Elastic Load Balancing (ELB) to distribute traffic:

• **Application Load Balancer (ALB):** Recommended for most use cases (Layer 7).

• **Network Load Balancer (NLB):** Recommended for high-throughput or high-performance use cases.

• **Classic Load Balancer (CLB):** Supported but not recommended and does not support Fargate.

# Event-Driven Architecture with ECS

ECS can be part of an event-driven workflow using **Amazon EventBridge**:

• **Task Invocation:** EventBridge can trigger an ECS task based on a **Schedule** (cron job) or an **Event Pattern** (e.g., when a file is uploaded to S3).

• **Monitoring:** EventBridge can intercept events like **Stopped Tasks** to trigger notifications (via SNS) to administrators.

# Amazon ECR (Elastic Container Registry)

• **Purpose:** A fully managed Docker container registry to store and manage your images.

• **Integration:** ECS pulls images directly from ECR to launch tasks.

• **Security:** Access is controlled via IAM, and it supports image vulnerability scanning.



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
