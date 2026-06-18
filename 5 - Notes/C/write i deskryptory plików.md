---
tags: [c, c08, koncepcja, wyjście, syscall]
powiązane: ["[[String i null terminator]]", "[[Arytmetyka ASCII]]", "[[ex05 ft_show_tab]]"]
---

# write i deskryptory plików

> [!summary] W jednym zdaniu
> `write(1, bufor, n)` to wywołanie systemowe wypisujące `n` surowych bajtów spod adresu `bufor`; `1` to deskryptor standardowego wyjścia (ekranu).

```c
ssize_t write(int fd, const void *buf, size_t count);
```
Trzy argumenty:
- `fd` — **deskryptor pliku**: mała liczba identyfikująca, *dokąd* piszesz. Trzy są stałe: `0` = wejście (stdin), `1` = wyjście (stdout, ekran), `2` = błędy (stderr). W C08 piszesz na ekran, więc `fd = 1`.
- `buf` — **adres** pierwszego bajtu do wypisania ([[Wskaźnik]]).
- `count` — ile bajtów wypisać.

`write` operuje na **bajtach**, nie zna pojęcia "string" ani "liczba". Dlatego:
- żeby wypisać jeden znak, dajesz jego adres i `1`: `write(1, &c, 1);`
- żeby wypisać string, idziesz znak po znaku (albo podajesz długość).

> [!example] ft_putstr i ft_putchar przez write
> ```c
> void ft_putchar(char c)
> {
>     write(1, &c, 1);          // &c, bo write chce ADRES bufora
> }
>
> void ft_putstr(char *str)
> {
>     while (*str)              // do '\0'
>         write(1, str++, 1);   // wypisz bieżący znak, przesuń wskaźnik
> }
> ```
> `str++` wypisuje znak spod aktualnego adresu, potem przesuwa wskaźnik na następny. Pętla kończy się na [[String i null terminator|zerze]].

> [!warning] Czemu nie printf
> ex05 pozwala **tylko na `write`**. `printf` jest zakazany (forbidden function → ocena -42). Liczby musisz wypisać sam, zamieniając cyfry na znaki przez [[Arytmetyka ASCII]].

## Połączenia
- [[Arytmetyka ASCII]] — jak zamienić liczbę na wypisywalny znak
- [[String i null terminator]] — jak wiesz, gdzie skończyć `ft_putstr`
- [[ex05 ft_show_tab]] — całość w akcji
