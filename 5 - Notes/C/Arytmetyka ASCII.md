---
tags: [c, koncepcja, stringi]
powiązane: ["[[String i null terminator]]", "[[write i deskryptory plików]]"]
sr_due: 2026-07-17
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Arytmetyka ASCII

- `char` to mała liczba całkowita — każdy znak ma kod: `'0'`=48 … `'9'`=57, `'A'`=65, `'a'`=97
- liczba → znak cyfry: `c = n + '0'` (dla n 0–9); znak → liczba: `n = c - '0'`
- standard gwarantuje, że `'0'`–`'9'` mają **kolejne** kody — `+ '0'` jest przenośne
- to podstawa własnego wypisywania liczb: [[write i deskryptory plików|write]] zna tylko bajty, więc każdą cyfrę zamieniasz na znak

## Połączenia

- [[String i null terminator]] — znaki jako wartości
- [[write i deskryptory plików]] — czemu liczbę trzeba zamienić na znak
- [[Rekurencja i stos wywołań]] — wypisywanie liczb wielocyfrowych
