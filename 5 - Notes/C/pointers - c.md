---
title: "pointers - c"
type: concept
topic: c
tags: []
created: 2026-06-09
status: draft
---


**Zmienna** przechowuje wartość. **Pointer** przechowuje adres zmiennej.

```c
int x = 10;         // zmienna: szuflada z wartością 10
int *p = &x;        // pointer: szuflada z adresem zmiennej x
```

Kiedy używasz `x`, czytasz wartość (10). Kiedy używasz `*p`, czytasz wartość pod adresem (też 10). Kiedy używasz `p`, czytasz sam adres (coś w stylu 0x7fff...).

```c
printf("%d\n", x);    // 10
printf("%d\n", *p);   // 10 (ten sam x, inny sposób dostępu)
printf("%p\n", p);    // 0x7fff5fbff8ac (adres x)
```


`&` mówi: "daj mi adres tej zmiennej". `*` mówi: "przejdź na ten adres i przeczytaj wartość".

```c
int x = 5;
int *p = &x;        // p zawiera adres x

*p = 10;            // zmień wartość na adresie p (czyli zmień x)
printf("%d\n", x);  // 10
```

## Po co pointery?

_Głównie po to, żeby funkcja mogła zmienić oryginalną zmienną, a nie tylko jej kopię.

**Bez pointera — funkcja dostaje kopię:**

```c
void zmien(int val) {
    val = 42;       // zmienia kopię, nie original
}

int x = 10;
zmien(x);
printf("%d\n", x);  // 10 (bez zmian!)
```

**Z pointerem — funkcja dostaje adres:**

```c
void zmien(int *p) {
    *p = 42;        // zmienia wartość na adresie (original!)
}

int x = 10;
zmien(&x);
printf("%d\n", x);  // 42 (ZMIENIONE!)
```

## Swap — Praktyczny Przykład

Kiedy chcesz zamienić dwie zmienne, musisz podać funkcji ich adresy.

```c
void swap(int *a, int *b) {
    int tmp = *a;   // zapamietaj wartość x
    *a = *b;        // x dostaje wartość y
    *b = tmp;       // y dostaje starą wartość x
}

int x = 10, y = 20;
swap(&x, &y);
printf("%d %d\n", x, y);  // 20 10
```

Kluczowe: `*a = *b;` zmienia **wartość**, nie sam wskaźnik. Gdybyś napisał `a = b;`, zmienił byś sam pointer (bezużyteczne).

## Pointery na Pointery

Pointer może wskazywać na inny pointer. Wtedy musisz dereferencjować dwa razy.

```c
int n = 42;
int *p1 = &n;       // p1 wskazuje na n
int **p2 = &p1;     // p2 wskazuje na p1

printf("%d\n", *p1);    // 42 (jeden *)
printf("%d\n", **p2);   // 42 (dwa *)
```

Wzór: ile gwiazdek, tyle razy dereferencjujesz. `**p2` to dwa skoki: najpierw na `p1`, potem na `n`.

## Typowe Błędy

**Błąd 1: Niezainicjalizowany pointer**

```c
int *p;
*p = 5;  // ❌ CRASH! p zawiera losowy adres
```

Zawsze inicjalizuj: `int *p = &x;`

**Błąd 2: Dereferencja przy przypisaniu**

```c
int *p;
*p = &x;  // ❌ BŁĄD! Przypisujesz adres do wartości
```

Prawidłowo: `p = &x;` (bez gwiazdki po lewej).

**Błąd 3: Zamieszanie zmiennej wskaźnika z wartością**

```c
int *a, *b;
a = b;    // zmienia pointer a, nie wartość
*a = *b;  // zmienia wartość na adresie a
```

Te dwie rzeczy robią co innego.

## Pamiętaj

Pointer to zwykła zmienna, którą przechowuje adresy. `&` daje ci adres, `*` zabiera cię na ten adres. Bez pointera funkcja zmienia tylko kopię. Z pointerem zmienia original.