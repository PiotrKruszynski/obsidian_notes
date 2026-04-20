- planowanie dyżurów lekarzy na oddziałach
- kontrolę minimalnej obsady na zmianie. W 90% przypadków wystarczy jedna osoba
- - akceptację grafiku przez koordynatora
- - rozliczanie przepracowanych godzin, nadgodzin, świąt, nocy i weekendów
- - pełny audyt: kto zmienił grafik, kiedy i dlaczego

role użytkowników

**Lekarz**
- podgląd własnego grafiku
- zgłaszanie dostępności i niedostępności
- składanie wniosków urlopowych
- zgłaszanie prośby o zamianę dyżuru
- potwierdzanie zamiany
- powiadomienia o zmianach

**Koordynator**
- tworzenie i edycja grafików
- przypisywanie lekarzy do zmian
- definiowanie zasad obsady
- zatwierdzanie urlopów i zamian

**HR** - kadry
- konfiguracja struktury organizacyjnej
- zarządzanie umowami, normami czasu pracy i stawkami
- raporty czasu pracy
- eksport do payroll / ERP / Excel / Płatnik / systemów kadrowych

### **Administrator systemu**
- zarządzanie użytkownikami i uprawnieniami
- konfiguracja słowników i integracji
- audyt i bezpieczeństwo

**encje domenowe**
- **Lekarz**
- **Specjalizacja / kompetencje / uprawnienia**
- **Jednostka organizacyjna** (oddział, poradnia, szpital, lokalizacja)
- **Zmiana / dyżur**
- **Grafik**
- **Dostępność / niedostępność**
- **Nieobecność** (urlop, L4, szkolenie, konferencja)
- **Reguła obsady**
- **Wniosek o zamianę**
- **Akceptacja / workflow**
- **Rozliczenie czasu pracy**
- **Powiadomienie**
- **Historia zmian / audit log**

Wymagania funkcjonalna

### **4.1 Zarządzanie użytkownikami**

- logowanie
    
- role i uprawnienia
    
- przypisanie lekarza do oddziałów / lokalizacji
    
- profil lekarza: specjalizacja, numer PWZ, typ umowy, etat, preferencje, limity
    

  

### **4.2 Definicja grafiku**

- harmonogram miesięczny / tygodniowy / dzienny
    
- różne typy zmian:
    
    - dzienna
        
    - nocna
        
    - 24h
        
    - weekendowa
        
    - świąteczna
        
    - pod telefonem / dyżur pod telefonem
        
    
- możliwość kopiowania grafiku z poprzedniego miesiąca
    
- szablony grafików
    

  

### **4.3 Planowanie obsady**

- przypisywanie lekarzy do zmian ręcznie
    
- półautomatyczne generowanie grafiku
    
- automatyczne wykrywanie konfliktów:
    
    - nakładające się dyżury
        
    - brak wymaganej specjalizacji
        
    - przekroczenie limitu godzin
        
    - brak odpoczynku dobowego / tygodniowego
        
    - dyżur po nocce / zbyt wiele dyżurów z rzędu
        
    
- minimalna i maksymalna liczba lekarzy na zmianie
    
- wymagane role na zmianie, np. anestezjolog, internista, chirurg
    

  

### **4.4 Dostępność i nieobecności**

- lekarz zgłasza:
    
    - dni preferowane
        
    - dni niedostępności
        
    - urlop
        
    - szkolenie
        
    - blokadę terminów
        
    
- system uwzględnia te dane przy planowaniu
    
- statusy wniosków: roboczy / zaakceptowany / odrzucony
    

  

### **4.5 Zamiany dyżurów**

- lekarz inicjuje zamianę
    
- wybiera osobę zastępującą
    
- system waliduje reguły
    
- druga strona akceptuje
    
- koordynator zatwierdza
    
- system zapisuje pełną historię
    

  

### **4.6 Publikacja grafiku**

- wersja robocza i opublikowana
    
- blokada edycji po publikacji albo edycja z rejestracją zmian
    
- powiadomienia po publikacji
    

  

### **4.7 Raporty i rozliczenia**

- liczba dyżurów per lekarz
    
- liczba godzin dziennych / nocnych / świątecznych
    
- nadgodziny
    
- obsada oddziałów
    
- nieobecności
    
- eksport do CSV / Excel / PDF
    
- raport dla kadr i rozliczeń
    

  

### **4.8 Powiadomienia**

