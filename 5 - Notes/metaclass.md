
Created: 2025-12-24  13:38
___
Note:

**Commands**

```python

# zrobimy obiekt, który będzie śledził co się dzieje przy tworzeniu klasy  
  
class TracingMeta(type):  
    # __prepare__ używa się do manipulacji namespace  
    # custom __prepare__ dokłada print do normalnego zachowania    @classmethod  
    def __prepare__(mcs, name, bases, **kwargs): # musieliśmy dołożyć dekorator, bo to niejawna metoda  
        print("TracingMeta.__prepare__")  
        print(f" {mcs=}")  
        print(f'{name=}')  
        print(f'{bases=}')  
        print(f'{kwargs=}')  
        namespace = super().__prepare__(name, bases)  
        print(f'{namespace=}')  
        print("\n\033[94m" + "-" * 40 + "\033[00m")  
        return namespace  
  
    # manipulujemy tworzeniem obiektu  
    def __new__(mcs, name, bases, namespace, **kwargs):  
        print("TracingMeta.__new__")  
        print(f" {mcs=}")  
        print(f'{name=}')  
        print(f'{bases=}')  
        print(f'{namespace=}')  
        print(f'{kwargs=}')  
        cls = super().__new__(mcs, name, bases, namespace)  
        print(f'{cls=}')  
        print("\n\033[94m" + "-" * 40 + "\033[00m")  
        return cls  
  
    # konfiguracja obiektu tej klasy  
    def __init__(cls, name, bases, namespace, **kwargs):  
        print("TracingMeta.__init__")  
        print(f" {cls=}")  
        print(f'{name=}')  
        print(f'{bases=}')  
        print(f'{namespace=}')  
        print(f'{kwargs=}')  
        super().__init__(name, bases, namespace) # to nic nie zwraca więc nie ma sensu przypisywać do zmiennej  
        print("\033[94m" + "-" * 40 + "\033[00m\n")  
  
    # to jest metoda klasy, aby wywołać robię Widget.meta_method(), ale na w.meta_method() NIE DZIAŁA  
    def meta_method(cls):  
        print("TracingMeta.meta_method")  
        print(f" {cls=}")  
  
  
class Widget(object, metaclass=TracingMeta, magic=666):  
    the_answer = 42  
  
    def action(self, message):  
        print(message)  
  
Widget.meta_method()  
  
w = Widget()  
w.action("Hello")  
# w.meta_method() # AtributteError: type object 'Widget' has no attribute 'meta_method'  
# to fancy feature, że metoda klasy nie działa na obiektach. Określam metode w metaklasie i dzieci(obiekty) nie moga się babrać.  
  
  
# tak jak obiekt nie może powstawać z dwóch klas, tak klasa nie może powstawać z 2meta  
class TracingSpecialMeta():  
    def __new__(mcs, name, bases, namespace, **kwargs):  
        print("TracingSpecialMeta.__new__")  
        print(f" {mcs=}")  
        print(f'{name=}')  
        print(f'{bases=}')  
        print(f'{namespace=}')  
        print(f'{kwargs=}')  
        cls = super().__new__(mcs, name, bases, namespace)  
        print(f'{cls=}')  
        print("\033[94m" + "-" * 40 + "\033[00m\n")  
        return cls  
  
class TracingPro(TracingMeta, TracingSpecialMeta):  
    pass

```
```bash
TracingMeta.__prepare__
 mcs=<class '__main__.TracingMeta'>
name='Widget'
bases=(<class 'object'>,)
kwargs={'magic': 666}
namespace={}
----------------------------------------
TracingMeta.__new__
 mcs=<class '__main__.TracingMeta'>
name='Widget'
bases=(<class 'object'>,)
namespace={'__module__': '__main__', '__qualname__': 'Widget', '__firstlineno__': 48, 'the_answer': 42, 'action': <function Widget.action at 0x101b44180>, '__static_attributes__': ()}
kwargs={'magic': 666}
cls=<class '__main__.Widget'>
----------------------------------------
TracingMeta.__init__
 cls=<class '__main__.Widget'>
name='Widget'
bases=(<class 'object'>,)
namespace={'__module__': '__main__', '__qualname__': 'Widget', '__firstlineno__': 48, 'the_answer': 42, 'action': <function Widget.action at 0x101b44180>, '__static_attributes__': ()}
kwargs={'magic': 666}
----------------------------------------
TracingMeta.meta_method
 cls=<class '__main__.Widget'>
Hello
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
