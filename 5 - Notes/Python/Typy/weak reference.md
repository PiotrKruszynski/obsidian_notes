---
title: "weak reference"
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

nie są mocne

zwykła referencja `x = 356   istnieje dopóki istnieje x
słaba -> obiekt może przestać istnieć GC usuwa jak nie ma refki

zwykła referencja -> dopóki obiekt ją ma to GC ją nie usunie
słabe -> służą do śledzenia obiektów, żeby wiedzieć czy on jeszcze istnieje czy nie , nie blokują usunięcia obiektu

jeżeli obiekt istniał ma podpiętą słabą i przestał istnieć to słaba referencja  wskazuje na None 


robimy słabą referencję aby nie trzymać obiektów po ich zakończeniu działania
