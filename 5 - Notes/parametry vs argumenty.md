parametry (to, co jest w definicji funkcji)   pozycyjne i nazwane (defaultowe)

**argumenty**(to, co przekazujemy przy wywołaniu funkcji).  pozycyjne i nazwane

Znak slash mówi, że wszystkie parametry przed mają być pozycyjne

  
```python
def add(a,b, /):

	return a + b

print(add(1,2))

#print(add(1,b=3))

```


  
# po gwiazdce muszą być parametry nazwane  
```python
def add(*,c,d):  
    return c + d

print(add(1,2))
```
[[function]]