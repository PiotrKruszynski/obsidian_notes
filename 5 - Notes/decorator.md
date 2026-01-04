Created: 2026-01-04  11:47
___
Note:

>[! Definicja]
> **binduje name do nowego obiektu**
> Dekorator = name = decorator(name)

```python
@decorator
def fn(...):
    ...
# synthetic sugar do
fn = decorator(fn)
```

  -  [[design pattern ]] 
  - dekoratory funkcji (konieczne użycie [[closure]])  
  -  [[decorator class]] (sexy alternatywa do metaclass)  
  -  możliwość modyfikacji _działania_ funkcji bez zmiany jej implementacji.

Dekorator to funkcja, która dodaje lub modyfikuje działanie innej funkcji.  
Dekorator nakłada się na deklarację fn.
  
```python
def upper(fn):  
    def inner(name):  
        return fn(name).title()  
  
    return inner 
``` 

# dekorator binduje nowe ciało funkcji do identyfikatora

```python
def capitalize(function):  
    def inner(name):  
        return function(name.capitalize())  
  
    return inner  
  
def reverse(fn):  
    def inner(name):  
        return fn(name[::-1])  
  
    return inner
    
@reverse  
@capitalize  
def hello(name):  
    return f'Hello {name}'  
  
print(hello('jarosław'))  
  
# Hello Wałsoraj

```

[curring]  [partial application]
```python

def capitalize(function):  
    def inner(name):  
        return function(name.capitalize())  
  
    return inner


def inner_wrapper(fn, tag, highlight):  
    def inner(name):  
        result = fn(f'<{highlight}>{name}</{highlight}>')  
        return f'<{tag}>{result}</{tag}>'  
  
    return inner  
  
  
def gen_html(tag='h1', highlight = 'b'):  
  
    if callable(tag):  
        return inner_wrapper(tag, 'h1', highlight)  
    else:  
        def wrapper(fn):  
            return inner_wrapper(fn, tag, highlight)  
  
        return wrapper  
  
  
@capitalize  
@gen_html # lub @gen_html('div', 'i') !!  
def hello(name):  
    return f'Hello {name}'

print(hello('ola'))

# <h1>Hello <b>Ola</b></h1>

```


___
Metadata:

```yaml
---
type: pattern
language: python
---
```

Status: #pending
Tags: #decorator #rebinding #namespace #losure #functional-programming #design-pattern #proxy #wrapper #metaprogramming #python-internals
