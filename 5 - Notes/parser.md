analizowanie i rozbijanie danych na użyteczną strukture ( np. dict)

prosty przykład
```python
employee1 = ["Mateusz", 30, "Software Engineer", 10000]
employee2 = ["Martyna", 36, "Senior Python Developer", 12000]

name     = lambda x: x[0]
age      = lambda x: x[1]
position = lambda x: x[2]
salary   = lambda x: x[3]

```

- Twoje listy to **surowe dane** (podobnie jak tekst JSON czy linia CSV).
    
- Funkcje lambda pełnią rolę **parserów pozycyjnych** – wyciągają znaczenie z konkretnej pozycji listy.
    
    - name(employee1) → "Mateusz"
        
    - age(employee2) → 36
        
To jest bardzo prosty przykład **parsowania**: zamieniasz „gołe indeksy w liście” na semantyczne pola (name, age…), które nadają danym strukturę.

### **Lepsze podejścia**

[[namedtuple]]

```python
from collections import namedtuple

Employee = namedtuple("Employee", "name age position salary")
employee1 = Employee("Mateusz", 30, "Software Engineer", 10000)
print(employee1.name)  # "Mateusz"
```

[[dataclass]]
```python

from dataclasses import dataclass

@dataclass
class Employee:
    name: str
    age: int
    position: str
    salary: int

employee2 = Employee("Martyna", 36, "Senior Python Developer", 12000)
print(employee2.position)  # "Senior Python Developer"

```

dict

```python
employee1 = {
    "name": "Mateusz",
    "age": 30,
    "position": "Software Engineer",
    "salary": 10000,
}
print(employee1["salary"])

```