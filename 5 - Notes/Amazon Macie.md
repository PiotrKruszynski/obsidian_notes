Created: 2026-03-21  00:26
___
Note:

#### dla S3

`S3 objects → analiza zawartości → wykrywanie danych wrażliwych`
- PII (np. imiona, adresy, PESEL-like)
- dane finansowe (numery kart)    
- dane poufne

👉 robi **content inspection**, nie tylko metadata
### Jak działa
```
- skanuje buckety S3
- używa ML + pattern matching
- generuje **findings (alerty)**
```

`S3 → Macie → finding (np. "found credit card data")`


![[Pasted image 20260321002759.png]]





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
