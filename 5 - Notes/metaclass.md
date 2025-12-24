
Created: 2025-12-24  13:38
___
Note:

**Commands**

```python

class TracingMeta(type):  
    # __prepare__ służy do ustawienia namespace
    # custom __prepare__ dokłada print do normalnego zachowania  
    @classmethod  
    def __prepare__(mcs, name, bases, **kwargs): # musieliśmy dołożyć dekorator bo __prepare__ przed __new__ 
        print("TracingMeta.__prepare__")  
        print(f" {mcs=}")  
        print(f'{name=}')  
        print(f'{bases}')  
        print(f'{kwargs}')  
        namespace = super().__prepare__(name, bases)  
        print(f'{namespace=}')  
        print()  
        return namespace  # do 2018r dawało się tutaj OrderDict()
  
  
class Widget(object, metaclass=TracingMeta):  
    pass

```
```bash
TracingMeta.__prepare__
mcs=<class '__main__.TracingMeta'>
name='Widget'
bases=(<class 'object'>,)
kwargs={}
namespace={}
```



___
Metadata:

```yaml
---
type: tool    # concept | tool | pattern
language: python # python | js | sql | etc.
---
```

Status: #pending
Tags: #empty
