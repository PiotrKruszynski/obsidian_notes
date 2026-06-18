---
tags: [c, c08, koncepcja, wskaźniki]
powiązane: ["[[Wskaźnik]]", "[[ex00 ft.h]]"]
---

# Przekazywanie przez wartość kontra przez adres

> [!summary] W jednym zdaniu
> W C funkcja dostaje **kopię** argumentu, więc żeby zmienić oryginał wywołującego, musisz przekazać jego **adres** — to cały powód, dla którego `ft_swap` bierze `int *`.

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
void ft_swap(int *a, int *b)
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
ft_swap(&x, &y);   // &x, &y to ADRESY
// teraz x == 10, y == 5
```

> [!tip] To ten sam mechanizm co `scanf`
> `scanf("%d", &n)` działa, bo dajesz mu **adres** `n` — dzięki temu może wpisać odczytaną liczbę pod ten adres, czyli do Twojej zmiennej. Bez `&` przekazałbyś tylko kopię i `scanf` nie miałby gdzie zapisać wyniku.

## Połączenia
- [[Wskaźnik]] — narzędzie, które to umożliwia
- [[ex00 ft.h]] — `ft_swap` to wzorcowy przykład
