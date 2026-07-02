---
title: "single tone"
type: concept
topic: python
tags: ["python"]
created: 2026-06-09
status: draft
sr_due: 2026-07-09
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

[[design pattern]]

zapewnia klase która wytworzy tylko jeden obiekt

w [[single tone]] jedna klasa tworzy jeden obiekt
w [[interning]] mam wiele obiektów ale każdy może mieć tylko jedną wartość. Nie istnieją dwa obiekty o tym samym typie i tej samej wartości. 

w momencie importu moduły są single tonami




zapewnia, że **klasa ma tylko jedną instancję** w całym programie — i umożliwia globalny dostęp do tej instancji.  
  
To obiekt, który może istnieć tylko w jednej instancji.   

## 🧠 **Po co używać Singletona?**

- Gdy potrzebujesz **jednego wspólnego obiektu**:
    
    - np. konfiguracja aplikacji,
        
    - połączenie z bazą danych,
        
    - logger (system logowania zdarzeń),
        
    - licznik instancji, menedżer zasobów itp.
