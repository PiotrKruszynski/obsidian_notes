---
tags: [c, koncepcja, rekurencja, pamięć]
powiązane: ["[[Stos kontra sterta]]", "[[Arytmetyka ASCII]]"]
sr_due: 2026-07-05
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Rekurencja i stos wywołań

> [!summary] W jednym zdaniu
> Funkcja może wołać samą siebie; każde wywołanie dostaje własną ramkę na [[Stos kontra sterta|stosie]], a ramki "odkładają się" i rozwijają w odwrotnej kolejności — to dlatego `my_putnbr` wypisuje cyfry we właściwym porządku.

Każde wywołanie funkcji tworzy **ramkę stosu** (stack frame) — prywatny obszar na jej argumenty i zmienne lokalne. Przy rekurencji ramki układają się jedna na drugiej, a gdy wywołanie się kończy, jego ramka jest zdejmowana i sterowanie wraca do tej pod spodem.

Problem w `my_putnbr`: liczbę trzeba wypisać od **najbardziej** znaczącej cyfry, a `% 10` daje najpierw tę **najmniej** znaczącą. Rozwiązanie: zanim wypiszesz ostatnią cyfrę, najpierw rekurencyjnie obsłuż całą resztę (`nbr / 10`).

```c
void my_putnbr(int nbr)
{
    if (nbr < 0)
    {
        write(1, "-", 1);
        nbr = -nbr;
    }
    if (nbr >= 10)
        my_putnbr(nbr / 10);          // najpierw reszta liczby
    write(1, &"0123456789"[nbr % 10], 1);  // potem ostatnia cyfra
}
```

> [!example] Prześledź my_putnbr(123) — jak rosną i znikają ramki
> ```
> my_putnbr(123)        ← ramka A: 123>=10, wołaj my_putnbr(12), CZEKAJ
>   my_putnbr(12)       ← ramka B: 12>=10, wołaj my_putnbr(1), CZEKAJ
>     my_putnbr(1)      ← ramka C: 1<10, wypisz '1', koniec C
>   wróć do B: wypisz 12 % 10 = '2', koniec B
> wróć do A: wypisz 123 % 10 = '3', koniec A
> Wyjście: 1 2 3
> ```
> Najmłodsza cyfra (`3`) jest wypisana **ostatnia**, bo jej `write` czeka, aż wróci cała rekurencja pod spodem. Stos wywołań naturalnie odwraca kolejność.

> [!warning] Rekurencja musi mieć warunek stopu
> Tu stopem jest `if (nbr >= 10)` — gdy liczba jednocyfrowa, przestajemy się zagłębiać. Bez warunku stopu ramki rosłyby w nieskończoność → **stack overflow** (przepełnienie stosu) i crash.

## Połączenia
- [[Stos kontra sterta]] — gdzie żyją ramki wywołań
- [[Arytmetyka ASCII]] — jak każda cyfra staje się znakiem
