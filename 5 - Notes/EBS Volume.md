Created: 2026-02-03  10:20
___

>[!Definition] 
>elastic block store
network USB stick

network drive
bound to specyfic AZ
persist data after termination
to one instance at a time
detach & attach quickly
delete on termination

snapshot - kopia punktu w czasie

![[Pasted image 20260203123812.png]]

gp2 / gp3 -> cost effective storage, low-latency

PROVISIONED IOPS -> critical business app, greate for databases workloads
HDD (st1, sc1):
- **cannot be boot volume**
- lowest cost 
- for data infrequently accessed
- big data, data warehouses, log processing, backup

## Multi-attach
- attach the same EBS volume to multiple EC2 instance in the same AZ
- each instance has full read & write permissions to the high-performance volume
- up to 16 EC2 instances at a time
- must use file system that's cluster-aware

## Encrypted EBS
- data at rest is encrypted inside the volume
- szyfrowanie obejmuje cały cykl życia danych:
	- at rest - dane zapisane na wolumenie
	- in transition - dane miedzy EC2 a EBS
	- snapshots - migawki EBS and volumes created from snapshot

Jak działa?
- algorytm AES-256
- klucze zarządzane przez AWS Key Management Service (KMS)
- szyfrowanie na poziomie infrastruktury AWS, niewidoczne dla instancji EC2

Aby zaszyfrować niezaszyfrowane EBS volume
- create an EBS snapshit of the volume
- encrypt the EBS snapshot (using copy)
- create new EBS volume from snapshot

___
Metadata:

```yaml
---
type: tool    # concept | service | comparison
language: aws
---
```

Status: #pending
Tags: #aws #ebs #volume
