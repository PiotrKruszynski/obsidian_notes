class
[[single tone]] 

```python
# teraz rozmawiamy o metodach specjalnych i próbujemy dodać wiek team = e1 + e2 dodajac __add  
class Employee:  
    def __init__(self, name, age, position, salary):  
        self.name = name  
        self.age = age  
        self.position = position  
        self.salary = salary  
  
    def increase_salary(self, percent):  
        self.salary *= (percent / 100 + 1)  
  
    def __str__(self):  
        return (f"{self.name} is {self.age} years old"                f" and work as {self.position}"  
                f" and salary: {self.salary}")  
    def __repr__(self):  
        return f"{type(self).__name__}({  
            ', '.join(f'{key}={val!r}' # Employee juz mam teraz robie gen expression na vars(self).items()  
            for key, val in vars(self).items()  
        )})"  
  
    def __add__(self, other): # jest też rhs , który jest lepszy  
        # return 42 - przu e1 + e2 wynik będzie 42        
        
        if isinstance(other, type(self)):  
            return NotImplemented # to spowoduje wydelegowanie operacji do drugiego obiektu, czyli jak e2 będzie intem to zwróci NotImpl.. czyli __add__ drugiego obiektu
  
e1 = Employee("Mateusz", 30, "software eng", 100)  
e2 = Employee("Marta", 36, "software eng", 150)

team = e1 + e2
print(team)
```


jest jeszcze NotImplementedError


## **🚫 Czego nie robić**

- Nie mylić NotImplemented z NotImplementedError.
    
    - NotImplementedError → wyjątek, mówisz: _„ta metoda nie jest zaimplementowana, ale kiedyś powinna być”_.
        
    - NotImplemented → stała, mówisz: _„ja nie wiem, spróbuj drugiej strony albo podnieś błąd”_.
        
    

---

zwracają metody operatorów (__eq__, __lt__, __add__, …), gdy **nie wiedzą jak obsłużyć dane porównanie / operację**.

To **nie wyjątek**, tylko **sygnał dla Pythona**, żeby spróbował inaczej.

---

## **⚙️ Mechanizm**

  
Przykład z operatorem ==:

1. Wywoływane jest a.__eq__(b).
    
2. Jeśli metoda zwróci NotImplemented:
    
    - Python próbuje b.__eq__(a) (operacja odwrotna).
        
    
3. Jeśli obie strony zwrócą NotImplemented, Python zwraca False (dla ==) albo podnosi TypeError (dla np. +).




📌 **Reguła praktyczna**:

- Zwracaj NotImplemented w operatorach, jeśli nie wiesz jak obsłużyć typ.
    
- Dzięki temu Python może spróbować „odwrotnej” operacji albo zgłosić błąd.