

## * - Rozpakowywanie tupli/list

### Podstawowe użycie

python

```python
# Rozpakowywanie tupli
dane = (1, 2, 3)
print(*dane)  # wynik: 1 2 3 

# To samo co:
print(1, 2, 3)
```

### W funkcjach

python

```python
def suma(a, b, c):
    return a + b + c

liczby = [10, 20, 30]
wynik = suma(*liczby)  # rozpakowuje listę jako argumenty
print(wynik)  # 60
```

### Praktyczny przykład

python

```python
# Łączenie list
lista1 = [1, 2, 3]
lista2 = [4, 5, 6]
polaczone = [*lista1, *lista2]  # [1, 2, 3, 4, 5, 6]
```

## ** - Rozpakowywanie słowników

### Podstawowe użycie

python

```python
def przedstaw_sie(imie, wiek, miasto):
    print(f"Cześć, jestem {imie}, mam {wiek} lat i mieszkam w {miasto}")

dane = {'imie': 'Anna', 'wiek': 25, 'miasto': 'Kraków'}
przedstaw_sie(**dane)  # rozpakowuje słownik jako argumenty nazwane
```

### Łączenie słowników

python

```python
podstawowe = {'imie': 'Jan', 'wiek': 30}
dodatkowe = {'miasto': 'Warszawa', 'zawod': 'programista'}

pelne_dane = {**podstawowe, **dodatkowe}
# {'imie': 'Jan', 'wiek': 30, 'miasto': 'Warszawa', 'zawod': 'programista'}
```

## Kombinacje i triki

### Mieszanie argumentów

python

```python
def funkcja(a, b, c, imie, wiek):
    print(f"Liczby: {a}, {b}, {c}")
    print(f"Osoba: {imie}, {wiek} lat")

liczby = (1, 2, 3)
dane = {'imie': 'Piotr', 'wiek': 28}

funkcja(*liczby, **dane)
```

### Kopiowanie z modyfikacją

python

```python
original = {'a': 1, 'b': 2}
nowy = {**original, 'c': 3, 'b': 99}  # nadpisuje 'b'
# {'a': 1, 'b': 99, 'c': 3}
```

## Częste błędy

❌ **Błąd:**

python

```python
lista = [1, 2, 3]
print(lista)  # wynik: [1, 2, 3] - z nawiasami
```

✅ **Poprawnie:**

python

```python
lista = [1, 2, 3]
print(*lista)  # wynik: 1 2 3 - bez nawiasów
```

## Zapamiętaj

- ***** = rozpakowuje sekwencje (listy, tuple)
- ****** = rozpakowuje słowniki (klucze stają się nazwami argumentów)
- Kolejność ma znaczenie przy łączeniu
- Można kombinować oba sposoby

#python #funkcje #argumenty #rozpakowywanie #tuple #słowniki