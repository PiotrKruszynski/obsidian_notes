odczytywanie kody.
sprawdzanie z jakimi parametrami poszła funkcja

Metody do introspekcji:
```python
i = 7
type(i)
# <class 'int'>

# to samo
i.__class__
```

```python
i = 7
repr(i)
# '7'
type(i)(42)
# 42
type(type(i))
# <class 'type'>

```