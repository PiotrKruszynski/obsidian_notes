---
tags: [c, koncepcja, fundament, pamięć]
powiązane: ["[[Wskaźnik]]", "[[Stos kontra sterta]]"]
sr_due: 2026-07-02
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Pamięć to taśma adresów

> [!summary] W jednym zdaniu
> Pamięć to jeden długi rząd ponumerowanych komórek po jednym bajcie — numer komórki to jej **adres**, a wskaźnik to po prostu zmienna trzymająca taki numer.

To jedyny obraz, który musisz naprawdę "zobaczyć". Wszystko o wskaźnikach z niego wynika.

```
adres:   1000   1001   1002   1003   1004   1005  ...
        ┌──────┬──────┬──────┬──────┬──────┬──────┐
zawart.:│  42  │   0  │   0  │   0  │  'h' │  'i' │ ...
        └──────┴──────┴──────┴──────┴──────┴──────┘
```

Gdy deklarujesz `int x = 42;`, kompilator wybiera wolne miejsce (np. adresy 1000–1003, bo `int` to zwykle 4 bajty) i zapisuje tam 42.

Dwa operatory łączą "nazwę zmiennej" z "adresem":
- `&x` — **"weź adres"**. Daje numer komórki, pod którą leży `x` (tu: 1000).
- `*p` — **"idź pod ten adres i weź to, co tam leży"** (dereferencja).

[[Wskaźnik]] to zmienna, która przechowuje adres. `int *p = &x;` znaczy: "`p` trzyma adres, pod którym jest `x`". Nic magicznego — `p` to liczba (adres), tyle że kompilator wie, że pod tym adresem leży `int`.

> [!example] Adres kontra wartość
> ```c
> int x = 42;     // pod adresem (np.) 1000 leży 42
> int *p = &x;    // p przechowuje 1000
> int y = *p;     // idź pod 1000, weź 42 → y == 42
> *p = 100;       // pod adres 1000 wpisz 100 → teraz x == 100!
> ```
> Ostatnia linia to cała moc wskaźników: zmieniasz `x`, nie dotykając go po nazwie — bo `p` wie, gdzie `x` mieszka.

## Połączenia
- [[Wskaźnik]] — bezpośrednie zastosowanie tego obrazu
- [[Stos kontra sterta]] — dwa obszary tej taśmy o różnych regułach
- [[String i null terminator]] — string to ciąg sąsiednich komórek
