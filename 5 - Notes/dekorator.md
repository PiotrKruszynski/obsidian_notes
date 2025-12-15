	binduje name do obiektu


- [[design pattern ]]
- funkcjonalność python  
  - dekoratory funkcji (konieczne użycie closure)  
  - dekoratory class (sexy alternatywa do [[metaclass]])  
  
Możliwość modyfikacji działania funkcji bez zmiany jej implementacji.


  

Ad.1  
  
Dekorator to funkcja, która dodaje lub modyfikuje działanie innej funkcji.  
Dekorator nakłada się na deklarację fn.
  

  
```python
def upper(fn):  
    def inner(name):  
        return fn(name).title()  
  
    return inner 
``` 

dekorator binduje nowe ciało funkcji do identyfikatora

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
  
@reverse  
def hello(name):  
    return f'Hello {name}'  
  
print(hello('jarosław'))

```

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
@gen_html # lub gen_html() !!  
def hello(name):  
    return f'Hello {name}'

print(hello('ola'))

```



klasy

```python
class Example:
	def __init__(self,p):
	self.p = p
	
	@property
	def p (self):
		return self._p
		
	@p.setter
	def p(self, value):
	self._p = value

```