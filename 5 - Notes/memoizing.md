

zapamiętywanie wyniku funkcji, żeby reużyć, bez ponownego obliczania
to technika cach'owania  

 Zasady: 
 - [[pure functions]]
 - kombinacji parametrów musi byc względnie nie duża ilość
 - ograniczona ilość kombinacji parametrów


```python
# Stwórz fn pamięć podręczna -> która zapamięta wynik, tak by później go reużyć

from time import sleep

def memoize(cb):  
    cache = {}  
  
    def inner(*args):  
        if args not in cache:  
            cache[args] = cb(*args)  
        return cache[args]  
  
    return inner

  
  
def calculate_magic(a,b,/):  
    # intensive CPU task  
    sleep(3)  
    return a + b  
  
def calculate_tribonacci(a, b, c,/):  
    # intensive CPU task  
    sleep(3)  
    return a + b + c  
  
calculate_magic_cache = memoize(calculate_magic)  
calculate_tribonachi_cache = memoize(calculate_tribonacci)  
  
print(calculate_magic_cache(1,2))  
print(calculate_magic_cache(2,2))  
print(calculate_tribonachi_cache(1,2,4))  
print(calculate_tribonachi_cache(2,2,3))

```

