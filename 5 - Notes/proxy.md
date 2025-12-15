to pudełko , które może ograniczać dostęp do oryginalnej funkcji obiektu, może modyfikować, może dodawać mu różnych funkcjonalności

obiekt opakowujemy innym obiektem
ziemniak opakowujemy torebką -> torebka jest proxy dla ziemniaka
sok pakujemy w proxy z nakrętką -> 
kontnener w dokerze to proxy ->
wódka w USA pakujemy w torbę -> torma jest proxy i umożliwia picie w miejscch publicznych

[[super()]] - proxy do klasy bazowej, przekierowuje do nadklasy 

```python
class NameFive:  
    def __new__(cls, *args: Any, **kwargs: Any) -> "NameFive":  
        self = super().__new__(cls)  
        return self  
  
    def __init__(self, value):  
        self.value = value
```

własne proxy
```python
class LoggingProxy:
    def __init__(self, real_obj):
        self._real_obj = real_obj

    def __getattr__(self, name):
        print(f"Proxy: wywołanie {name}")
        return getattr(self._real_obj, name)
```

[[__new__]]

[[oop]]
[[design pattern]]
[[metaprogramming]]

#study