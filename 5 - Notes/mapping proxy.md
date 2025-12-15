 to **specjalny wrapper typu read-only na słownik** w Pythonie

```python
from types import MappingProxyType

d = {"a": 1, "b": 2}
proxy = MappingProxyType(d)

print(proxy["a"])     # 1
d["c"] = 3            # zmiana w oryginale
print(proxy["c"])     # 3 (proxy widzi aktualizację)

proxy["c"] = 4        # TypeError – nie można zmieniać

```

