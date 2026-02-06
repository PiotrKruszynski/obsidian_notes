Created: 2026-02-04  11:39
___
Note:

>[! Important]
>> **wejście do [[EFS - elastic file system]] w danej AZ**
>EFS to usługa magazynowania, aby się podłączyć potrzebujesz Mount Target = most między EC2 a EFS


# Cechy
- jedne na subnet
- ENI pod spodem: Mount Target wykorzystuje ENI do komunikacji
- IP w sieci: ma przypisany prywatny IP w danej subnet
- Security group: można ustawić zasady dostępu

Bez Mount Targetu w danej AZ ❌ **nie da się zamontować EFS**


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
