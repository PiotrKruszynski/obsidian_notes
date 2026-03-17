Created: 2026-03-17  22:10
___
Note:

>[! ]
>- provides governance, compiliance and audit for your AWS Account
>- enabled by default
>- get history of events / API calls made within your AWS Account by:
>	- console, SDk, CLI , AWS Services
>- can put logs from CloudTrauk unti CloudWatch Logs

#### If a resource is deleted in AWS, investigate CloudTrail first!

# Rodzaje eventów:
- managenet events
- data events -> by default are not logged because of high volume operations
- CloudTrail Insights Events -> for unusual patterns

# Integration with EventBridge

jak cos na DB to podłączamy CloudTrail -> EventBridge -> SNS do powiadomienia

jak user przyjmuje role IAM -> CloudTrail -> EventBridge -> SNS

podobnie EC2





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
