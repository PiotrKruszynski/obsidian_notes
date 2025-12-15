- nie modyfikujemy obiektu, tylko tworzymy nowy  
- dane są stałe po utworzeniu — każda “zmiana” to utworzenie nowej wersji z nowym identyfikatorem
- bez side effect
- brak aliasowania czyli wielu referencji do tego samego zmiennego stanu
- funkcje są łatwe do testowania, logowania i [[memoizing]]

Powiązania:
- [[pure functions]]
- [[recursion]] over iterations
- kompatybilne z [[lazy evaluation]]
  
Zastosowanie:  
- wydajność. Taniej jest wziąźć nowy, niż modyfikować stary.  ( w przypadku struktur zagnieżdżonych)
- predyktywność zmian  - eliminacja [[shared state]]
  
Niemodyfikowalny stan aplikacji (biblioteka Redux w JS)  
- można osiągnąć podróż w czasie  
- łatwy debug


Problem: Shared MUTABLE state - niebezpieczne
- Koszyk w sklepie, zmieniam i aktualizuje się 
- Każdy element ma swój shared state 
- Synchronizacja wymusza szereg czynności

Rozwiązanie: IMMUTABLE state 
- Jedna zmienna używana w wielu miejscach 
- Brak synchronizacji 
- Zmiana przez referencję 

Zalety immutable: 
- Łatwiejszy debugging (wiesz kto co zmienił) 
- Payload-driven changes 
- Bezpieczny multiprocesing 
- Każdy musi stworzyć nową instancję


[[functional programming]]