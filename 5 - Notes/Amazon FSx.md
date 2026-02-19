Created: 2026-02-18  22:39
___
Note:

>[!tip]
>klasyczny **file system** z folderami i ścieżkami, montowany w systemie operacyjnym
>nie obiektowe jak S3
>nie bokowe jak EBS
>
>bardzo dobre rozwiązanie, jeśli dokładnie pasuje do scenariusza
ale **overkill i kosztowna pułapka**, jeśli użyte „bo to file system”.

Dostajesz:
- współdzielony system plików
- działający w twoim VPC
- może być montowany na Linux EC2 instance
- wspiera Microsoft Distribution File System DFS

Storage:
- SSD
- HDD

![[Pasted image 20260218224341.png]]

Scratch File System
- temporary storage
- data is not replicated
- high burst

Persistent File System
- long term storage
- data is replicated within same AZ
- replace failed files
- usage: long-term processing, sensitive data

![[Pasted image 20260218224814.png]]

![[Pasted image 20260218224842.png]]




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
