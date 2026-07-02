---
title: "ssh keys"
type: concept
topic: networking
tags: ["linux", "ssh"]
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

`man ssh-keygen` 
## generowanie
`ssh-keygen -t ed25519  `
`ssh-keygen -t ed25519 -f mykey -C "aws"  `

## public key z private key + wskazanie pliku
`ssh-keygen -y -f key.pem  `

## zmiana uprawnień do pliku klucza
`chmod 400 key.pem`
