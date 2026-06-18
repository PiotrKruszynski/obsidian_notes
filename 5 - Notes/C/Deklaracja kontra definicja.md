---
tags: [c, c08, koncepcja, fundament]
powiązane: ["[[Header file]]", "[[Potok kompilacji w C]]"]
---

# Deklaracja kontra definicja

> [!summary] W jednym zdaniu
> Deklaracja to obietnica "to istnieje" (możesz ją powtarzać), definicja to realne ciało "oto jak to działa" (może być tylko jedna).

Kompilator obrabia każdy plik `.c` osobno (patrz [[Potok kompilacji w C]]). Gdy kompiluje `main.c`, nie widzi treści `ft_putchar.c`. Skąd ma wiedzieć, że funkcja `ft_putchar` istnieje, ile bierze argumentów i co zwraca? Mówisz mu to **deklaracją**.

**Deklaracja (prototyp)** — kończy się średnikiem, nie ma ciała:
```c
void ft_putchar(char c);
```
Znaczy: *"Gdzieś istnieje funkcja `ft_putchar`, bierze jeden `char`, nic nie zwraca. Uwierz, że istnieje — [[Potok kompilacji w C|linker]] znajdzie ją później."* Deklarację możesz powtórzyć dowolnie wiele razy.

**Definicja** — ma ciało `{ ... }`:
```c
void ft_putchar(char c)
{
    write(1, &c, 1);
}
```
Definicja może być **tylko jedna** w całym programie. Dwie definicje tej samej funkcji → linker zgłasza "multiple definition".

> [!tip] To jest sedno headerów
> [[Header file]] to po prostu **plik pełen deklaracji**. Wklejasz go (`#include`) do każdego `.c`, który tych funkcji używa, żeby kompilator znał ich prototypy. Same definicje (ciała) leżą osobno w plikach `.c` i nie powtarzają się.

## Połączenia
- [[Header file]] — zbiór deklaracji
- [[Potok kompilacji w C]] — dlaczego deklaracje są w ogóle potrzebne
