Created: 2026-02-17  13:11
___
Note:

>[!tip]
>powiadomienie, np.:
>-  **S3:ObjectCreated, S3:ObjectRemoved, S3:ObjectRestore, and S3:Replication**,. 
>
These notifications can be delivered directly to three primary AWS targets: 
**[[AWS Lambda]], 
[[Amazon SQS queues]], 
[[Amazon SNS topics]]**, 
>
The target resource must have a **Resource-based Policy** (such as a Lambda Resource Policy or SQS/SNS Access Policy) that explicitly allows the S3 service (`s3.amazonaws.com`) to perform the action.




![[Pasted image 20260217133035.png]]

**Key Features and Configurations**

• **Filtering:** You can refine which objects trigger notifications using **object name filtering**, such as only triggering an event for files ending in `.jpg`,.

• **Latency:** Notifications are typically delivered in seconds but can sometimes take a minute or longer.

• **Permissions:** For S3 to successfully send a notification, the target resource must have a **Resource-based Policy** (such as a Lambda Resource Policy or SQS/SNS Access Policy) that explicitly allows the S3 service (`s3.amazonaws.com`) to perform the action.

• **Fan-out Pattern:** You are limited to **one S3 Event rule per unique combination of event type and prefix** (e.g., `images/`). If you need to send the same S3 event to multiple SQS queues or targets, you should use a **fan-out architecture** by sending the event to an SNS topic with multiple subscribers,.

**Integration with Amazon EventBridge**

As an alternative to direct SQS/SNS/Lambda targets, you can send all S3 events to **Amazon EventBridge**,. This integration provides several advanced capabilities:

• **Advanced Filtering:** Use JSON rules to filter events based on **metadata, object size, or specific names**,.

• **Expanded Targets:** EventBridge can route S3 events to over **18 AWS services**, including Step Functions and Kinesis Data Streams,.

• **Reliability:** It supports **archiving and replaying events**, ensuring reliable delivery for complex workflows,.

![[Pasted image 20260217133731.png]]

**Common Use Cases and Monitoring**

• **Serverless Pipelines:** A frequent use case is triggering a Lambda function to **generate image thumbnails** immediately after an upload or initiating an **AWS Glue ETL job**,,.

• **Security:** Services like **Amazon Macie** integrate with these events to alert users when sensitive data (PII) is discovered in S3 buckets,.

• **Audit and Visibility:** **Amazon S3 Storage Lens** provides metrics to identify which buckets have event notifications enabled via the `EventNotificationEnabledBucketCount` metric.

• **Compliance:** While event notifications provide real-time triggers, **AWS CloudTrail** can be used to record object-level activity (Data Events) for long-term auditing and compliance, though this is not enabled by default due to high volume,.


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
