---
title: "bits operator - c"
type: concept
topic: c
tags: ["c"]
created: 2026-06-09
status: draft
---

main:  #c

## Co to bity?

Wszystkie liczby w pamięci to zera i jedynki. Operator bitowy pozwala ci pracować z tymi zerami i jedynkami bezpośrednio, zamiast na całych liczbach.

```c
int x = 5;           // w binariach: 0101
int y = 3;           // w binariach: 0011
```

Zamiast myśleć "5 + 3", myślisz "bit po bicie, co się dzieje z zerami i jedynkami?".

## AND (&)

Operator `&` zwraca 1 tylko jeśli oba bity są 1.

```c
int x = 5;           // 0101
int y = 3;           // 0011
int z = x & y;       // 0001 = 1
printf("%d\n", z);   // wypisze 1
```

Bit po bicie: pozycja 0 to 1&1=1. Pozycja 1 to 0&1=0. Pozycja 2 to 1&0=0. Pozycja 3 to 0&0=0. Wynik to 0001, czyli 1.

_Praktycznie: używasz AND gdy chcesz sprawdzić czy konkretny bit jest ustawiony (=1). Na przykład, czy liczba jest parzysta?

```c
if (x & 1) {
    printf("Nieparzysta\n");  // jeśli ostatni bit to 1
} else {
    printf("Parzysta\n");     // jeśli ostatni bit to 0
}
```

## OR (|)

Operator `|` zwraca 1 jeśli przynajmniej jeden bit jest 1.

```c
int x = 5;           // 0101
int y = 3;           // 0011
int z = x | y;       // 0111 = 7
printf("%d\n", z);   // wypisze 7
```

Bit po bicie: 1|1=1, 0|1=1, 1|0=1, 0|0=0. Wynik to 0111, czyli 7.

Praktycznie: używasz OR gdy chcesz włączyć bity. Jeśli masz flagę, którą chcesz ustawić na 1, używasz OR.

```c
int ustawienia = 0;       // 0000
ustawienia |= (1 << 2);   // włącz bit 2
printf("%d\n", ustawienia); // 0100 = 4
```

## XOR (^)

Operator `^` zwraca 1 jeśli bity się różnią.

```c
int x = 5;           // 0101
int y = 3;           // 0011
int z = x ^ y;       // 0110 = 6
printf("%d\n", z);   // wypisze 6
```

Bit po bicie: 1^0=1, 0^1=1, 1^0=1, 0^0=0. Wynik to 0110, czyli 6.

_Praktycznie: XOR przełącza bity (toggle). Jeśli bit jest 0, robi się 1. Jeśli jest 1, robi się 0.

## NOT (~)

Operator `~` odwraca wszystkie bity (0 → 1, 1 → 0).

```c
int x = 5;           // 0101
int z = ~x;          // 1010 (ale to jest bardziej skomplikowane!)
```

Uwaga: `~x` nie daje 10, daje ujemną liczbę. W C liczby mogą być ujemne, a ich bity działają inaczej (dwa uzupełnienia). Rzadko się tego używa bez powodu.

## Shifty: << i >>

`<<` przesuwa bity w lewo (mnożenie przez 2). `>>` przesuwa bity w prawo (dzielenie przez 2).

```c
int x = 5;           // 0101
int a = x << 1;      // 1010 = 10 (x * 2)
int b = x >> 1;      // 0010 = 2 (x / 2)
```

Praktycznie: shifty są szybsze niż mnożenie i dzielenie. Jeśli chcesz `x * 8`, możesz pisać `x << 3` (przesuń o 3 bity).

## Praktyczne Przykłady

**Sprawdź czy bit n jest ustawiony:**

```c
int has_bit(int x, int n) {
    return (x & (1 << n)) != 0;  // przesun 1 na pozycje n, porownaj z AND
}

int x = 5;           // 0101
printf("%d\n", has_bit(x, 0));  // 1 (bit 0 to 1)
printf("%d\n", has_bit(x, 1));  // 0 (bit 1 to 0)
```

**Włącz bit n:**

```c
int set_bit(int x, int n) {
    return x | (1 << n);  // OR z ustawionym bitem
}

int x = 5;           // 0101
x = set_bit(x, 1);   // 0111 = 7
```

**Wyłącz bit n:**

```c
int clear_bit(int x, int n) {
    return x & ~(1 << n);  // AND z odwróconymi bitami
}

int x = 5;           // 0101
x = clear_bit(x, 0); // 0100 = 4
```

**Przełącz bit n:**

```c
int toggle_bit(int x, int n) {
    return x ^ (1 << n);  // XOR przełącza
}

int x = 5;           // 0101
x = toggle_bit(x, 2); // 0001 = 1
```

## Logiczne vs Bitowe

Nie myl `&` z `&&` i `|` z `||`. To nie to samo!

```c
int x = 5, y = 3;

x & y;    // bitowy: 0101 & 0011 = 0001 = 1
x && y;   // logiczny: 5 != 0 && 3 != 0 = true = 1

x | y;    // bitowy: 0101 | 0011 = 0111 = 7
x || y;   // logiczny: 5 != 0 || 3 != 0 = true = 1
```

Logiczne (`&&`, `||`) pytają: "czy to true czy false?". Bitowe (`&`, `|`) pracują na bitach liczby.

## Pamiętaj

Operatory bitowe pracują na zerach i jedynkach. AND (`&`) bierze części wspólne, OR (`|`) łączy, XOR (`^`) znajduje różnice. Shifty (`<<`, `>>`) przesuwają bity (mnożenie/dzielenie przez 2). Praktycznie używasz ich do flag, uprawnień czy optymalizacji szybkości. Nie myl bitowych z logicznymi!

___
Metadate:
