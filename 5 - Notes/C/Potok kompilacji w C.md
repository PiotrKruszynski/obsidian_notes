---
tags: [c, koncepcja, fundament]
powiązane: ["[[Preprocesor to silnik wklejania tekstu]]", "[[Header file]]", "[[Deklaracja kontra definicja]]"]
sr_due: 2026-07-03
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Potok kompilacji w C

```
plik.c
  │  (1) PREPROCESOR — czysty tekst: rozwija #include, #define, #ifndef
plik.i
  │  (2) KOMPILATOR — pierwszy etap rozumiejący C → asembler
plik.s
  │  (3) ASEMBLER — asembler → kod maszynowy
plik.o      ← jeszcze "dziurawy" (brak adresów funkcji z innych plików)
  │  (4) LINKER — skleja wszystkie .o w program
a.out
```

- preprocesor działa **zanim** kompilator zobaczy kod — błędy makr powstają na etapie tekstu
- kompilator obrabia **każdy `.c` osobno** — stąd istnieją [[Header file]] i [[Deklaracja kontra definicja]]
- podgląd etapów: `cc -E` (po preprocesorze) · `cc -S` (asembler) · `cc -c` (do `.o`)

> [!tip] `cc -E plik.c` — najlepsze narzędzie do nauki preprocesora: widzisz rozwinięte makra i headery.

## Połączenia

- [[Preprocesor to silnik wklejania tekstu]] — etap (1) w szczegółach
- [[Header file]] — istnieje, bo etap (2) widzi pliki osobno
