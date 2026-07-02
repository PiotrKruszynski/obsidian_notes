---
title: "async"
type: concept
topic: python
tags: ["python"]
created: 2026-06-09
status: draft
sr_due: 2026-07-08
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

przez race condition nie może działać domyślnie. race condition rozumiem jak koparka wywrotka. 

Race condition to **błąd współbieżności**, który występuje, gdy **wynik programu zależy od nieprzewidywalnego przeplotu (interleaving)** instrukcji wykonywanych współbieżnie przez różne “wątki” kontroli. W Pythonie może to dotyczyć:

- _threading (wątki)_
    
- _asyncio (zadania asynchroniczne)_
    
- _multiprocessing (procesy)_

[[event loop]] - mechanizm (generator nieskończony), aby mógł przenosić na [[stack|call stack]], korzyta z [[queue]]
