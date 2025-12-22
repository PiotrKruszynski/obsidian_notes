
Created: 2025-12-22  16:54
___
Note:

	odczytywanie kodu, 
	sprawdzanie z jakimi parametrami poszła funkcja, jakich ma memberów.

Metody do introspekcji:

1️⃣  `type()`

```python
i = 7
type(i)
# <class 'int'>

# to samo
i.__class__
```

2️⃣ `repr()` - reprezentacja tekstowa stworzona do użycia obiektu
```python
i = 7
repr(i)
# '7'
type(i)(42)
# 42
type(type(i))
# <class 'type'>

```

3️⃣ `isinstance()`    /   `issubclass()`
```python
isinstance([1,2], list)          # True
issubclass(bool, int)            # True
```

`dir()`

dir("abc") -> lista dostępnych atrybutów

4️⃣ `hasattr(obj, "attr")`    /    `getattr(obj, "attr", default)`

```python

hasattr(user, "email") # True v False (sprawdza getattr i jak poleci AttributeError -> False)

email = getattr(user, "email")


```

5️⃣ `__dict__`

`obj.__dict__` -> rzeczywiste pola obiektu

## import inspect

```python
import inspect

inspect.getsource(func)      # kod źródłowy
inspect.signature(func)      # sygnatura
inspect.isclass(obj)         # czy to klasa
inspect.ismethod(obj)        # czy metoda
```






___
Metadata:

```yaml
---
type: tool    # concept | tool | pattern
language: python # python | js | sql | etc.
---
```

Status: #pending
Tags: #empty
