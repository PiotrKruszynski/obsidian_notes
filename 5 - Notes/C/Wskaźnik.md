---
tags: [c, c08, koncepcja, wskaźniki]
powiązane: ["[[Pamięć to taśma adresów]]", "[[Przekazywanie przez wartość kontra przez adres]]", "[[Podwójny wskaźnik char gwiazdka gwiazdka]]"]
---

# Wskaźnik

> [!summary] W jednym zdaniu
> Wskaźnik to zmienna, która zamiast wartości przechowuje **adres** innej komórki [[Pamięć to taśma adresów|pamięci]].

Trzy operacje, które musisz rozróżniać w mgnieniu oka:

```c
int x = 42;        // zwykła zmienna, wartość 42
int *p = &x;       // p przechowuje ADRES x  (& = weź adres)
int y = *p;        // y = 42  (* = idź pod adres, weź wartość)
*p = 100;          // zmień to, co leży pod adresem → x == 100
```

Typ wskaźnika (`int *`, `char *`) mówi kompilatorowi, **co** leży pod adresem — żeby wiedział, ile bajtów odczytać i jak je interpretować. Sam adres to tylko liczba; typ nadaje jej sens.

> [!tip] Czemu `char *str` to "string"
> Wskaźnik `char *` trzyma adres pierwszego znaku ciągu. Idąc od tego adresu kolejno (`str[0]`, `str[1]`, ...) czytasz cały napis aż do [[String i null terminator|zera kończącego]]. Wskaźnik nie "zawiera" napisu — wskazuje na jego początek.

> [!warning] Wskaźnik może wskazywać donikąd
> `NULL` to wskaźnik "na nic". Dereferencja `*p`, gdy `p == NULL`, to segfault. Dlatego po [[malloc, void gwiazdka i size_t|malloc]] zawsze sprawdzasz `if (!p)` przed użyciem.

## Połączenia
- [[Pamięć to taśma adresów]] — skąd biorą się adresy
- [[Przekazywanie przez wartość kontra przez adres]] — po co przekazywać adres do funkcji
- [[Podwójny wskaźnik char gwiazdka gwiazdka]] — wskaźnik na wskaźnik
- [[Kropka kontra strzałka]] — dostęp do pól struktury przez wskaźnik
