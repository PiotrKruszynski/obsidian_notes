- Instancja klasy types.ModuleType.
    
- Obiekt, którego atrybuty to zmienne, funkcje, klasy i inne symbole zdefiniowane w pliku .py albo wbudowane w interpreterze.

1.  jeżeli importujemy cokolwiek z modułu to jest on w całości wykonywany!

2. jeżeli w module istnieją wywołania to one się wywołają przy imporcie
3.  Przy imporcie wykona się cały moduł + `__init__`  z `package`

module to [[single tone]] w ramach jednego procesu

to globalne repozytoria stanu

istnieje pojedyncza instancja modułu w trakcie działania programu

1. **Pierwszy import**
    
    - Kiedy interpreter pierwszy raz widzi import mymodule:
        
        - znajduje plik mymodule.py,
            
        - wykonuje w całości go od góry do dołu,
            
        - tworzy obiekt typu module (instancję klasy types.ModuleType),
            
        - zapisuje go do słownika sys.modules pod kluczem "mymodule".