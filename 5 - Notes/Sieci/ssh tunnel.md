---
title: "ssh tunnel"
type: concept
topic: networking
tags: ["linux", "ssh"]
created: 2026-06-09
status: draft
sr_due: 2026-07-10
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

tunel SSH przekierowuje **lokalny port → zdalny port**  
  
schemat:  
`LOCAL_PORT:REMOTE_HOST:REMOTE_PORT`  
  
## przykład Jupyter
`ssh -i key.pem -L 8888:localhost:8888 ubuntu@IP`  

Mac → localhost:8888  
↓  
tunel SSH  
↓  
EC2 → localhost:8888  

**use case:**
- Jupyter  
- bazy danych  
- web UI działające tylko lokalnie na serwerze
