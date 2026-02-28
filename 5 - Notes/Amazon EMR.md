Created: 2026-02-28  14:20
___
Note:

>[!tip]
>elastic MapReduce do przetwarzania dużych zbiorów danych
>helps create [Hadoop] cluster [Big Data] to analyze and process vast amount of data
>- the clusters can be made of hundreds of EC2 instances
>- EMR comes bundled with Apache Spark, HBase, Presto, Flink itd a EMR take care of all configuration 
>- auto scaling
>- 

**Use case:** data processing, machine learning, web indexing, big data

# Node types

EMR is made of cluster of EC2 instances
Master Node - manage cluster
Core Node - run taks and store data
Task Node - just to run tasks

On demand / Reserved(min 1 year)
Spot Instances: cheaper, can be terminated
can have long running cluster




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
