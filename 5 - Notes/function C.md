Created: 2026-05-06  10:21
___
Note:

# Funkcje w C

Zbiór instrukcji zamknięty pod identyfikatorem. 
Podstawa programowania proceduralnego.

**Cel:** re-używalność kodu, 

```c
#include <unistd.h> // biblioteka pod write

void ft_putchar(char c) // deklaracja
{
    write(1, &c, 1);
}

int main(void) // wywołanie
{
    ft_putchar('a');        
    return (0);      
}
```


```c
#include <unistd.h>

// Wskaźnik char *str pozwala przyjąć napis w cudzysłowie "ab"
void ft_put2char(char *znaki)
{
    write(1, znaki, 2);
}

int main(void)
{
    ft_put2char("ab"); // Przekazujemy napis
    return 0;
}
```










---

### Porównanie z Pythonem :

| **Cecha**                      | **Python**             | **C**                                |
| ------------------------------ | ---------------------- | ------------------------------------ |
| **Typowanie**                  | Dynamiczne             | Statyczne (jawne)                    |
| **Argumenty domyślne**         | Tak                    | Nie                                  |
| **Argumenty nazwane**          | Tak                    | Nie                                  |
| **Wiele wartości zwracanych**  | Tak (jako krotka)      | Nie (wymaga struktur lub wskaźników) |
| **Przeciążanie (overloading)** | Nie (ale jest `*args`) | Nie (wymaga różnych nazw lub C++)    |









___
Metadata:

```yaml
---
type: tool    # concept | tool | pattern
language: python # c
---
```

Status: #pending
Tags: #c #functions
