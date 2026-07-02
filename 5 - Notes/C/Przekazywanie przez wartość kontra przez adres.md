---
tags: [c, koncepcja, wskaźniki]
powiązane: ["[[Wskaźnik]]"]
sr_due: 2026-07-06
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Przekazywanie przez wartość kontra przez adres

> [!summary] W jednym zdaniu
> W C funkcja dostaje **kopię** argumentu, więc żeby zmienić oryginał wywołującego, musisz przekazać jego **adres** — to cały powód, dla którego `my_swap` bierze `int *`.

W C argumenty idą do funkcji **przez wartość** — funkcja pracuje na kopii. Zmiana kopii nie rusza oryginału:
```c
void zepsuty_swap(int a, int b)  // kopie!
{
    int tmp = a; a = b; b = tmp;  // zamienia LOKALNE kopie
}
// po wywołaniu oryginały wywołującego są nietknięte
```

Żeby naprawdę zmienić zmienne wywołującego, dajesz funkcji ich **adresy** ([[Wskaźnik]]) — wtedy może sięgnąć do oryginalnych komórek [[Pamięć to taśma adresów|pamięci]]:
```c
void my_swap(int *a, int *b)
{
    int tmp;

    tmp = *a;   // weź wartość spod adresu a
    *a = *b;    // pod adres a wpisz wartość spod adresu b
    *b = tmp;   // pod adres b wpisz zapamiętaną wartość
}
```
Wołasz, przekazując adresy:
```c
int x = 5, y = 10;
my_swap(&x, &y);   // &x, &y to ADRESY
// teraz x == 10, y == 5
```

> [!tip] To ten sam mechanizm co `scanf`
> `scanf("%d", &n)` działa, bo dajesz mu **adres** `n` — dzięki temu może wpisać odczytaną liczbę pod ten adres, czyli do Twojej zmiennej. Bez `&` przekazałbyś tylko kopię i `scanf` nie miałby gdzie zapisać wyniku.

## Połączenia
- [[Wskaźnik]] — narzędzie, które to umożliwia