- e-mail / push / SMS
    
- przypomnienie o nadchodzącym dyżurze
    
- informacja o zmianie grafiku
    
- prośba o akceptację zamiany
    
- alert o brakach obsady
    

  

## **5. Reguły biznesowe, które muszą być jawne**

  

Tu zwykle wykładają się takie projekty. Reguły nie mogą być zaszyte „gdzieś w kodzie”.

  

Przykłady:

- lekarz nie może mieć dwóch nakładających się dyżurów
    
- po dyżurze 24h musi mieć wymagany odpoczynek
    
- nie można przekroczyć miesięcznego limitu godzin
    
- dyżur w konkretnej jednostce wymaga określonej specjalizacji
    
- dyżur świąteczny powinien być rozkładany możliwie sprawiedliwie
    
- lekarz kontraktowy i etatowy mogą mieć różne zasady rozliczeń
    
- niektórzy lekarze mogą być wykluczeni z nocy / weekendów
    
- część zmian wymaga obsady senior + rezydent
    

  

Najlepsza decyzja architektoniczna: potraktować to jako **silnik reguł / constraint engine**, a nie zwykły CRUD.

  

## **6. Wymagania niefunkcjonalne**

  

### **Bezpieczeństwo**

- dane wrażliwe i dane personelu
    
- RBAC
    
- log audytowy
    
- szyfrowanie danych w spoczynku i w tranzycie
    
- 2FA dla administratorów i koordynatorów
    
- zgodność z RODO
    

  

### **Niezawodność**

- backupy
    
- wersjonowanie zmian grafiku
    
- odporność na równoczesną edycję
    
- mechanizmy optimistic locking / conflict detection
    

  

### **Wydajność**

- szybki widok miesięcznego grafiku dla setek lekarzy
    
- filtrowanie po oddziale, lokalizacji, specjalizacji
    
- szybka walidacja konfliktów
    

  

### **Użyteczność**

- widok kalendarzowy i tabelaryczny
    
- drag & drop do układania zmian
    
- bardzo czytelne oznaczenia konfliktów
    
- mobile-first dla lekarza, desktop-first dla koordynatora
    

  

## **7. Integracje**

  

W produkcji to zwykle robi różnicę:

- Active Directory / SSO / Google / Microsoft
    
- system kadrowo-płacowy
    
- ERP / HR
    
- kalendarze iCal / Google / Outlook
    
- SMS / e-mail
    
- eksport do NFZ / systemów szpitalnych, jeśli wymagane
    
- API do innych systemów szpitalnych
    

  

## **8. MVP — co zrobić najpierw**

  

Na MVP nie budowałbym pełnej automatyzacji AI/solvera.

Najpierw:

- logowanie i role
    
- baza lekarzy i oddziałów
    
- definiowanie zmian
    
- ręczne układanie grafiku
    
- zgłaszanie niedostępności
    
- walidacja podstawowych konfliktów
    
- publikacja grafiku
    
- zamiany dyżurów
    
- podstawowe raporty
    

  

To działa, bo najpierw rozwiązujesz operacyjny ból.

Auto-generator grafiku dopiero później, gdy masz już stabilne reguły domenowe.

  

## **9. Proponowany backlog epików**

1. Użytkownicy i uprawnienia
    
2. Struktura szpitala i słowniki
    
3. Model dyżurów i grafików
    
4. Dostępność i nieobecności
    
5. Walidacja reguł i konfliktów
    
6. Zamiany dyżurów
    
7. Publikacja i powiadomienia
    
8. Raporty i rozliczenia
    
9. Integracje
    
10. Audit, bezpieczeństwo, administracja
    

  

## **10. Dobre pytania analityczne przed startem**

  

Bez tego wymagania będą zbyt ogólne:

- Czy grafik jest tworzony per oddział, czy centralnie?
    
- Czy jeden lekarz może pracować w wielu lokalizacjach?
    
- Jakie są typy umów i czy wpływają na reguły?
    
- Jakie dokładnie ograniczenia prawne i wewnętrzne obowiązują?
    
- Czy ważniejsza jest sprawiedliwość rozkładu dyżurów, czy maksymalne pokrycie?
    
- Czy grafik ma być generowany automatycznie, czy tylko wspierany przez walidację?
    
- Kto zatwierdza finalny grafik?
    
- Jak wygląda proces awaryjny, gdy ktoś wypada z dyżuru w ostatniej chwili?
