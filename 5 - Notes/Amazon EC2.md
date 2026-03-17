Created: 2026-02-03  12:27
___
Note:

Elastic Compute Cloud

high-performance hardware disk
	- better I/O performance
	- ephemeral -> lose their storage if stopped
	- good for buffer / cache/ scratch data / temporary content
	- risk of data loss -> back up is your responsibility
	- no snapshot, nie da się odłączyć i podpiąć do innej instancji

# EC2 purchasing options
**On-Demand Instances** - płacisz za dokładny czas działania, bez zobowiązań, najdroższa w długim użyciu
**Reserved Instance** - rezerwujesz instancję na 1 lub 3 lata, zniżka do70%
**Convertible Reserved Instances** - masz opcje zmiany typu instancji
**Savings Plans** - możesz zmienić typ instancji, nawet usługę (np. na lambda) zobowiązanie na 1 lub 3 lata
**Spot Instance** - masz spota na niewykorzystanej mocy obliczeniową ale AWS może przerwać działanie instancję, jeżeli ktoś zapłaci więcej. 
Spoko dla Batch processing, BigData(Spark, Hadoop), ML training, renderingm stateless microservices
**Dedicated Hosts** - book an entire physical server, control instance placement.
**Dedicated Instances** - no other customer will share your hardware. Tu mamy izolacje instancji ale nie ma kontroli nad fizycznym serwerem.
**Capacity Reservations** - reserve capacity in a specific AZ for any duration. Gwarancja dostępności

Częsty pattern
`Auto Scaling Group + Launch Template + MixedInstancesPolicy`

**EC2 User Data**
bootstrap our instance using an EC2 User data script, only once at the instance first start
can automate boot tasks such as:
 - installing updates
 - installing software
 - downloading common files from internet
 _run with root user_ nie trzeba `sudo`
 

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
