---
tags: [c, c08, koncepcja, stringi]
powiązane: ["[[String i null terminator]]", "[[write i deskryptory plików]]", "[[ex05 ft_show_tab]]"]
---

# Arytmetyka ASCII

> [!summary] W jednym zdaniu
> Znak w C to liczba (kod ASCII), więc możesz na nim liczyć — np. `cyfra + '0'` zamienia liczbę 0–9 na odpowiadający jej znak '0'–'9'.

Typ `char` to tak naprawdę mała liczba całkowita. Każdy znak ma kod ASCII: `'0'` to 48, `'1'` to 49, ..., `'9'` to 57; `'A'` to 65, `'a'` to 97. Skoro to liczby, działa arytmetyka.

**Liczba → znak cyfry** (potrzebne w `ft_putnbr`):
```c
char c = 5 + '0';   // 5 + 48 = 53 = '5'
```
Bo cyfry w ASCII leżą po kolei: `'0'+0='0'`, `'0'+1='1'`, ... `'0'+9='9'`. Dlatego `nbr % 10 + '0'` daje znak ostatniej cyfry liczby.

**Znak cyfry → liczba** (odwrotność, przyda się w `ft_atoi`):
```c
int n = '7' - '0';  // 55 - 48 = 7
```

> [!example] To napędza wypisywanie liczb przez write
> Skoro [[write i deskryptory plików|write]] wypisuje bajty, a nie liczby, musisz każdą cyfrę zamienić na jej znak:
> ```c
> void ft_putnbr_cyfra(int n)   // n: 0..9
> {
>     char c = n + '0';
>     write(1, &c, 1);
> }
> ```
> `ft_putnbr` dla wielocyfrowych liczb dokłada do tego [[Rekurencja i stos wywołań|rekurencję]].

> [!tip] Dlaczego to działa niezależnie od kodowania
> Standard C gwarantuje, że cyfry `'0'`–`'9'` mają **kolejne, rosnące** kody. Dlatego `n + '0'` jest przenośne, nawet jeśli nie pamiętasz, że `'0'` to akurat 48.

## Połączenia
- [[String i null terminator]] — znaki jako wartości
- [[write i deskryptory plików]] — czemu trzeba zamieniać liczbę na znak
- [[ex05 ft_show_tab]] — `ft_putnbr` używa `+ '0'`
