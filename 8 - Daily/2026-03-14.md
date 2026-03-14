Created: 2026-03-14  13:45
___
Note:

# Programowanie zorientowane na dane

Sprawdzam czy plik istnieje:
`ls ~/Downloads | grep labsuser`

**Change mode** zmienia uprawnienia  żeby nie za szeroko
`chmod 400 ~/Downloads/labsuser.pem`

**Tunelowanie** . Otwieram TCP connection 
Mac → TCP port 22 → EC2
Handshake TCP

przykład dla jupyther
`ssh -i LOKALIZACJA KLUCZA ubuntu@PUBLIC_IP -L 8888:127.0.0.1:8888`
`ssh -i ~/Downloads/labsuser.pem ubuntu@PUBLIC_IP`

Po połączeniu na wejściu najlepiej :
`$ sudo su`
` # yum update`


`Control + r` - podpowiada **reverse search w historii Bash**.
`Control + c` - nowa linia 

Dodanie hasła (passphrase) do istniejącego klucza robisz przez **ssh-keygen**.
`ssh-keygen -p -f labsuser.pem`


___
Metadata:

```yaml
---
type: tool    # concept | tool | pattern
language: python # python | js | sql | etc.
---
```

Status: #pending
Tags: #empty
