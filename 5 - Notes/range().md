generator danych

```python
print(*range(0,10)) # range jest iterable, print przyjmuje nieskończoną wartość parametrów. * rozpakowuje wartości
print(*range(10))
print(*range(2,11,3))
print(*range(10,1, -1)) # jak ujemny step, trzeba odwrócić
print([x / 10 for x in range(0,11)])
```

