	dostęp do zmiennych z poza aktualnie obsługiwanego zasięgu

  
Tworzenie closure:  
- minimum 2 funkcje, jedna w drugiej  
- funkcja zewnętrzna (outer) musi zwracać deklaracje funkcji wewnętrznej (inner)  
- funkcja wewnętrzna (inner) musi używać czegoś (identyfikatora) z funkcji zewnętrznej (outer)  
  
Zalety:  
- persystencję (trwałość) - dodaje persystencje do efemerycznego świata wywołań funkcji  
  
Wady:  
- potencjalnie memory-leak  
  
Definicja:  
- dostęp do zmiennych spoza aktualnie wykonywanego zasięgu

wynika z [[composition]]

```python
def first_fn():  
    x = 42  
  
    def second_fn():  
        return f'Odpowiedź na wszystkie pytania: {x}'  
  
    return second_fn
```

```pyt
```

używane do:
- [[factory fn]]
