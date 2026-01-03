Created: 2026-01-03  15:28
___
Note:

>[! Important]
np. open(), służy do wyjątków, błędów i automatyzacji powtarzających się czynności (pliki, locki, połączenia, transakcje, zmiana global).
protokół do zarządzania zasobami 
enkapsuluje wzorzec try / finally 
Gwarantuje poprawne wejście i wyjście z kontekstu wykonania - niezależnie, czy wystąpi wyjątek

# Minimalny kontrakt
	__enter__
		- przed wejściem do bloku with
		- jej wartość zwrotna leci do `f`
	__exit__
		- zwraca False/None-> wyjątek leci dalej. propagowany
		- zwraca True-> stłumiony suppress exception
		- wykonywana zawsze po wyjściu z bloku

![[Pasted image 20260103153725.png]]

to obiekty z `with

Służy do:
- obsługa wyjątków, błędów
- automatyzacja powtarzających się czynności
- Context manager to _mechanizm, który gwarantuje cleanup nawet przy błędach_.

```python
def __enter__(self): ...
def __exit__(self, exc_type, exc_val, exc_tb): ...
```

```python
with SomeContext() as var:
    # blok
```

```python
ctx = SomeContext()
var = ctx.__enter__()
try:
    # blok
finally:
    ctx.__exit__(*sys.exc_info())
```



mój context manager z dowodem, że return true zablokuje przekazanie info o błędzie :D

```python
class Yolo:
	def __init__(self):
		print('init')
	
	def __enter__(self):
		print('entering')
		return self

	def __exit__(self, exc_type, exc_val, exc_tb):
		if exc_type:
			print('exception')
		else:
			print('exiting')
		return True # nie da błędu. True blokuje propagacje błędu wyżej!! -             return False = **propaguj wyjątek dalej** !!


with Yolo() as y:
	print('normal code')
	raise Exception(' o kurde coś nie poszło ... ') # __exit odpali sie tu jak błąd lub po raise jak nie ma błędu
	
# init
# entering
# normal code
# exception
```

### **Do zapamiętania**

- Context manager MUSI mieć __enter__ **i** **__exit__****.
- **__enter__** **zwraca zasób.**
- **__exit__** **sprząta zasób.**
- **__exit__** **dostaje pełną informację o ewentualnym wyjątku.**
- __exit__ może ZATRZYMAĆ wyjątek, zwracając True
- Instrukcja **with** = try/finally + enter/exit.

![[context manager 1.png]]


jeszcze jedna ważna sprawa
każdy obiekt, który spełnia protokół cm -> enter i exit działa tylko z słowem kluczowym with.

jak zrobie

result = Yolo()
wykona się tylko init


można też dekoratorem @contextmanager

```python

from contextlib import contextmanager

@contextmanager
def yolo():
	# __enter__
	
	yield "cos tam"
	
	# __exit__

```

W tym bloku kodu oczekuje ze zostanie rzucony StopIteration
- jak wystąpi -> test przechodzi
- nie wystąpi -> test failuje
- wystąpi inny wyjątek -> test failuje

```python
def test_iter(sorted_frozen_set_duplicates):  
    iterator = iter(sorted_frozen_set_duplicates)  
    assert next(iterator) == 1  
    assert next(iterator) == 2  
    assert next(iterator) == 7  
    assert next(iterator) == 9  
  
    with pytest.raises(StopIteration):  
        next(iterator)
```
[[protocols]]



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
