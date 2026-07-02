---
tags: [c, koncepcja, stringi]
powiązane: ["[[Wskaźnik]]", "[[Arytmetyka ASCII]]", "[[malloc, void gwiazdka i size_t]]"]
sr_due: 2026-07-11
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# String i null terminator

> [!summary] W jednym zdaniu
> String w C to ciąg znaków w pamięci zakończony specjalnym bajtem `\0` (wartość 0) — to on wyznacza koniec napisu, bo C nie pamięta długości osobno.

W C nie ma osobnego typu "string". String to [[Wskaźnik|wskaźnik]] `char *` na pierwszy znak ciągu, a koniec poznajemy po **null terminatorze** `\0` (bajt o wartości 0).

```c
char *str = "hi";
```
```
       ┌──────┬──────┬──────┐
       │ 'h'  │ 'i'  │ '\0' │
       └──────┴──────┴──────┘
        str[0] str[1] str[2]
```
Napis "hi" ma 2 widoczne znaki, ale zajmuje **3 bajty** — `\0` też musi się zmieścić. To powód, dla którego kopiując string alokujesz `malloc(długość + 1)`: `+1` jest na `\0`.

**Dlaczego pętle wyglądają jak `while (str[i])`** — bo `\0` ma wartość liczbową 0, a w C zero znaczy "fałsz":
```c
int my_strlen(char *str)
{
    int i = 0;
    while (str[i])     // kontynuuj, dopóki znak != '\0'
        i++;
    return (i);        // i = liczba znaków przed zerem
}
```
Gdy `i` trafi na `\0`, warunek staje się fałszem i pętla kończy — `i` jest wtedy długością.

> [!warning] Najczęstszy błąd: zgubiony `\0`
> Kopiując ręcznie, musisz **sam dopisać** terminator:
> ```c
> int i = 0;
> while (src[i]) { dest[i] = src[i]; i++; }
> dest[i] = '\0';   // BEZ tego dest nie jest poprawnym stringiem!
> ```
> Bez `\0` każda funkcja czytająca `dest` poleci dalej w pamięć, czytając przypadkowe bajty aż trafi na jakieś zero → śmieci na wyjściu albo segfault.

## Połączenia
- [[Wskaźnik]] — string to `char *`
- [[Arytmetyka ASCII]] — jak znaki mają wartości liczbowe
- [[malloc, void gwiazdka i size_t]] — dlaczego `+1` przy alokacji kopii
