	
	obiekt <iterable objects> , który iteruje
	 `__iter__()` -> zwraca samego siebie (self)
	 `__next__()` -> zwraca kolejny element albo StopIteration

trzymają następny element w swoim stanie

każdy iterator musi być iterable

```python
_it = iter(iterable)        # _it = iterable.__iter__()
while True:
    try:
        x = next(_it)       # _it.__next__()
    except StopIteration:
        break
```

każdy generator to od razu iterator


minimalny iterator

```python
class CountDown:
    def __init__(self, start: int):
        self.current = start

    def __iter__(self):
        return self  # iterator zwraca sam siebie

    def __next__(self):
        if self.current <= 0:
            raise StopIteration  # sygnał końca iteracji
        self.current -= 1
        return self.current + 1
```

uzycie

```python
for x in CountDown(5):
    print(x)
```


`cd = CountDown(5)`

- cd jest **iterable** (bo ma metodę __iter__).
- Po wywołaniu iter(cd) dostajemy **iterator** – w tym przypadku ten sam obiekt (self).
- Wywołania next(cd) będą zwracały kolejne liczby aż do StopIteration.

## Prostszym sposobem tworzenia iteratora jest yield

```python
def countdown(start: int):
    while start > 0:
        yield start
        start -= 1
```

uzycie

```python
for x in countdown(5):
    print(x)
```


`g = countdown(5)`

- g nie jest zwykłym iterable, tylko od razu **generator object**.
- Generator **jest jednocześnie iterable i iteratorem**:
    - ma __iter__ (zwraca samego siebie),
    - ma __next__ (wznowienie od ostatniego yield).

[[design pattern]]
[[protocols]]