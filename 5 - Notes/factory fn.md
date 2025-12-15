[[design pattern]] -> optymalne rozwiązanie do często występujących problemów

Wzorzec projektowy fabryki

- funkcja, która tworzy obiekty innej funkcji

```python

def power_n(exponent):  
    def inner(base):  
        return base ** exponent  
  
    return inner  
  
power_2 = power_n(2)  
  
print(power_2(2))

```