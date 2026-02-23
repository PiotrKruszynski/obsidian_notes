Created: 2026-02-23  10:19
___
Note:

>[!tip]
>A fully managed service used to decouple applications

**Decoupling** → services communicate asynchronously to improve scalability and fault isolation

You can decouple your applications, 
• using SQS: queue model 
• using SNS: pub/sub model 
• using Kinesis: real-time streaming model

![[Pasted image 20260223110148.png]]

• **Standard Queue:**
    ◦ Unlimited throughput (MB/s) and unlimited messages in the queue.
    ◦ **Retention:** Default 4 days, maximum 14 days.
    ◦ **Message size:** Maximum 256 KB per message.
    ◦ **Delivery:** "At-least-once delivery" (occasionally duplicates may occur). BE PREPARE
    ◦ **Ordering:** "Best-effort ordering" (messages might arrive out of order). BE PREPARE

• **FIFO Queue (First-In-First-Out):**
    ◦ Guarantees strict ordering and exactly-once send capability.
    ◦ Limited throughput: 300 msg/s without batching, 3000 msg/s with batching.

• **Key Mechanisms:**
    ◦ **Visibility Timeout:** After being polled, a message becomes invisible to others for 30 seconds (default). If not deleted after processing, it becomes visible again.
    ◦ **Long Polling:** A consumer "waits" for messages to arrive (up to 20s), which decreases API calls and costs.
    ◦ **Auto Scaling:** You can scale an Auto Scaling Group (ASG) based on the `ApproximateNumberOfMessages` metric in CloudWatch




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
