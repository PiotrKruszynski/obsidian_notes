---
tags: [c, koncepcja, wyjście, syscall]
powiązane: ["[[String i null terminator]]", "[[Arytmetyka ASCII]]"]
sr_due: 2026-07-15
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# write i deskryptory plików

> [!summary] W jednym zdaniu
> `write(1, bufor, n)` to wywołanie systemowe wypisujące `n` surowych bajtów spod adresu `bufor`; `1` to deskryptor standardowego wyjścia (ekranu).

```c
ssize_t write(int fd, const void *buf, size_t count);
```
Trzy argumenty:
- `fd` — **deskryptor pliku**: mała liczba identyfikująca, *dokąd* piszesz. Trzy są stałe: `0` = wejście (stdin), `1` = wyjście (stdout, ekran), `2` = błędy (stderr). Pisząc na ekran, używasz `fd = 1`.
- `buf` — **adres** pierwszego bajtu do wypisania ([[Wskaźnik]]).
- `count` — ile bajtów wypisać.

`write` operuje na **bajtach**, nie zna pojęcia "string" ani "liczba". Dlatego:
- żeby wypisać jeden znak, dajesz jego adres i `1`: `write(1, &c, 1);`
- żeby wypisać string, idziesz znak po znaku (albo podajesz długość).

> [!example] my_putstr i my_putchar przez write
> ```c
> void my_putchar(char c)
> {
>     write(1, &c, 1);          // &c, bo write chce ADRES bufora
> }
>
> void my_putstr(char *str)
> {
>     while (*str)              // do '\0'
>         write(1, str++, 1);   // wypisz bieżący znak, przesuń wskaźnik
> }
> ```
> `str++` wypisuje znak spod aktualnego adresu, potem przesuwa wskaźnik na następny. Pętla kończy się na [[String i null terminator|zerze]].

> [!warning] Czemu nie printf
> Pisząc wyjście bez biblioteki standardowej (czysty `write`, bez `printf`), liczby wypisujesz sam — zamieniając cyfry na znaki przez [[Arytmetyka ASCII]].

## Połączenia
- [[Arytmetyka ASCII]] — jak zamienić liczbę na wypisywalny znak
- [[String i null terminator]] — jak wiesz, gdzie skończyć `my_putstr`
