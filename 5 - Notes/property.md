metaclass

property pozwala, aby **atrybut wyglądał jak pole**, ale **zachowywał się jak metoda**.

spełnia protokoły: 
		object descriptor  ( jak tylko get)
		[[data object descriptor]]

`class property(fget=None, fset=None, fdel=None, doc=None)`

- @property → definiuje **getter** (metoda wywoływana przy odczycie atrybutu).
    
- @x.setter → definiuje **setter** (metoda przy zapisie). podpięte przez [[weak reference]]
    
- @x.deleter → definiuje **deleter** (metoda przy del obj.x).

==jeżeli istnieje pole obiektu o tej samej nazwie co pole klasy co jest deskryptorem, to ja wywołamy  to get przypisac set skasowac del -> dokładamy middleware ( interceptor)==


```python
class Employee:  
    def __init__(self, name, age, position, salary):  
        self.name = name  
        self.age = age  
        self.position = position  
        self.salary = salary # jak wykryje przypisanie o takiej samej nazwie jak deskryptor odpali jedną z 3 metod  
  
    def increase_salary(self, percent):  
        self.salary *= (1 + percent / 100)  
  
    def get_salary(self):  
        return self._salary  
  
  
    def set_salary(self, salary):  
        print("Setting salary")  
        if salary < 10000:  
            raise ValueError("Salary must be greater than 10000")  
        self._salary = salary  
  
    def del_salary(self):  
        del self._salary  
  
    salary = property(get_salary, set_salary, del_salary, "Salary property") # deskryptor. Dostaje nowe właściwości przez virtual inheritance  
  
    def __str__(self):  
        return (f"{self.name} is {self.age} years old"                f" and work as {self.position}"  
                f" and salary: {self.salary}")  
  
    def __repr__(self):  
        attrs = ', '.join(f'{k}={v!r}' for k, v in vars(self).items())  
        return f"{type(self).__name__}({attrs})"  
  
  
# przykłady  
e1 = Employee("Mateusz", 30, "software eng", 100000)  # OK  
print(e1)  
  
try:  
    e2 = Employee("Marta", 36, "software eng", 150)  # ValueError  
except ValueError as e:  
    print("Błąd:", e)
```
  

Interpreter zamiast bezpośrednio sięgać do __dict__, wykonuje ukrytą metodę.

```python

class Example:

    def __init__(self, p):
        self.p = p   # setter zostanie wywołany → zapisze do self._p

    @property
    def p(self): # getter jest dekorowany przez property i automatycznie twory nowy obiekt property object
        return self._p

    @p.setter
    def p(self, value):

        self._p = value

```

dekorator@property zwraca instancję klasy property, która przechowuje oryginalną metodę jako fget 
obiekt property tworzy się raz, podczas gdy interpreter przechodzi przez klasę



![[Pasted image 20251127150417.png]]



poniższy przykład:
	1.	Nie przypisujesz do _folder_path ani _tags bezpośrednio
	2.	Przypisujesz do właściwości (property)
	3.	To powoduje wywołanie:
	•	folder_path.setter
	•	tags.setter

Czyli:
	•	walidacja / normalizacja odbywa się już przy tworzeniu obiektu
	•	obiekt nigdy nie istnieje w stanie „niepoprawnym”
```python
class NotesLoader(NotesLoaderABC):  
    def __init__(self, folder_path: str, tags: Iterable[str]) -> None:  
        self.folder_path = folder_path  # jakby był _ to setter nie odpaliłby się przy tworzeniu obiektu  
        self.tags = tags  
  
    @override  
    @property    def folder_path(self) -> str:  
        return self._folder_path  
  
    @folder_path.setter  
    def folder_path(self, folder_path: str) -> None:  
        self._folder_path = folder_path  
  
    @override  
    @property    def tags(self) -> Iterable[str]:  
        return self._tags  
  
    @tags.setter  
    def tags(self, tags: Iterable[str]) -> None:  
        tags_normalized = set(tags)  
  
        for tag in tags:  
            tag_ = tag.strip().lower()  
            if not tag_.startswith("#"):  
                tag_ = "#" + tag  
            tags_normalized.add(tag_)  
  
        self._tags = tags_normalized
```

