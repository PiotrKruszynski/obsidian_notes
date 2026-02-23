Created: 2026-02-23  15:39
___
Note:

>[!tip]
>A "Pub/Sub" (Publish/Subscribe) service where one message can be sent to many receivers.

![[Pasted image 20260223154121.png]]
[[Amazon SQS]] → kolejka, jeden konsument ciągnie, wiadomość czeka 
SNS → pub/sub, push do wielu naraz, wiadomość nie czeka

![[Pasted image 20260223155048.png]]

• **Subscribers:** A topic can have up to 12.5 million subscriptions, including SQS, Lambda, Kinesis Data Firehose, HTTP(S), SMS, and Email.

• **Characteristics:**
    ◦ **Push mechanism:** Data is pushed to subscribers immediately.
    ◦ **No persistence:** Data is lost if not delivered (unlike SQS).

• **Message Filtering:** Uses a JSON policy to filter which messages are sent to specific subscriptions.

# Architecture Pattern: Fan-Out

• **Process:** Push once to an SNS Topic and receive it in multiple SQS queues that are subscribers.

• **Benefits:** Fully decoupled, no data loss, and allows for delayed processing or retries via SQS.

• **Common Use Case:** Sending S3 Event Notifications to multiple SQS queues (since one S3 event rule only supports one destination, fan-out is required to bypass this)
![[Pasted image 20260223162512.png]]

![[Pasted image 20260223162544.png]]

![[Pasted image 20260223214028.png]]


Metadata:

```yaml
---
type: tool    # concept | service | comparison
language: aws
---
```

Status: #pending
Tags: #aws
