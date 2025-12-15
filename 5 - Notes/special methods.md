	dunder methods

do ich utworzenia używamy [[protocols]]

https://docs.python.org/3/reference/datamodel.html#special-method-names

Dzięki nim obiekt może implementować **protokół Pythona** (np. być iterowalny, kontekstowy, liczbowy, wywoływalny).

są zdefiniowane w klasie (class object). Jak zdefiniuje obiekt, interpreter szuka w `obj.__class__`

python jest zbudowany z dwóch api
- high level api
- low level api -> zbudowane na features

pomiędzy low i high leży potężna optymalizacja
odwoływanie bezpośrednio do low level api powoduje wyłączenie całej optymalizacji pythona

| **Nazwa**                                          | **Kiedy działa**         | **Przykład użycia**                    |                  |
| -------------------------------------------------- | ------------------------ | -------------------------------------- | ---------------- |
| `__init__`                                         | tworzenie obiektu        | def __init__(self, x):                 |                  |
| `__str__ - reprezentacja tekstowa dla użytkownika` | str(obj) albo print(obj) | def __str__(self):                     |                  |
| `__repr__`                                         | repr(obj) i debugowanie  | def __repr__(self):                    |                  |
| `__len__`                                          | len(obj)                 | def __len__(self):                     | `obj.__len__()`  |
| `__getitem__`                                      | obj[key]                 | def __getitem__(self, key):            |                  |
| `__setitem__`                                      | obj[key] = val           | def __setitem__(self, key, val):       |                  |
| `__call__`                                         | obj()                    | def __call__(self):                    | `obj.__call__()` |
| `__eq__`                                           | obj1 == obj2             | def __eq__(self, other):               |                  |
| `__add__`                                          | obj1 + obj2              | def __add__(self, other):              |                  |
| `__enter__`                                        | kontekst with            | def __enter__(self):                   |                  |
| `__exit__`                                         | wyjście z kontekstu      | def __exit__(self, exc_type, exc, tb): |                  |
|                                                    |                          |                                        |                  |
```python
class Vector2D:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __add__(self, other):
        return Vector2D(self.x + other.x, self.y + other.y)

    def __len__(self):
        return 2

    def __str__(self):
        return f"({self.x}, {self.y})"

v1 = Vector2D(1, 2)
v2 = Vector2D(3, 4)

print(v1 + v2)   # (4, 6)
print(len(v1))   # 2
```

[[oop]]