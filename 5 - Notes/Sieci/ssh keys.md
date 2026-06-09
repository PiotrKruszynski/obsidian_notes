---
title: "ssh keys"
type: concept
topic: networking
tags: ["linux", "ssh"]
created: 2026-06-09
status: draft
---

`man ssh-keygen` 
## generowanie
`ssh-keygen -t ed25519  `
`ssh-keygen -t ed25519 -f mykey -C "aws"  `

## public key z private key + wskazanie pliku
`ssh-keygen -y -f key.pem  `

## zmiana uprawnień do pliku klucza
`chmod 400 key.pem`
