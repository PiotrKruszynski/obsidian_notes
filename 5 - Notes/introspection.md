odczytywanie kodu, 
sprawdzanie z jakimi parametrami poszła funkcja, jakich ma memberów.

Metody do introspekcji:
`type()`
```python
i = 7
type(i)
# <class 'int'>

# to samo
i.__class__
```

`repr()` - reprezentacja tekstowa stworzona do użycia obiektu
```python
i = 7
repr(i)
# '7'
type(i)(42)
# 42
type(type(i))
# <class 'type'>

```

