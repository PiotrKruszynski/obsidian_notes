---
tags: [c, koncepcja, preprocesor]
powiązane: ["[[Deklaracja kontra definicja]]", "[[Include guard]]", "[[Preprocesor to silnik wklejania tekstu]]"]
sr_due: 2026-07-05
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Header file

- plik `.h` = **deklaracje** pisane raz, wklejane przez `#include` do każdego `.c`, który ich potrzebuje
- header **nie jest osobno kompilowany** — nie istnieje `header.o`; preprocesor kopiuje jego treść do `.c` (sprawdź: `cc -E`)
- do headera wkładasz: prototypy, `typedef`, makra, definicje struktur
- **nie** wkładasz ciał funkcji — header wklejony do dwóch `.c` dałby dwie definicje → błąd linkera

## Połączenia

- [[Deklaracja kontra definicja]] — co header zawiera
- [[Include guard]] — obowiązkowe zabezpieczenie headera
- [[Preprocesor to silnik wklejania tekstu]] — mechanizm `#include`
