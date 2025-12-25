
Created: 2025-12-24  13:38
___
Note:

>[!IMPORTANT]
> `__prepare__` odpowiada za **utworzenie przestrzeni nazw klasy** jeszcze _przed_ wykonaniem ciała klasy i umożliwia kontrolę struktury namespace (np. OrderedDict, walidację, rejestrowanie definicji).

>[!IMPORTANT]
> Metody zdefiniowane w metaklasie są **metodami klasy**, a nie metodami instancji — są dostępne na obiekcie klasy, nie na jej instancjach.
> 
> To konsekwencja dwupoziomowego modelu obiektowego Pythona
>   instancja -> klasa -> metaklasa

```python

# zrobimy obiekt, który będzie śledził co się dzieje przy tworzeniu klasy  
  
class TracingMeta(type):  
    # __prepare__ używa się do manipulacji namespace  
    # custom __prepare__ dokłada print do normalnego zachowania    @classmethod  
    def __prepare__(mcs, name, bases, **kwargs): # musieliśmy dołożyć dekorator, bo przed __new__  
        print("TracingMeta.__prepare__")  
        print(f" {mcs=}")  
        print(f'{name=}')  
        print(f'{bases=}')  
        print(f'{kwargs=}')  
        namespace = super().__prepare__(name, bases)  
        print(f'{namespace=}')  
        print("\n\033[94m" + "-" * 40 + "\033[00m")  
        return namespace  
  
    # manipulujemy tworzeniem obiektu klasy  
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
  
    # końcowa konfiguracja obiektu klasy, po utworzeniu  
    def __init__(cls, name, bases, namespace, **kwargs):  
        print("TracingMeta.__init__")  
        print(f" {cls=}")  
        print(f'{name=}')  
        print(f'{bases=}')  
        print(f'{namespace=}')  
        print(f'{kwargs=}')  
        super().__init__(name, bases, namespace) # to nic nie zwraca więc nie ma sensu przypisywać do zmiennej  
        print("\033[94m" + "-" * 40 + "\033[00m\n")  
  
    # metoda klasy, działa Class.meta_method(), w.meta_method() NIE DZIAŁA  
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
  
  
# tak jak obiekt nie może powstawać z dwóch klas, tak metaklasa może mieć tylko jedną metaklasę wynikową - przy wielu wymagane jest ich poprawne dziedziczenie
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

![[Pasted image 20251225121249.png]]

___
Metadata:

```yaml
---
type: tool    # concept | tool | pattern
language: python # python | js | sql | etc.
---
```

Status: #pending
Tags: 
- #python
- #metaclass
- #type
- #oop
- #introspection
- #class-creation