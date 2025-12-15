**Idempotentna operacja** to taka, którą można wykonać **wielokrotnie**, a **wynik po pierwszym wykonaniu już się nie zmienia**.

```python
x = "ala"

x.upper()              # "ALA"
x.upper().upper()      # "ALA"
"ALA".upper()          # "ALA"
```

