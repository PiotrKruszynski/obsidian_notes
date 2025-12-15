python Nie implementuje TCO tail call optimization

- **Tail call** = „wywołaj i natychmiast przekaż jego wynik dalej”.
- - W językach z TCO (Scheme, Haskell, OCaml) kompilator zamienia taki przypadek w zwykłą pętlę → stos się nie powiększa.

```python
def sum_acc(n, acc=0):
    if n == 0:
        return acc
    return sum_acc(n-1, acc+n)

print(sum_acc(1000))        # działa
print(sum_acc(10000))       # RecursionError
```

poprawiona

```python 
def sum_iter(n):
    acc = 0
    while n > 0:
        acc += n
        n -= 1
    return acc
```

można też oszukać stos trampoliną 

```python
  
def tramp(gen, *arg, **kwarg):  
    g = gen(*arg, **kwarg)  
  
    while isinstance(g, types.GeneratorType):  
        g = next(g)  
  
    return g
```

g = next(g) - wyciąga kolejne pietro rekurencji
dopóki zwraca generatory trampolina je rozpakowuje.
Gdy zwykła wartość (np int), pętla się kończy i zwraca wynik