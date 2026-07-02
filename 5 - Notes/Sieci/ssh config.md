---
title: "ssh config"
type: concept
topic: networking
tags: ["linux", "ssh"]
created: 2026-06-09
status: draft
sr_due: 2026-07-11
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

`~/.ssh/config`

```bash
Host aws
  HostName 54.147.3.55
  User ubuntu
  IdentityFile ~/Downloads/labsuser.pem
```
od teraz:
`ssh aws`

agent
`eval "$(ssh-agent -s)"`
`ssh-add ~/.ssh/id_ed25519`
