

| tuple                                                                              | list                       | dict                                                                                           |
| ---------------------------------------------------------------------------------- | -------------------------- | ---------------------------------------------------------------------------------------------- |
| IMMUTABLE                                                                          | MUTABLE                    | MUTABLE                                                                                        |
| count(), index()                                                                   | wiele                      |                                                                                                |
| jest hashowalna                                                                    | nie jest hashowalna        | nie jest hashowalny, Klucze muszą być hashowalne (można użyć tupli, ale nie listy jako klucza) |
| ()                                                                                 | []                         | {}                                                                                             |
| wydajniejsza na poziomie alokacji pamięci i szybkości przetwarzania przez procesor | -                          | Optymalizowany pod kątem szybkiego dostępu przez klucz (O(1))                                  |
| alokuje tylko tyle pamięci ile jest potrzebne                                      | dynamicznie alokuje pamięć | dynamicznie alokuje pamięć                                                                     |
| nie trzeba sprawdzać czy jest tym czym było - mniejsza ilość operacji CPU          | -                          | -                                                                                              |


packing 

```python
x = 1, 2, 3, 4

print(type(x))

```

```python
def magic():
	return 1, 2, 3, 4
```

unpacking -> działa na każdym sequence !! ( rest2)

	do szybkiego tworzenia zmiennych

a, b, c = (1, 2, 3)

```python
x, y = y, x # tuple unpacking = tuple packing
```

 ```python
a,b, *rest = "ala ma kota"
print(rest)


c,d, *rest2 = [1,2,3,4,5,6]
print(rest2)

```

musi zawierać hashowalne typy danych aby była hashowalna