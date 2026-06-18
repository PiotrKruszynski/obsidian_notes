---
tags: [c, c08, koncepcja, struktury, wskaźniki]
powiązane: ["[[Struktura]]", "[[Wskaźnik]]", "[[ex03 ft_point.h]]"]
---

# Kropka kontra strzałka

> [!summary] W jednym zdaniu
> Masz samą [[Struktura|strukturę]] → używasz kropki `.`; masz [[Wskaźnik|wskaźnik]] na strukturę → używasz strzałki `->`. To wszystko.

```c
t_point p;          // sama struktura (np. na stosie)
p.x = 42;           // KROPKA

t_point *ptr = &p;  // wskaźnik na strukturę
ptr->x = 42;        // STRZAŁKA
```

Strzałka to czysty skrót. `ptr->x` znaczy dokładnie to samo co `(*ptr).x`: "najpierw idź pod adres w `ptr` (dereferencja `*`), potem wejdź do pola `x`". Skoro ten zapis jest częsty i brzydki w nawiasach, C daje krótszą formę `->`.

> [!example] ex03 spina to w całość
> ```c
> void set_point(t_point *point)   // dostaje WSKAŹNIK
> {
>     point->x = 42;               // więc STRZAŁKA
>     point->y = 21;
> }
>
> int main(void)
> {
>     t_point point;               // sama struktura
>     set_point(&point);           // przekazujesz jej ADRES
> }
> ```
> `main` ma samą strukturę, więc przekazuje `&point`. `set_point` dostaje wskaźnik, więc używa `->`. Logika z [[Przekazywanie przez wartość kontra przez adres]]: przekazujemy adres, by funkcja mogła zmienić oryginał.

> [!tip] Pamięciowa sztuczka
> Strzałka `->` "wskazuje" — używasz jej, gdy masz wskaźnik. Kropka jest "płaska" — gdy masz strukturę wprost.

## Połączenia
- [[Struktura]] — co zawiera pola
- [[Wskaźnik]] — kiedy `->`
- [[ex03 ft_point.h]] — wzorcowy przykład
