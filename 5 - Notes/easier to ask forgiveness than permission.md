## **EAFP — “Easier to Ask Forgiveness than Permission”**

nie sprawdzamy, czy to jest możliwe tylko po prostu to robimy

> **Python nie pyta — Python próbuje.**

> Jeśli coś nie działa → łapie wyjątek.


```python
try:

    value = my_dict["x"]

except KeyError:

    value = 42
```

```python
# bez EAFP
if x != 0:  
    print(10/x)  
  
# z EAFP
try:  
    10 / x  
except ZeroDivisionError:  
    print("Can't divide by zero")
```


[[python rules]]