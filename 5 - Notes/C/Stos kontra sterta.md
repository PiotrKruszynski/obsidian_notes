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

> [!summary] W jednym zdaniu
> Stos to dane lokalne sprzątane automatycznie po zakończeniu funkcji; sterta to dane, które żyją, dopóki sam ich nie zwolnisz — do tego służy [[malloc, void gwiazdka i size_t|malloc]].

Program ma dwa główne obszary na dane (oba to fragmenty [[Pamięć to taśma adresów|taśmy pamięci]]):

**Stos (stack)**
- Tu lądują zwykłe zmienne lokalne: `int x;`, `t_point p;`.
- Zarządzany **automatycznie**: gdy funkcja się kończy, jej zmienne lokalne **znikają same**.
- Szybki, ale krótkotrwały — żyje tylko tak długo jak funkcja, w której powstał.

**Sterta (heap)**
- Tu ląduje to, co alokujesz ręcznie przez `malloc`.
- Zarządzana **ręcznie**: to, co zaalokujesz, żyje **dopóki nie zwolnisz** przez `free`.
- Przeżywa koniec funkcji.

> [!example] Dlaczego funkcja nie może zwrócić tablicy ze stosu
> Funkcja tworzy tablicę i ją **zwraca**. Gdyby zbudowała ją na stosie:
> ```c
> int tab[100];           // na stosie
> return (tab);           // ZŁO: tab znika po return!
> ```
> tablica zniknęłaby w momencie `return`, a wywołujący dostałby wskaźnik na śmieci (tzw. dangling pointer). Dane, które mają przeżyć funkcję, **muszą** być na stercie — stąd `malloc`.

> [!tip] Reguła decyzyjna
> Dane potrzebne tylko wewnątrz jednej funkcji → stos (zwykła zmienna). Dane, które funkcja zwraca lub które mają żyć dłużej → sterta (`malloc`). Każdy `malloc` to Twój dług — patrz [[free, leak i use-after-free]].

## Połączenia
- [[Pamięć to taśma adresów]] — obraz nadrzędny
- [[malloc, void gwiazdka i size_t]] — jak alokować na stercie
- [[free, leak i use-after-free]] — jak oddawać stertę
- [[Rekurencja i stos wywołań]] — jak stos rośnie przy zagnieżdżonych wywołaniach
