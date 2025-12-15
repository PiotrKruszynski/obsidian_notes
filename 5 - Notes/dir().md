zwraca wszystkie atrybuty i metody, dostępne dla danego obiektu

```python
x = 10
print([m for m in dir(x) if not m.startswith('__')])
# ['bit_length', 'conjugate', 'denominator', ..., 'to_bytes']
```

**Wskazówka**: do eksploracji warto łączyć dir() z help() albo getattr().

[[dir()]] i [[vars()]] to istotne w [[oop]]
