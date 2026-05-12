main:  #c
Status: #pending 

Created: 2026-05-13  00:26
___


Tablica to grupa zmiennych tego samego typu, umieszczonych obok siebie w pamięci. Zamiast pisać `int x1, x2, x3;`, piszesz `int tab[3];` i masz trzy liczby w jednym pakiecie.

```c
int tab[5] = {10, 20, 30, 40, 50};
```

Liczby są indeksowane od 0. `tab[0]` to 10, `tab[1]` to 20, itd.

## Dostęp do Elementów

Czytasz i zmieniasz elementy za pomocą nawiasu kwadratowego.

```c
int tab[3] = {10, 20, 30};

printf("%d\n", tab[0]);   // 10
tab[1] = 99;
printf("%d\n", tab[1]);   // 99
```

Tablica i pointer to prawie to samo. `tab[i]` to to samo co `*(tab + i)`. Tablica to pointer na swój pierwszy element.

```c
int tab[3] = {10, 20, 30};
int *p = tab;           // p wskazuje na tab[0]

printf("%d\n", *p);     // 10
printf("%d\n", *(p+1)); // 20 (to samo co tab[1])
```

## Pętla przez Tablicę

Musisz wiedzieć ile elementów ma tablica. Najczęściej przekazujesz rozmiar jako parametr funkcji.

```c
void wypisz(int tab[], int rozmiar) {
    int i = 0;
    while (i < rozmiar) {
        printf("%d\n", tab[i]);
        i++;
    }
}

int main(void) {
    int tab[3] = {10, 20, 30};
    wypisz(tab, 3);
}
```

Używasz `while` zamiast `for`, bo iterujesz dopóki `i < rozmiar`. Bez pętli `for`.

## Tablice w Funkcjach

Kiedy przekazujesz tablicę do funkcji, przekazujesz **pointer na pierwszy element**, nie kopię całej tablicy. Dlatego funkcja może zmienić original.

```c
void podwoj(int tab[], int rozmiar) {
    int i = 0;
    while (i < rozmiar) {
        tab[i] = tab[i] * 2;
        i++;
    }
}

int main(void) {
    int tab[3] = {1, 2, 3};
    podwoj(tab, 3);
    printf("%d\n", tab[0]);  // 2 (ZMIENIONE!)
}
```

Funkcja dostaje adres `tab`, więc `tab[i] = ...` zmienia oryginalną tablicę.

## Tablice Dwuwymiarowe

Tablica dwuwymiarowa to tablica tablic. Myśl o niej jak o siatce wierszy i kolumn.

```c
int tab[2][3] = {
    {10, 20, 30},
    {40, 50, 60}
};
```

Masz 2 wiersze i 3 kolumny. Dostęp: `tab[wiersz][kolumna]`.

```c
printf("%d\n", tab[0][0]);  // 10
printf("%d\n", tab[1][2]);  // 60
tab[0][1] = 99;
```

## Pętla przez Tablicę Dwuwymiarową

Musisz dwóch zmiennych: jedną dla wierszy, jedną dla kolumn.

```c
void wypisz_2d(int tab[][3], int wiersze) {
    int i = 0;
    while (i < wiersze) {
        int j = 0;
        while (j < 3) {
            printf("%d ", tab[i][j]);
            j++;
        }
        printf("\n");
        i++;
    }
}
```

Zewnętrzna pętla idzie przez wiersze, wewnętrzna przez kolumny. Ważne: w deklaracji funkcji musisz podać liczbę kolumn (`[][3]`), ale nie liczbę wierszy.

## Tablice Znakowe — Stringi

Tablica znaków to string. Zawsze kończy się `\0`.

```c
char napis[6] = "Hello";  // H-e-l-l-o-\0 (6 znaków!)
```

Możesz iterować przez string jako tablicę.

```c
int i = 0;
while (napis[i] != '\0') {
    printf("%c\n", napis[i]);
    i++;
}
```

## Typowe Błędy

**Błąd 1: Dostęp poza tablicą**

```c
int tab[3] = {10, 20, 30};
printf("%d\n", tab[5]);  // ❌ Poza rozmiarem! Crash lub losowe dane
```

**Błąd 2: Brak miejsca na \0 w stringach**

```c
char s[5] = "Hello";  // ❌ Potrzebujesz 6 (H-e-l-l-o-\0)
char s[6] = "Hello";  // ✅ OK
```

**Błąd 3: Zapomnienie rozmiaru przy pętli**

```c
int tab[10];
int i = 0;
while (i < 10) {  // Musisz znać rozmiar!
    tab[i] = i;
    i++;
}
```

## Pamiętaj

Tablica to ciąg zmiennych jednego typu, indeksowanych od 0. `tab[i]` to to samo co `*(tab + i)`. Gdy przekazujesz tablicę do funkcji, przekazujesz pointer, a funkcja może zmienić original. Tablice dwuwymiarowe to tablice tablic — dwie pętle, dwa indeksy.





___
Metadate:

Tags: #empty
