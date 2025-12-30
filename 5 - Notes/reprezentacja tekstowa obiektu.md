```bash
repr(obj)        → obj.__repr__()
str(obj)         → obj.__str__()
print(obj)       → str(obj)
f"{obj}"         → format(obj) → obj.__format__("")
f"{obj:spec}"    → obj.__format__("spec")
bytes(obj)       → obj.__bytes__()
REPL / debugger  → repr(obj)
```

1️⃣ `__repr__` — reprezentacja techniczna (programista, debug) , _możliwy do odtworzenia obiektu_
```python
class Vector:
    def __init__(self, x: float, y: float):
        self.x = x
        self.y = y

    def __repr__(self) -> str:
        return f"{type(self).__name__}(x={self.x!r}, y={self.y!r})"

    def __str__(self) -> str:
        return f"({self.x}, {self.y})"
```

2️⃣ __str__ — reprezentacja użytkowa (człowiek)
_jak nie istnieje python używa `__repr__`

3️⃣  __format__ — pełna kontrola nad f"{obj:spec}"

`f"{obj:SPEC}"`

```python
class Money:
    def __init__(self, value: float):
        self.value = value

    def __format__(self, spec: str) -> str:
        if spec == "eur":
            return f"{self.value:.2f} €"
        if spec == "usd":
            return f"${self.value:.2f}"
        return format(self.value, spec)
```

4️⃣ `__bytes__` — reprezentacja binarna
```python
class Packet:
    def __bytes__(self) -> bytes:
        return b"\x01\x02\x03"
```

Wzorzec proodukcyjny
```python
class Vector:
    def __init__(self, x: float, y: float):
        self.x = x
        self.y = y

    def __repr__(self) -> str:
        return f"{type(self).__name__}(x={self.x!r}, y={self.y!r})"

    def __str__(self) -> str:
        return f"({self.x}, {self.y})"

    def __format__(self, spec: str) -> str:
        if spec == "polar":
            return f"r=?, θ=?"
        return str(self)
```

