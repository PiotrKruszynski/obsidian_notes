---
title: "introspection"
type: concept
topic: python
tags: ["python"]
created: 2026-06-09
status: draft
---

odczytywanie kodu, 
	sprawdzanie z jakimi parametrami poszła funkcja, jakich ma memberów.

Metody do introspekcji:

1️⃣  [[type()]]

```python
i = 7
type(i)
# <class 'int'>

# to samo
i.__class__
```

2️⃣ `repr()` - reprezentacja tekstowa stworzona do użycia obiektu ( [[reprezentacja tekstowa obiektu|repr vs. str]] )
```python
i = 7
repr(i)
# '7'
type(i)(42)
# 42
type(type(i))
# <class 'type'>

```

3️⃣ `isinstance()`    /   `issubclass()`  ( [[issubclass() vs isinstance()]] )
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

# import inspect
[Dokumentacja (oficjalna)](https://docs.python.org/3/library/inspect.html) 

```python
import inspect

inspect.getsource(func)      # kod źródłowy
inspect.signature(func)      # sygnatura
inspect.isclass(obj)         # czy to klasa
inspect.ismethod(obj)        # czy metoda
```
### Co potrafi?

|**Obiekt**|**Co możesz sprawdzić**|
|---|---|
|funkcja|sygnatura, parametry, docstring, kod źródłowy|
|klasa|metody, atrybuty, MRO|
|obiekt|typ, metody, moduł pochodzenia|
|stack|aktualna ramka, caller|
|moduł|zawartość, lokalizacja pliku|

### **🔹 Informacje o typie obiektu**

- inspect.isfunction(obj) – sprawdza, czy obiekt jest funkcją
- inspect.ismethod(obj) – czy jest metodą instancji
- inspect.isclass(obj) – czy jest klasą
- inspect.isbuiltin(obj) – czy jest funkcją wbudowaną (C)
- inspect.isgenerator(obj) – czy jest generatorem
- inspect.isgeneratorfunction(obj) – czy funkcja zwraca generator
- inspect.iscoroutine(obj) – czy jest coroutine
- inspect.iscoroutinefunction(obj) – czy funkcja async
- inspect.isasyncgen(obj) – czy async generator
- inspect.isasyncgenfunction(obj) – czy async generator function
- inspect.ismodule(obj) – czy moduł
- inspect.isdatadescriptor(obj) – czy deskryptor danych
- inspect.isframe(obj) – czy ramka stosu (frame)

---

### **🔹 Sygnatura i argumenty funkcji**

- inspect.signature(callable) – pełna sygnatura wywołania (parametry + typ zwracany) np. inspect.signature(`<nazwapliku>.<klasa>.<co_kolwiek>).parametres["jakiś_param"]`
```python
import inspect

inspect.signature(add).parameters['a'].annotation
```
- inspect.getfullargspec(func) – kompletna specyfikacja argumentów (starsze API)
- inspect.getargvalues(frame) – wartości argumentów w danej ramce stosu

---

### **🔹 Kod źródłowy**

- inspect.getsource(obj) – zwraca kod źródłowy obiektu
- inspect.getsourcelines(obj) – kod + numer pierwszej linii
- inspect.getfile(obj) – plik, w którym obiekt jest zdefiniowany
- inspect.getmodule(obj) – moduł, z którego pochodzi obiekt

---

### **🔹 Atrybuty i zawartość obiektów**

- ***inspect.getmembers(obj) – lista (nazwa, wartość) wszystkich atrybutów
- inspect.getmembers(obj, predicate) – atrybuty spełniające warunek (np. tylko metody)
- inspect.getattr_static(obj, name) – atrybut **bez uruchamiania deskryptorów**

---

### **🔹 Stos wywołań (call stack)**

- inspect.currentframe() – aktualna ramka stosu
- inspect.stack() – pełny stos wywołań
- inspect.getouterframes(frame) – ramki wywołujące
- inspect.getinnerframes(tb) – ramki z tracebacka
- inspect.trace() – skrócona forma stack trace

---

### **🔹 Ramki, tracebacki, kontekst**

- inspect.getframeinfo(frame) – informacje o ramce (linia, plik, kod)
- inspect.getlineno(obj) – numer linii definicji
- inspect.getclosurevars(func) – zmienne z zamknięcia (closure)
- inspect.cleandoc(doc) – czyści wcięcia w docstringach
- ***inspect.getdoc(obj) -*** 
	- zwraca str albo None
	- usuwa wspólne wcięcia (dedent)
	- normalizuje białe znaki
	- **dziedziczy docstring**, jeśli obiekt go nie ma

## **getdoc() *vs*   __doc__**

| **Cecha**              | `__doc__` | `inspect.getdoc()` |
| ---------------------- | :-------: | :----------------: |
| Surowy tekst           |     ✅     |         ❌          |
| Usuwa wcięcia          |     ❌     |         ✅          |
| Normalizuje whitespace |     ❌     |         ✅          |
| Dziedziczy docstring   |     ❌     |         ✅          |
| Bezpieczne API         |     ❌     |         ✅          |

---

### **🔹 Klasy i dziedziczenie**

- inspect.getmro(cls) – kolejność rozwiązywania metod (MRO)
- inspect.classify_class_attrs(cls) – klasyfikacja atrybutów klasy

---

### **🔹 Specjalne / zaawansowane**

- inspect.unwrap(func) – usuwa dekoratory (dociera do oryginału)
- inspect.formatannotation(obj) – formatowanie adnotacji typów
- inspect.formatargspec(...) – formatowanie argumentów (legacy)

---

## **Minimalna ściąga mentalna**

- **Co to jest?** → is*
- **Jak wywołać?** → signature
- **Skąd pochodzi?** → getmodule, getfile
- **Jak wygląda w środku?** → getsource, getmembers
- **Kto mnie wywołał?** → currentframe, stack
- **Jakie dekoratory?** → unwrap

---


```python
from itertools import chain  
  
  
class Batch: # wywołuje metaklasę type i tworzy nowy obiekt  
    def __init__(self, iterables=()):  
        self._iterables = list(iterables)  
  
    def append(self, iterable):  
        self._iterables.append(iterable)  
  
    def __iter__(self): # dzięki temu mamy spełniony protokół iterable  
        return chain.from_iterable(self._iterables)
```
```bash

```
