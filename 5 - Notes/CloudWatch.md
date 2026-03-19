Created: 2026-02-28  16:37
___
Note:

>[!tip]
>- search and analyze log data stored in CloudWatch Logs
>- it's a query engine, not a real-time engine (only query historical data when you run the query)
>- can query multiple Log Groups in different AWS account
>- _Log Subscription_ for real-time log events, filter by _Subscriptio Filter_
>- _Cross-Account Subscription_ - to send log events to resources in a diffrent AWS account . Use _Subscription Filter_ and _Subscription Destination_
>- CloudWatch Events to teraz _Amazon EventBridge_

- _log groups_ : arbitory name, usually representing an application
- _log stream_: instance within application / log files / container
- can define log expiration policies
- CloudWatch Logs can send logs to:
	- [[Amazon S3]]
	- [[Kinesis Data Streams]]
	- [[Amazon Data Firehose]]
	- [[AWS Lambda]]
	- _OpenSearch_
- Logs are encrypted by default
- Can setup _KMS_-based encryption with your own keys
# Source
What types of logs can go to CloudWatch:
- SDK, CloudWatch Log Agent, CloudWatch Unified Agent
- [[Elastic Beanstalk]]
- [[AWS Lambda]]
- VPC flow logs
- [[Amazon API Gateway]]
- CloudTrail based on filter
- [[AWS Route 53]]
# To watch
CloudWatch Logs Insights

# Export
logs -> S3
- log data can take up to 12 hours
- API call to iniciate is _CreateExportTask_
- it's a _butch_ export not near-real time or real-time
- _Logs Subscriptions_: get a real-time log events, can be _Subscription Filter_
	- [[Kinesis Data Streams]]
	- [[Amazon Data Firehose]]
	- [[AWS Lambda]]

# Live Tail

button "Start tailing"

# CloudWatch Agent
small program that will push the log file where you want
by default no logs go from one to another
make sure [[IAM]] permissions are correct
_CloudWatch Logs Agent_ is small linux program
- in old version of agent
_Unified Aget_:
- collect additional system-level metric such as RAM, process
- collect logs to sent to CloudWatch Logs
- centralized configuration using _SSM Parameter Store_

# CloudWatch Alarms
- used to trigger notifications for any metric
- various options (sampling, %, max, min, ect.)
- alarm state: OK, INSUFFICIENT_DATA, ALARM
- main targets:
	- stop, terminate, reboot or recover [[Amazon EC2]] Instance
	- trigger [[Auto Scaling]] action
	- send notification to [[Amazon SNS]] from which you can do anything!
- _Composite Alarm_
	- action of combine with AND , OR conditions

#### do EC2, EC2 Auto Scaling, Amazon SNS
## CloudWatch Alarms - EC2 Instance Action
- Status Check:
	- Instance status = check the EC2 VM
	- System status = check the underlying hardware
	- Attached EBS status = check attached EBS volumes 
- Recovery: Same Private, Public, Elastic IP, metadata, placement group
_alarm bezpośrednio wykonuje akcje na instancji!_
- reboot, recover, stop, terminate
## CloudWatch Alarm - good to know
- Alarms can be created based on CloudWatch Logs Metrics Filters
- To test alarms and notifications, set the alarm state to Alarm using CLI 
aws cloudwatch set-alarm-state --alarm-name "myalarm" --state-value ALARM --state-reason "testing purposes"

# CloudWatch Network Synthetic Monitor
- monitor and detect network issues between your app hosted on AWS and your on-premises data center
- identify any network performance degradation
- no agents required
- tests _ICMP_  `protokół warstwy sieci` or _TCP_  `protokół warstwy transportu` traffic to IPv4 on-premises destinations through _Direct Connect_ or _S2S VPN_

## CloudWatch Container Insights
- Collect, aggregate, summarize metrics and logs from containers
- Available for containers on…
- Amazon Elastic Container Service (Amazon ECS)
- Amazon Elastic Kubernetes Services (Amazon EKS)

- Fargate (both for ECS and EKS)
- In Amazon EKS and Kubernetes, CloudWatch Insights is using a containerized version of the CloudWatch Agent to discover containers

## CloudWatch Lambda Insights
- Monitoring and troubleshooting solution for serverless applications running on AWS Lambda
- Collects, aggregates, and summarizes system-level metrics including CPU time, memory, disk, and network
- Collects, aggregates, and summarizes diagnostic information such as cold starts and Lambda worker shutdowns
- Lambda Insights is provided as a Lambda Layer

## CloudWatch Contributor Insights
- Analyze log data and create time series that display contributor data. VPC Flow Logs
- See metrics about the top-N contributors
- The total number of unique contributors, and their usage.
- This helps you find top talkers and understand who or what is impacting system performance.
- Works for any AWS-generated logs (VPC, DNS, etc..)
- For example, you can find bad hosts, identify the heaviest network users, or find the URLs that generate the most errors.
- You can build your rules from scratch, or you can also use sample rules that AWS has created –
- CloudWatch also provides built-in rules that you can use to analyze metrics from other AWS services.

## CloudWatch Application Insights
- Provides automated dashboards that show potential problems with monitored applications, to help isolate ongoing issues
- Your applications run on Amazon EC2 Instances with select technologies only (Java, .NET, Microsoft IIS Web Server, databases…)
- And you can use other AWS resources such as Amazon EBS, RDS, ELB, ASG, Lambda, SQS, DynamoDB, S3 bucket, ECS, EKS, SNS, API Gateway…
- Powered by SageMaker
- Enhanced visibility into your application health to reduce the time it will take you to troubleshoot and repair your applications
- Findings and alerts are sent to Amazon EventBridge and SSM OpsCenter

## CloudWatch Insights and Operational Visibility
- ECS, EKS, Kubernetes on EC2, Fargate, needs agent for Kubernetes
- CloudWatch Lambda Insights
- Detailed metrics to troubleshoot serverless applications
- CloudWatch Contributors Insights
- Find “Top-N” Contributors through
- CloudWatch Application Insights
- Automatic dashboard to troubleshoot your application and related AWS services

|Cecha|Amazon CloudWatch|Amazon EventBridge|Amazon Simple Notification Service|Amazon Simple Queue Service|AWS Step Functions|
|---|---|---|---|---|---|
|Główna rola|monitoring i metryki|event routing|broadcast powiadomień|kolejka wiadomości|orchestracja workflow|
|Model działania|metryki → alarm|event → rule → target|pub/sub|producer → queue → consumer|state machine|
|Czy przechowuje dane|tylko metryki/logi|nie|nie|tak|stan workflow|
|Push / Pull|push (alarm)|push|push|pull|push|
|Filtrowanie|proste|bardzo zaawansowane|proste|brak|logika workflow|
|Ordering|brak|brak|brak|FIFO opcjonalnie|kontrolowany|
|Retencja|logi do 10 lat|krótka|brak|do 14 dni|runtime workflow|
|Fan-out|przez SNS|natywnie|natywnie|nie|nie|
|Automatyczne akcje|tak|tak|nie|nie|tak|
|Najczęstszy use case|monitoring systemu|event-driven architektura|alerty|decoupling|orchestracja microservices|

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
