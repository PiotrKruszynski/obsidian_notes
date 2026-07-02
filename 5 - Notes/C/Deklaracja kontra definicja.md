---
tags: [c, koncepcja, fundament]
powiązane: ["[[Header file]]", "[[Potok kompilacji w C]]"]
sr_due: 2026-07-08
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Deklaracja kontra definicja

- kompilator widzi każdy `.c` **osobno** ([[Potok kompilacji w C]]) — o funkcjach z innych plików mówisz mu deklaracją
- **deklaracja** (prototyp): `void my_putchar(char c);` — "to istnieje, linker znajdzie"; można powtarzać
- **definicja**: prototyp + ciało `{...}` — może być **tylko jedna** w programie; dwie → błąd linkera "multiple definition"
- [[Header file]] to plik pełen deklaracji; definicje żyją w plikach `.c`

## Połączenia

- [[Header file]] — zbiór deklaracji
- [[Potok kompilacji w C]] — czemu deklaracje są potrzebne
