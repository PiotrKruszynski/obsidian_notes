main [[paradigms]] in python

chodzi o to aby połączyć state z funkcjonalnościami .
dane to zmienne opisujące aktualny state obiektu. Każdy state to dane, ale nie każde dane to state. 

[[object]] = funkcjonalności i właściwości

 w oop chodzi o to aby połączyć state z funkcjalnościami
1. [[abstraction]]
2. [[inheritence]]
3. [[polymorphism]]
4. [[encapsulation]]

class - [[namespace]], (schema)


pliki -> moduły

foldery -> package (wyspecjalizowane moduły) v namespace

metody klasowe


```python
  
class Employee:  
    def __init__(self):  
        self.__dict__["name"] = "Mateusz" # to jest to samo co self.name  
        self.__dict__["age"] = 30  
        self.__dict__["position"] = "software eng"  
        self.__dict__["salary"] = 100
        
  
class Employee:  
    def __init__(self):  
        self.__dict__["name"] = "Mateusz" # to jest to samo co self.name  
        self.__dict__["age"] = 30  
        self.__dict__["position"] = "software eng"  
        self.__dict__["salary"] = 100  
  
e = Employee()  
e.__dict__["is supervisor"] = True # dodaje nowe pole post factum  
#print(e.__dict__)  
  
# ten sam kod co wyżej  
class Employee:  
    def __init__(self):  
        self.name = "Mateusz"  
        self.age = 30  
        self.position = "software eng"  
        self.salary = 100  
  
# teraz to samo ale jakbysmy chcieli miec innych pracowników niż Mateuszów  
class Employee:  
    def __init__(self, name, age, position, salary):  
        self.name = name 
        self.age = age  
        self.position = position 
        self.salary = salary
  
    def increase_salary(banana, percent):  
        banana.__dict__["salary"] *= (percent / 100 + 1)  
  
e = Employee("Mateusz", 30, "software eng", 100)  
print(e.__dict__) # działa tak samo jak w pierwszych klasach z __dict__  
  
  
#Employee.increase_salary(e, 20)  
e.increase_salary(20)  
print(e.__dict__)
```

````python
employee.increase_salary(e, 20)  
e.increase_salary(20)  
````

te dwie ostatnie linijki działają nieco inaczej ..
pierwszy jest logiczny. bierze `__dict__` z `employee` i robi lookup na `increase_salary`
`increase_salary` jest funkcja, jest callable i go wywołuje
drugi
bierze obiekt `e` robi lookup i szuka w `__dict__` czy istnieje `increase_salary` NIE MA wiec robi lookup do `__dict__` klasy. 

banana referuje do obiektu e, to dowód że Nazwa self to tylko konwencja 

`__dict__` obiektu e poniżej, w nim nie ma `increase_salary`
`{'name': 'Mateusz', 'age': 30, 'position': 'software eng', 'salary': 100}`

powyższy przykład pokazuje, że jest `__dict__` ale normalnie korzysta się z dott_notation

```python
class Employee:  
    def __init__(self, name, age, position, salary):  
        self.name = name 
        self.age = age
        self.position = position
        self.salary = salary
  
    def increase_salary(self, percent):  
       self.salary *= (percent / 100 + 1)  
  
e = Employee("Mateusz", 30, "software eng", 100)  
print(e.__dict__) # działa tak samo jak w pierwszych klasach z __dict__  
  
  
#Employee.increase_salary(e, 20)  
e.increase_salary(20)  
print(e.__dict__)
```
