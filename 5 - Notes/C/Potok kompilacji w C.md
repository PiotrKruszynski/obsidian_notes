---
tags: [c, c08, koncepcja, fundament]
powiązane: ["[[Preprocesor to silnik wklejania tekstu]]", "[[Header file]]", "[[Deklaracja kontra definicja]]"]
---

# Potok kompilacji w C

> [!summary] W jednym zdaniu
> `cc plik.c` to nie jeden krok, lecz potok czterech etapów — i cały C08 dotyczy dwóch pierwszych, więc warto wiedzieć, co dzieje się na każdym.

Gdy wpisujesz `cc plik.c`, tekst przechodzi przez taśmę produkcyjną. Każdy etap bierze to, co dostał, i przekształca w coś bliższego maszynie:

```
plik.c
  │  (1) PREPROCESOR — pracuje na czystym tekście, nie zna C
plik.i      ← rozwinięte #include, #define, #ifndef
  │  (2) KOMPILATOR — pierwszy etap, który rozumie język C
plik.s      ← kod w asemblerze
  │  (3) ASEMBLER — tłumaczy asembler na bajty
plik.o      ← kod maszynowy, ale jeszcze "dziurawy" (brak adresów funkcji z innych plików)
  │  (4) LINKER — skleja wszystkie .o w jeden program
a.out       ← gotowy plik wykonywalny
```

Najważniejszy wniosek: **preprocesor (1) działa, zanim kompilator (2) w ogóle zobaczy Twój kod.** Preprocesor nie zna pojęcia funkcji czy zmiennej — on tylko przepisuje tekst. To dlatego błędy w makrach bywają tak podstępne: powstają na etapie tekstu, a objawiają się dopiero później jako dziwna matematyka.

Drugi wniosek: kompilator obrabia **każdy plik `.c` osobno** (każdy staje się osobnym `.o`). Kompilując `main.c`, nie widzi treści `inny.c`. To jest cały powód, dla którego istnieją [[Header file]] i [[Deklaracja kontra definicja]].

> [!example] Zobacz każdy etap na żywo
> Na swoim Macu zatrzymaj potok po wybranym etapie:
> ```bash
> cc -E plik.c    # pokaż wynik PO preprocesorze (rozwinięte include/define)
> cc -S plik.c    # zatrzymaj po kompilatorze (powstaje plik.s — asembler)
> cc -c plik.c    # zatrzymaj po asemblerze (powstaje plik.o)
> ```
> `cc -E` to najlepsze narzędzie dydaktyczne w całym C08 — dosłownie widzisz, jak makra i headery zamieniają się w zwykły kod.

## Połączenia
- [[Preprocesor to silnik wklejania tekstu]] — szczegóły etapu (1)
- [[Header file]] — istnieje, bo etap (2) widzi pliki osobno
- [[Stos kontra sterta]] — dotyczy już działającego programu (po etapie 4)
