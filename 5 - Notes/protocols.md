
Created: 2025-12-17  14:57
___
Note:

[Typing](https://docs.python.org/3/library/typing.html#module-typing )
[Typing-RealPython](https://realpython.com/python-protocol/#predefined-protocols-in-python)

kontrakt bez dziedziczenia
opisuje jakie metody/atrybuty muszą istnieć

obiekt spełnia protokół, jeśli **ma wymagane metody/atrybuty**, niezależnie od dziedziczenia.

**Protokoły wybiera się od strony użytkownika obiektu, nie od strony danych wewnętrznych.**
To jest X, i może zrobić Y,Z
X - semantyka
Y,Z - protokoły

| ABC / Protokół          | Dziedziczy z               | Metody abstrakcyjne                                          | Metody mixin / gotowe                                        | Istotne rzeczy o protokole                                                         |
| ----------------------- | -------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ---------------------------------------------------------------------------------- |
| **[[container ABC]]**   | –                          | `__contains__`                                               | –                                                            | Wystarczy `__contains__`, aby działał operator `in`.                               |
| **[[Hashable]]**        | –                          | `__hash__`                                                   | –                                                            | Obiekt może być kluczem w `dict` i elementem `set`. Musi być niezmienny logicznie. |
| **[[iterable]]**        | –                          | `__iter__`                                                   | –                                                            | Umożliwia iterację w `for`. Zwraca iterator.                                       |
| **[[Iterator]]**        | Iterable                   | `__next__`                                                   | `__iter__`                                                   | Iterator jest jednocześnie iterowalny (`iter(self) is self`).                      |
| **[[Reversible]]**      | Iterable                   | `__reversed__`                                               | –                                                            | Obsługa `reversed(obj)` bez tworzenia kopii.                                       |
| **[[Generator]]**       | Iterator                   | send, throw                                                  | close, `__iter__`, `__next__`                                | Specjalny iterator sterowany przez `yield`.                                        |
| **[[Sized]]**           | –                          | `__len__`                                                    | –                                                            | Wspiera `len(obj)`.                                                                |
| **[[Callable]]**        | –                          | `__call__`                                                   | –                                                            | Obiekt zachowuje się jak funkcja.                                                  |
| **[[Collection]]**      | Sized, Iterable, Container | `__contains__`, `__iter__`, `__len__`                        | –                                                            | Minimalny „pełny” protokół kolekcji.                                               |
| **[[Sequence]]**        | Reversible, Collection     | `__getitem__`, `__len__`                                     | `__contains__`, `__iter__`, `__reversed__`, `index`, `count` | Kolekcja uporządkowana z dostępem po indeksie.                                     |
| **[[MutableSequence]]** | Sequence                   | `__getitem__`, `__setitem__`, `__delitem__`, __len__, insert | append, clear, reverse, extend, pop, remove, `__iadd__`      | Lista – sekwencja modyfikowalna.                                                   |
| **[[ByteString]]**      | Sequence                   | _`_getitem__`, `__len__`                                     | Metody Sequence                                              | Wspólna abstrakcja dla `bytes`, `bytearray`.                                       |
| **[[Set]]**             | Collection                 | `__contains__`, `__iter__`, `__len__`                        | operatory zbiorów, isdisjoint                                | Kolekcja nieuporządkowana, elementy unikalne.                                      |
| **[[MutableSet]]**      | Set                        | `__contains__`, `__iter__`, `__len__`, add, discard          | clear, pop, remove, operatory inplace                        | Modyfikowalny zbiór.                                                               |
| **[[Mapping]]**         | Collection                 | `__getitem__`, `__iter__`, `__len__`                         | keys, items, values, get, `__eq__`, `__ne__`                 | Interfejs słownika (klucz → wartość).                                              |
| **[[MutableMapping]]**  | Mapping                    | `__getitem__`, `__setitem__`, `__delitem__`                  | pop, popitem, clear, update                                  | Modyfikowalny słownik.                                                             |


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