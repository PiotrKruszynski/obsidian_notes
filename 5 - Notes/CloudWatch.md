Created: 2026-02-28  16:37
___
Note:

>[!tip]
>definition

- _log groups_ : arbitary name, usually representing an application
- _log stream_: instance within application / log files / container
- can define log expiration policies
- CloudWatch Logs can senf logs to:
	- [[Amazon S3]]
	- [[Kinesis Data Streams]]
	- [[Amazon Data Firehose]]
	- [[AWS Lambda]]
	- _OpenSearch_
- Logs are encrypted by default
- Can setup _KMS_-based encryption with your own keys

# Source
What types of logs can go to Cl



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
