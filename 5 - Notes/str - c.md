## Co to jest string?

String to tablica znaków (typ `char`) zakończona znakiem null (`\0`). Ten specjalny znak mówi funkcjom gdzie się string kończy.

```c
char napis[] = "Hello";  // To to samo co:
char napis[] = {'H','e','l','l','o','\0'};
```

Rozmiar tablicy musi być o 1 większy niż liczba znaków (miejsce na `\0`).

## Deklaracja

```c
char s1[] = "tekst";           // Tablica (rozmiar automatycznie)
char s2[50] = "tekst";         // Tablica ze stałym rozmiarem
char *s3 = "tekst";            // Wskaźnik (tylko do czytania!)
```

Strings literały (w cudzysłowach) są read-only. Nie możesz ich zmieniać.

## Najważniejsze funkcje (string.h)

```c
#include <string.h>

strlen(s)              // Długość stringa (bez \0)
strcpy(dest, src)      // Kopiuj src do dest (NIEBEZPIECZNE!)
strncpy(dest,src,n)    // Kopiuj max n znaków (bezpieczniej)
strcat(s1, s2)         // Dołącz s2 do s1
strcmp(s1, s2)         // Porównaj: 0=równe, <0 s1<s2, >0 s1>s2
strchr(s, c)           // Znajdź pierwszy znak c w s
strstr(s1, s2)         // Znajdź podstring s2 w s1
```

## Czytanie stringów

```c
char nazwa[50];
scanf("%s", nazwa);        // Czyta do spacji (NIEBEZPIECZNE!)
scanf("%49s", nazwa);      // Czyta do spacji, max 49 znaków (bezpieczniej)
fgets(nazwa, 50, stdin);   // Czyta całą linię (NAJLEPSZE)
```

`fgets` jest najbezpieczniejszy, bo liczysz znakami włącznie z `\n`.

## Popularne błędy

**Błąd 1: Brak miejsca na `\0`**

```c
char s[5] = "hello";  // ❌ Potrzebujesz 6 (h-e-l-l-o-\0)
char s[6] = "hello";  // ✅ OK
```

**Błąd 2: strcpy bez powiększenia bufora**

```c
char s[5];
strcpy(s, "hello");   // ❌ Buffer overflow!
strncpy(s, "hello", 4);  // ✅ OK, ale obetnij na 4
```

**Błąd 3: Modyfikowanie stringów literałów**

```c
char *s = "hello";
s[0] = 'H';   // ❌ SEGFAULT
```

# Praktyczne przykłady

**Długość stringa (to robi strlen, teraz ty):**

```c
int my_strlen(char *s) {
    int len = 0;
    while (s[len] != '\0') {
        len++;
    }
    return len;
}
```

Czytasz znaki jeden po drugim dopóki nie natkniesz się na `\0`. Proste.

**Kopiuj string (to robi strcpy, teraz ty):**

c

```c
void my_strcpy(char *dest, char *src) {
    while (*src != '\0') {
        *dest = *src;
        dest++;
        src++;
    }
    *dest = '\0';  // Nie zapomnij!
}
```

Przesuwasz wskaźniki obu stringów. Kopiujesz znak, przesuwasz oba, powtarzasz. Na koniec dodaj `\0`.


**Porównaj dwa stringi (to robi strcmp, teraz ty):**


```c
int my_strcmp(char *s1, char *s2) {
    while (*s1 != '\0' && *s2 != '\0') {
        if (*s1 != *s2) {
            return *s1 - *s2;  // Różnica ASCII
        }
        s1++;
        s2++;
    }
    return *s1 - *s2;  // Jeden jest dłuższy
}
```

Porównujesz znaki. Jak się różnią, zwracasz różnicę. Jak się kończą równocześnie, zwracasz 0.


**Znajdź znak w stringu (to robi strchr, teraz ty):**


```c
char *my_strchr(char *s, char c) {
    while (*s != '\0') {
        if (*s == c) {
            return s;  // Zwróć wskaźnik na znaleziony
        }
        s++;
    }
    return 0;  // Nie znaleziono
}
```

Idziesz po stringu, jak coś znajdziesz, zwracasz adres. Jak nic nie ma, zwracasz NULL.


**Dołącz string do stringa (to robi strcat, teraz ty):**


```c
void my_strcat(char *dest, char *src) {
    while (*dest != '\0') {
        dest++;  // Idź do końca dest
    }
    while (*src != '\0') {
        *dest = *src;  // Kopiuj src do dest
        dest++;
        src++;
    }
    *dest = '\0';  // Kończ stringiem
}
```

Najpierw idziesz na koniec `dest`. Potem dołączasz `src`. Na koniec `\0`.