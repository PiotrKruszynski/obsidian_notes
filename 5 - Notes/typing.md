# **Typing w Pythonie (adnotacje typów)**

  
Adnotacje typów w Pythonie **nie zmieniają semantyki runtime**, lecz dostarczają **kontraktów** dla:

- czytelności API,
- statycznej analizy (mypy, pyright),
- lepszego refaktoringu i autocomplete

Python pozostaje **dynamiczny**: typy są danymi dostępnymi w __annotations__.

---
## **Mentalny model (senior)**


> _Nazwa_ → **referencja** do obiektu.

> _Typ_ → **obietnica** (contract), a nie bariera wykonania.

  
Adnotacja:

```
x: int = 42
```

Czytaj precyzyjnie:

- tworzony jest obiekt 42 (może być internowany),
- nazwa x zostaje zbindowana do obiektu 42,
- : int to **metadana**, nie walidacja.

---
## **Podstawy**
```python
name: str
count: int
price: float | None  # PEP 604
items: list[str]
mapping: dict[str, int]
```

None:
```python
from typing import Optional
x: Optional[int]  # = int | None
```

---

## **Generyki i TypeVar**
```python
from typing import TypeVar

T = TypeVar("T")

def first(items: list[T]) -> T:
    return items[0]
```

### **bound**
```python
from typing import Any, TypeVar

T = TypeVar("T", bound=type[Any])

def decorator(cls: T) -> T:
    return cls
```

**Znaczenie**: T może być **tylko podtypem** type[Any] (czyli klasą).

Użyteczne w dekoratorach klas – zachowujesz _konkretny typ klasy_.

---

## **Typy strukturalne (Protocol)**
```python
from typing import Protocol

class HasClose(Protocol):
    def close(self) -> None: ...


def shutdown(resource: HasClose) -> None:
    resource.close()
```

- brak dziedziczenia,
- **duck typing + statyka**.

---

## **Callable, Iterable, Iterator**
```python
from collections.abc import Callable, Iterable, Iterator

fn: Callable[[int, int], int]

def consume(xs: Iterable[int]) -> None: ...

def gen() -> Iterator[int]: ...
```

Preferuj collections.abc zamiast typing (runtime-friendly).

---
## **TypedDict**
```python
from typing import TypedDict

class User(TypedDict):
    id: int
    name: str
```

Dla słowników o stałej strukturze (JSON, DTO).

---

## **Runtime introspection**
```python
class A:
    x: int
    y: str

print(A.__annotations__)
# {'x': int, 'y': str}
```

---

## **Częste pułapki**

- Typy **nie walidują** danych w runtime.
- list[str] ≠ list[Any] (kowariancja / niezmienność).
- Any wyłącza sprawdzanie – używaj świadomie.

---

## **Techniki zapamiętywania**

- **Mnemonika**: _Type = Promise_ (obietnica, nie strażnik).
- **Asocjacja**: Protocol = _kaczy test_ na sterydach.
- **Wzorzec**: API publiczne → dokładne typy, wnętrze → prostota.

---

## **Dokumentacja**

- https://docs.python.org/3/library/typing.html
- https://peps.python.org/pep-0484/
- https://peps.python.org/pep-0544/ (Protocol)
- https://peps.python.org/pep-0604/ (X | Y)

---



# `Type`, `Type[T]` i `TypeVar` w Pythonie

## Idea (Second Brain – **Concept**)

`Type` i `TypeVar` służą do **precyzyjnego opisu relacji typów**, a nie wartości.  
To narzędzia do modelowania **kontraktów metapoziomu**: klas, fabryk, dekoratorów, frameworków.

---

## Mentalny model (kluczowy)

- **wartości** → `int`, `str`, `list[int]`
- **klasy (typy wartości)** → `type[int]`
- **zmienne typowe** → `TypeVar`

> `TypeVar` to **symbol algebraiczny** w systemie typów.  
> Nie jest klasą, nie istnieje w runtime jako typ danych.

---
## 1️⃣ `type` vs `Type`

```python
x = 42
cls = int

print(type(x))   # <class 'int'>
print(type(cls)) # <class 'type'>
```

