1. `[range(10)]` nie ewaluuje range'a
```python
r = range(10)
print(r)          # range(0, 10)
print([r])       # [range(0, 10)]
print(type(r))    # <class 'range'>
print(list(r))    # [0,1,2,3,4,5,6,7,8,9]
```
