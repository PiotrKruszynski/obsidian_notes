odwlekanie obliczeń do momentu jak są potrzebne.

Typowe narzędzia

- [[generators]] (yield) i [[generator expression]]
    
- iteratory (map, filter, itertools)
    
- funkcje leniwe (np. open().readline, pathlib.Path.glob)

kiedy wykorzystujemy?

- duże kolekcje danych
- kosztowne operacje
- zagnieżdżone przekształcenia danych - w map,filter, generator expression by uniknąć tymczasowych list

```python

a = [x for x in range(10)]

print(a)

print("------------------")

b = (x for x in range(10))

print(b)

```

generatorem 
iteratorem (jak bez pętli)

kiedy należy [[materialized object]] dla lazy evaluation?  

[[reactive programming]]
[[edd]]
