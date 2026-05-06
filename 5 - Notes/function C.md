Created: 2026-05-06  10:21
___
Note:

# Funkcje w C

Zbiór instrukcji zamknięty pod identyfikatorem. 
Podstawa programowania proceduralnego.

**Cel:** re-używalność kodu, modularność, abstrakcja.

### Charakterystyka:

- **Silne typowanie:** każda funkcja musi mieć określony typ zwracany (lub `void`).
- **Brak domyślnego dziedziczenia stanu:** zmienne lokalne są czyszczone po wyjściu z funkcji (chyba że użyto `static`).
- **Deklaracja vs Definicja:** * _Prototyp (deklaracja):_ informuje kompilator o istnieniu funkcji (zazwyczaj w plikach `.h`).
    - _Definicja:_ faktyczna implementacja kodu (pliki `.c`).
        

### Nazwa funkcji:
- **snake_case** (najczęstszy standard w C, np. w bibliotece standardowej).
- **Deskryptywna / opisowa.**
- Litery, cyfry, underscore (`_`), nie może zaczynać się od cyfry.
- Po angielsku.
    

### Parametry i Przekazywanie:

W C parametry są **tylko pozycyjne**.
1. **Pass by Value (przez wartość):** Funkcja otrzymuje kopię zmiennej. Zmiany wewnątrz nie wpływają na oryginał.
2. **Pass by Reference (symulacja wskaźnikiem):** Przekazujemy adres pamięci (`type *ptr`). Pozwala na modyfikację zmiennej zewnętrznej.
3. **Tablice jako parametry:** Zawsze przekazywane jako wskaźnik do pierwszego elementu (degradacja tablicy do wskaźnika).
4. **Variadic Functions (`...`):** Odpowiednik `*args`. Wymaga biblioteki `<stdarg.h>` (np. funkcja `printf`).
    

### Specyficzne cechy:

- **Brak Named Arguments:** Nie można wywołać funkcji przez `fn(param=value)`.
- **Brak Default Parameters:** C nie wspiera domyślnych wartości (trzeba tworzyć osobne funkcje lub używać makr).
- **`void` w argumentach:** Jeśli funkcja nie przyjmuje argumentów, dobrą praktyką jest zapis `int main(void)` zamiast `int main()`.
- **Modyfikator `static`:** Ogranicza widoczność funkcji tylko do pliku, w którym została zdefiniowana (enkapsulacja na poziomie modułu).

### Przykład składni:

```c
// Prototyp
int add_numbers(int a, int b);

// Definicja
int add_numbers(int a, int b) {
    return a + b;
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
