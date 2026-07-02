---
title: "heap"
type: concept
topic: algorithms
tags: ["algorithms"]
created: 2026-06-09
status: draft
sr_due: 2026-07-14
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

**Sterta** (ang. **heap**) to obszar pamięci RAM, który służy do **dynamicznej alokacji pamięci** – tzn. przydzielania pamięci **w czasie działania programu**, w przeciwieństwie do **stosu (stack)**, gdzie dane są alokowane statycznie i krótkotrwale.

## 📦 Różnice: stos vs heap

| Cecha             | Stos ([[stack]])                         | Sterta ([[heap]])                     |
| ----------------- | ---------------------------------------- | ------------------------------------- |
| Kiedy alokowana   | W czasie kompilacji / wejścia do funkcji | W czasie działania programu (runtime) |
| Zarządzanie       | Automatyczne (LIFO)                      | Manualne lub przez garbage collector  |
| Rozmiar           | Mały (ograniczony)                       | Duży (zależny od RAM)                 |
| Czas życia danych | Krótki – do końca funkcji                | Długi – aż do zwolnienia              |
| Prędkość dostępu  | Bardzo szybki                            | Wolniejszy                            |
| Przykład danych   | Zmienne lokalne                          | Obiekty, instancje klas, kontenery    |
