

trzy poziomy abstrakcji:
1. Interface (Interfejs)

Najwyższy poziom abstrakcji.
Definiuje co obiekt powinien robić — czysty kontrakt, bez implementacji.

W PYTHONIE NIE MA INTERFACE -> tworzy się je przez klasy abstrakcyjne

Cechy:
	•	tylko metody abstrakcyjne,
	•	0% logiki wewnętrznej,
	•	wymusza implementację na klasach potomnych,
	•	służy do separacji logiki od szczegółów implementacyjnych (DIP).

Przykład:
```python
from abc import ABC, abstractmethod

class VehicleInterface(ABC):
    @abstractmethod
    def drive(self): ...
    
    @abstractmethod
    def stop(self): ...
```

2. Abstract Class (Klasa abstrakcyjna)

Średni poziom abstrakcji.
Łączy metody abstrakcyjne z częściową implementacją.

Cechy:
	•	może zawierać wspólne metody,
	•	może zawierać atrybuty,
	•	zapewnia wspólne zachowanie dla klas potomnych,
	•	nadal wymaga implementacji niektórych metod.

Przykład:
```python
class BaseVehicle(VehicleInterface):
    def __init__(self, max_speed):
        self.max_speed = max_speed

    def stop(self):
        print("Stopping...")

    @abstractmethod
    def drive(self):
        pass

```
3. Concrete Class (Klasa konkretna)

Najniższy poziom abstrakcji.
Zawiera pełną implementację — obiekt można tworzyć i używać.

Cechy:
	•	implementuje wszystkie metody interfejsu / klasy abstrakcyjnej,
	•	definiuje konkretne zachowanie,
	•	reprezentuje realny obiekt.

Przykład:
```python
class Car(BaseVehicle):
    def drive(self):
        print(f"Car driving at {self.max_speed} km/h")

```


## **Dlaczego 3-poziomowy podział jest ważny?**

- ułatwia projektowanie dużych systemów,
    
- oddziela logikę biznesową od szczegółów technicznych,
    
- umożliwia wprowadzanie zmian bez naruszania istniejącego kodu,
    
- wspiera zasady SOLID (szczególnie: DIP, ISP, LSP),
    
- minimalizuje duplikację kodu,
    
- upraszcza testowanie.

[[oop]]