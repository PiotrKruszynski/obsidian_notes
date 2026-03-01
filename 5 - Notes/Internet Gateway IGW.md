Created: 2026-03-01  16:34
___
Note:

>[!tip]
>komponent [[VPC]]  , który zapewnia dwukierunkową komunikację między zasobami w twojej chmurze a Internetem. Umożliwia instancją z publicznymi adresami IP odbieranie i wysyłanie ruchu. Nie przekłada ruchu wewnętrznego, nie dokonuje translacji. 
>- Allows resources in a VPC (like EC2) to connect to the Internet.
>- It is _highly available_, _redundant_, and scales horizontally.
>- **Constraint:** One VPC can be attached to only one IGW, and vice versa.
>- **Note:** Creating an IGW is not enough; you must also edit _Route Tables_ to allow Internet access.




___
Metadata:

```yaml
---
type: tool    # concept | service | comparison
language: aws
---
```

Status: #pending
Tags: #aws #vpc
