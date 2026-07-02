---
title: "DocumentDB"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
sr_due: 2026-07-07
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

>[!tip]
>similar to _Aurora_ (architektura rozproszona storage + compute) but compatible with  _MongoDB_ API
**NoSQL database**, document db ->  data format **BSON**, elastyczne zagnieżdżanie struktur
> fully managed, [[high availability]] with replication across 3 AZ
> **storage** automatically grows in block of 10GB
> automatically scales (_read replica_) to workloads with millions of requests per seconds

[[MongoDB]] is used to store, query and index JSON data

DocumentDB (Mongodb) is not serverless! and is not Global
