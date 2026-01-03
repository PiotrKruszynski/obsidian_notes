Created: 2026-01-03  15:28
___
Note:

>[! Important]
np. open(), służy do wyjątków, błędów i automatyzacji powtarzających się czynności (pliki, locki, połączenia, transakcje, zmiana global).
protokół do zarządzania zasobami 
try / finally na sterydach
Gwarantuje poprawne wejście i wyjście z kontekstu wykonania - niezależnie, czy wystąpi wyjątek

# Minimalny kontrakt:
	__enter__
		- przed wejściem do bloku with
		- jej wartość zwrotna leci do `f`
		- najczęściej zwraca siebie (self)
	__exit__
		- zwraca False/None (domyślnie nie ma return w __exit__ -> wyjątek leci dalej. propagowany
		- zwraca True-> stłumiony, blokuje delegacje dalej (suppress exception)
		- wykonywana zawsze po wyjściu z bloku

![[Pasted image 20260103153725.png]]

```python
class Yolo:  
    def __init__(self):  
        print("init")  
  
    def __enter__(self, *args, **kwargs):  
        print("entering")  
        return self  
  
    def __exit__(self, exc_type, exc_val, exc_tb):  
        if exc_type:  
             print("exception")  
        else:  
            print("exiting")  
        return False  
  
with Yolo() as y:  
    print("normal code")  
    raise Exception('oops')  
  
print("kod widoczny gdy return True, return false zatrzyma wykonanie i wyrzuci błąd")
```
```
init
entering
normal code
exception
Traceback (most recent call last):
    raise Exception('oops')
Exception: oops
```


# Służy do:
- obsługa wyjątków, błędów
- automatyzacja powtarzających się czynności
- Context manager to _mechanizm, który gwarantuje cleanup nawet przy błędach_.

# Do zapamiętania:

- Context manager MUSI mieć __enter__ **i** **__exit__****.
- **__enter__** zwraca zasób.
- **__exit__** sprząta zasób.
- **__exit__** dostaje pełną informację o ewentualnym wyjątku.
- __exit__ może ZATRZYMAĆ wyjątek, zwracając True
- Instrukcja **with** = try/finally + enter/exit.

![[context manager 1.png]]


# a co bez with .. ?
dla każdego obiektu, który spełnia protokół CM -> enter i exit działa tylko z słowem kluczowym with.

```python
# with open('tekst.txt', 'w') as f:
#    f.write('test')

file = open('test.txt., 'r')
print(file.read())
file.close() # też zamyka ale jak pojawi się błąd w trakcie NIE zamknie
```


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
