---
tags: [c, koncepcja, fundament, pamięć]
powiązane: ["[[Pamięć to taśma adresów]]", "[[malloc, void gwiazdka i size_t]]", "[[Rekurencja i stos wywołań]]"]
sr_due: 2026-07-16
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Stos kontra sterta

- **stos** — zmienne lokalne; sprzątany automatycznie po zakończeniu funkcji; szybki, krótkotrwały
- **sterta** — pamięć z [[malloc, void gwiazdka i size_t|malloc]]; żyje, aż sam zwolnisz przez `free`; przeżywa koniec funkcji
- reguła: dane na czas jednej funkcji → stos; dane zwracane / dłuższe → sterta

> [!warning] Nie zwracaj tablicy ze stosu
> `int tab[100]; return (tab);` — tab znika w momencie `return`, wywołujący dostaje wskaźnik na śmieci (dangling pointer). Dane, które mają przeżyć funkcję, muszą iść na stertę.

## Połączenia

- [[Pamięć to taśma adresów]] — obraz nadrzędny
- [[malloc, void gwiazdka i size_t]] — alokacja na stercie
- [[free, leak i use-after-free]] — spłata długu za malloc
- [[Rekurencja i stos wywołań]] — jak stos rośnie przy wywołaniach
