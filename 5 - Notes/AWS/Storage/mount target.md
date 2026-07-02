---
title: "mount target"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
sr_due: 2026-07-09
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

>[! Important]
>> **wejście do [[Amazon EFS - elastic file system]] w danej AZ**
>EFS to usługa magazynowania, aby się podłączyć potrzebujesz Mount Target = most między EC2 a EFS


# Cechy
- jedne na subnet
- ENI pod spodem: Mount Target wykorzystuje ENI do komunikacji
- IP w sieci: ma przypisany prywatny IP w danej subnet
- Security group: można ustawić zasady dostępu

Bez Mount Targetu w danej AZ ❌ **nie da się zamontować EFS**
