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

