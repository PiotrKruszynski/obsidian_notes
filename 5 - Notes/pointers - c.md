main:  #c
Status: #pending 

Created: 2026-05-12  10:57
___
# Pointery w C 

**Pointer** to zmienna, która przechowuje **adres** innej zmiennej w pamięci.

- `&` — operator adresu (zwraca adres zmiennej)
- `*` — operator dereferencji (czyta/zmienia wartość pod adresem)

### Deklaracja vs. Użycie

**Ważne:** Gwiazdka `*` w deklaracji oznacza typ, a w kodzie oznacza dereferencję.

```c
int *p;          // deklaracja: "p jest pointerem na int"
int n = 10;
p = &n;          // przypisanie: p zawiera adres n

printf("%d\n", *p);   // dereferencja: wydrukuje 10
printf("%p\n", p);    // sam adres: wydrukuje 0x7fff...
```

## Operator & i *

|Operator|Znaczenie|Przykład|
|---|---|---|
|`&zmienna`|Zwraca adres zmiennej|`&n` → adres n|
|`*pointer`|Zwraca wartość pod adresem|`*p` → wartość pod adresem p|

### Praktyczne Przykłady

```c
int x = 5;
int *p = &x;

*p = 10;              // zmienia x na 10
printf("%d\n", x);    // wydrukuje 10
printf("%d\n", *p);   // wydrukuje 10
printf("%p\n", p);    // wydrukuje adres x
```

## Pointery w Funkcjach

### Kopia vs. Adres

**Bez pointera — KOPIA (funkcja nie zmienia original):**

```c
void zmien(int p) {
    p = 42;           // zmienia kopię, nie original
}

int main(void) {
    int x = 10;
    zmien(x);         // przekazujesz WARTOŚĆ
    printf("%d\n", x); // wydrukuje 10 (bez zmian!)
}
```

**Z pointerem — ADRES (funkcja zmienia original):**

```c
void zmien(int *p) {
    *p = 42;          // zmienia wartość pod adresem
}

int main(void) {
    int x = 10;
    zmien(&x);        // przekazujesz ADRES
    printf("%d\n", x); // wydrukuje 42
}
```

### Zasada Pamięci

```
Bez pointera:
- Szuflada 1000: [10]    ← x (bez zmian!)
- Szuflada 2000: [42]    ← kopia p (zmieniona)

Z pointerem:
- Szuflada 1000: [42]    ← x (ZMIENIONA!)
- Szuflada 2000: [1000]  ← p (zawiera adres)
```

## Pointery na Pointery

### Struktura Zagłębienia

```c
int n = 666;
int *p1 = &n;        // p1 wskazuje na n
int **p2 = &p1;      // p2 wskazuje na p1
int ***p3 = &p2;     // p3 wskazuje na p2
```

**Czytanie poziomów:**

- `p1` zawiera: adres n
- `**p2` zawiera: n (dwa poziomy dereferencji)
- `***p3` zawiera: n (trzy poziomy dereferencji)

### Dereferencja

```c
int n = 666;
int *p1 = &n;
int **p2 = &p1;
int ***p3 = &p2;

printf("%d\n", *p1);      // 666 (jeden *)
printf("%d\n", **p2);     // 666 (dwa *)
printf("%d\n", ***p3);    // 666 (trzy *)
```

### Zmiana Wartości przez Pointery

```c
***p3 = 42;     // to samo co: n = 42
printf("%d\n", n);  // wydrukuje 42
```

# Swap w C — Wskaźniki i Dereferencja

W `main()` przekazujemy adresy `&x` i `&y`. W funkcji `swap()` parametry `a` i `b` otrzymują kopie tych adresów (czyli wskaźniki).
## Implementacja

```c
void swap(int *a, int *b) {
    int tmp = *a;    // tmp = wartość z x
    *a = *b;         // x dostaje wartość y
    *b = tmp;        // y dostaje starą wartość x
}
```

## Krok po kroku

1. `tmp = *a` — dereferencja, pobieramy wartość na którą wskazuje `a`
2. `*a = *b` — przypisujemy wartość z `*b` do adresu na który wskazuje `a`
3. `*b = tmp` — przypisujemy starą wartość `x` do adresu na który wskazuje `b`

Po powrocie do `main()` — `x` i `y` są zamienione.

## ❌ Błąd — czemu `a = b;` nie działa

```c
void swap(int *a, int *b) {
    int tmp = *a;
    a = b;           // ← a wskazuje teraz na y
    *b = tmp;        // zapisujemy na y, nie na x!
}
```

Zmieniamy sam wskaźnik `a`, a nie wartość na którą wskazuje. Zapisujemy `tmp` na złym adresie.

## Kluczowe rozróżnienie

- **`a = b;`** — zmienia sam wskaźnik (nie widać w `main()`)
- **`*a = *b;`** — zmienia wartość na którą wskazuje (widać w `main()`)











## Typowe Błędy

### ❌ Błąd: Dereferencja przy Przypisaniu

```c
int *p1;
*p1 = &n;       // BŁĄD! Przypisujesz adres do wartości
```

### ✅ Prawidłowo:

```c
int *p1;
p1 = &n;        // OK! Pointer dostaje adres
```

### ❌ Błąd: Niezainicjalizowany Pointer

```c
int *p;
printf("%p\n", p);   // NIEBEZPIECZNE! p zawiera losowy adres
*p = 5;              // CRASH! Piszesz do losowej pamięci
```

### ✅ Prawidłowo:

```c
int x = 10;
int *p = &x;    // p zawiera konkretny, bezpieczny adres
```




___
Metadate:

Tags: #empty