- `int` jest **obiektem**
- jego typem jest `type`

```python
from typing import Type

cls: Type[int]
```

Czytaj:

> `cls` jest **klasą**, która tworzy obiekty typu `int` lub jego podtypów

---

## 2️⃣ `Type[T]` – klasy jako argumenty

```python
from typing import Type

class Animal: ...
class Dog(Animal): ...


def factory(cls: Type[Animal]) -> Animal:
    return cls()
```

Kontrakt:

- przyjmujesz **klasę**,
    
- która tworzy `Animal` lub jego podklasę,
    
- zwracasz instancję `Animal`.
    

⚠️ Bez `Type` statyczny checker nie wie, że przekazujesz **klasę**, a nie instancję.

---

## 3️⃣ `TypeVar` – zmienna typowa

```python
from typing import TypeVar

T = TypeVar("T")
```

Czytaj:

> „`T` oznacza _jakiś jeden, spójny typ_, nieznany w momencie pisania kodu”

### Przykład klasyczny

```python
def identity(x: T) -> T:
    return x
```

- wejście i wyjście mają **ten sam typ**
    
- `T` wiąże się **przy wywołaniu**, nie przy definicji
    

---

## 4️⃣ `TypeVar` + `Type` (najważniejsze połączenie)

```python
from typing import TypeVar, Type

T = TypeVar("T")

def factory(cls: Type[T]) -> T:
    return cls()
```

Czytaj precyzyjnie:

- `cls` jest **klasą**,
    
- która tworzy **dokładnie ten typ `T`**,
    
- funkcja zwraca **instancję tego samego `T`**.
    

To jest **niemożliwe do wyrażenia bez `TypeVar`**.

---

## 5️⃣ `bound` – ograniczenie dziedziczenia

```python
from typing import Any, TypeVar

T = TypeVar("T", bound=type[Any])
```

Znaczenie:

- `T` musi być **podtypem `type`**,
    
- czyli: **jakąś klasą**.
    

### Typowy przypadek – dekorator klas

```python
T = TypeVar("T", bound=type[Any])

def class_decorator(cls: T) -> T:
    cls.extra = 42
    return cls
```

Bez `bound`:

- checker nie wie, że `cls` ma atrybuty klasowe
    

Z `bound`:

- zachowujesz **konkretny typ klasy** po dekoracji
    

---

## 6️⃣ `TypeVar` vs `Any`

|Cecha|TypeVar|Any|
|---|---|---|
|Zachowuje relacje|✅|❌|
|Sprawdza spójność|✅|❌|
|Wyłącza checking|❌|✅|

> `Any` = „nie wiem i mnie to nie obchodzi”  
> `TypeVar` = „nie wiem jeszcze, ale chcę spójności”

---

## 7️⃣ `covariant` / `contravariant` (skrót mentalny)

```python
T_co = TypeVar("T_co", covariant=True)
```

- **covariant** → tylko output (np. `Sequence[T]`)
    
- **contravariant** → tylko input (rzadkie)
    
- domyślnie → invariant
    

Nie używaj, jeśli nie piszesz **API / frameworku**.

---

## 8️⃣ Runtime prawda (ważne!)

```python
print(T)
# ~T
```

- `TypeVar` **nie istnieje jako typ runtime**
    
- Python **ignoruje** go podczas wykonania
    

System typów = **narzędzie analizy**, nie mechanizm wykonania.

---

## Techniki zapamiętywania

- **Mnemonika**: `TypeVar = algebra`, `Any = chaos`
    
- **Asocjacja**: `Type[T]` = _forma do odlewu obiektu T_
    
- **Wzorzec**: Fabryki, dekoratory, ORM, frameworki → `TypeVar`
    

---

## Dokumentacja

- [https://docs.python.org/3/library/typing.html#typing.TypeVar](https://docs.python.org/3/library/typing.html#typing.TypeVar)
    
- [https://peps.python.org/pep-0484/](https://peps.python.org/pep-0484/)
    
- [https://peps.python.org/pep-0544/](https://peps.python.org/pep-0544/)
    

---

## type: concept  
language: python  
tags: typevar, typing, type, generics, decorators, metaprogramming