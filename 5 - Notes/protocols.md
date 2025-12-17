
Created: 2025-12-17  14:57
___
Note:

https://docs.python.org/3/library/typing.html#module-typing 

obiekt spełnia protokół, jeśli **ma wymagane metody/atrybuty**, niezależnie od dziedziczenia.

## **Istota Protocol**

- **Nie wymaga dziedziczenia** od klasy bazowej.
- Sprawdza **kształt (shape)** obiektu: nazwy i sygnatury metod/atrybutów.
- Współpracuje z narzędziami statycznymi (mypy, pyright).
- Może być użyty **runtime** tylko z @runtime_checkable (ograniczenia!).


___
Metadata:

```yaml
---
type: tool    # concept | tool | pattern
language: python # python | js | sql | etc.
level: beginner  # beginner | intermediate | advanced
status: understood    # draft | understood
---
```

Status: #pending
Tags: #empty





[[virtual inheritance]] + sprawdzanie czy dana klasa jest podklasą innej klasy = [[protocols]]

dzięki nim możemy dodać nowe funkcjonalności

np. żeby działał for klasa musi mieć  obiekt iteratora:`__iter__`


znam protokoły
[[iterable]] `__iter__`
[[iterator]] `__iter__ + __next__`
[[context manager]] `__enter__ + __exit__`
callable protocole `__call__`


```python
class FileLines:
    def __init__(self, path):
        self.path = path
        self.file = None

    def __enter__(self):
        self.file = open(self.path, 'r')
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        if self.file:
            self.file.close()

    def __iter__(self):
        return self

    def __next__(self):
        line = self.file.readline()
        if not line:
            raise StopIteration
        return line.strip()


with FileLines('plik.txt') as lines:
    for line in lines:
        print(line)


```

## **📌 Techniczne ciekawostki i kluczowe pojęcia**

- collections.abc definiuje formalne klasy bazowe (Iterable, Iterator, ContextManager) – możesz ich używać w isinstance().
    
- contextlib ma dekoratory ułatwiające tworzenie context managerów (@contextmanager).
    
- yield w generatorach automatycznie implementuje __iter__() i __next__() (→ są iteratorami).
    
- StopIteration → kluczowy wyjątek kończący iterację.
    
- contextlib.closing(), contextlib.suppress() – typowe context managery.