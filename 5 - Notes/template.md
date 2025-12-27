[[design pattern]]

szablon postępowania. 
żeby zrobić kupę trzeba ... ... 

**„Jak”** tworzymy stały szkielet, **„co dokładnie”** delegujemy do metod nadpisywanych w podklasach

## **Kluczowe elementy**

- **Template method** – metoda definiująca kolejność kroków (nie powinna być nadpisywana).
- **Hook methods** – opcjonalne punkty rozszerzeń (mogą, ale nie muszą być nadpisane).
- **Primitive operations** – abstrakcyjne lub „puste” metody implementowane w podklasach.



```python
from abc import ABC, abstractmethod

# kolejność kroków jest zamrożona.
class ReportGenerator(ABC):
    def generate(self) -> None:
        self.load_data()
        self.process_data() # to krok zmienny
        self.export()

    def load_data(self) -> None:
        print("Ładowanie danych (domyślne)")

    @abstractmethod
    def process_data(self) -> None:
        pass

    def export(self) -> None:
        print("Eksport do PDF")

# podklasa decyduje co sie zmieni, a nie jak
class SalesReport(ReportGenerator):
    def process_data(self) -> None:
        print("Przetwarzanie danych sprzedażowych")

class TechnicalReport(ReportGenerator):
    def process_data(self) -> None:
        print("Przetwarzanie danych technicznych")
```
