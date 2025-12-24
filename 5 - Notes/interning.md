
reużywanie obiektu pod inną zmienną
algorytm optymalizujący 
można stosować bezpiecznie tylko do immutable

logikę możemy napisać w [[__new__]] -> zamist tworzyć nowy, sprawdzamy czy jest, jak jest to po co go pisać


to nie to samo co [[single tone]]

w [[single tone]] jedna klasa tworzy jeden obiekt
w [[interning]] mam wiele obiektów ale każdy może mieć tylko jedną wartość. Nie istnieją dwa obiekty o tym samym typie i tej samej wartości. 