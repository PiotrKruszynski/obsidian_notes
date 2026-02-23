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
