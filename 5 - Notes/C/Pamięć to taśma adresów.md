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

- pamięć = długi rząd ponumerowanych komórek po 1 bajcie; numer komórki to **adres**
- `int x = 42;` → kompilator rezerwuje np. adresy 1000–1003 (int ≈ 4 bajty) i wpisuje 42
- `&x` — numer komórki, pod którą leży `x`; `*p` — "idź pod adres i weź/zmień zawartość"
- [[Wskaźnik]] to zwykła zmienna trzymająca taki numer

```
adres:   1000   1001   1002   1003   1004   1005
        ┌──────┬──────┬──────┬──────┬──────┬──────┐
zawart.:│  42  │   0  │   0  │   0  │  'h' │  'i' │
        └──────┴──────┴──────┴──────┴──────┴──────┘
```

## Połączenia

- [[Wskaźnik]] — bezpośrednie zastosowanie tego obrazu
- [[Stos kontra sterta]] — dwa obszary taśmy o różnych regułach
- [[String i null terminator]] — string to ciąg sąsiednich komórek
