==oddzielenie state od funkcji==

**„state” to dane**, ale **konkretnie: dane, które mogą się zmieniać w czasie** i reprezentują _aktualny stan systemu lub obiektu_.

dane to zmienne opisujące aktualny state obiektu. Każdy state to dane, ale nie każde dane to state. 

1. każdy iterator ma internal state (śledzi, który element jest następny aby zwrócić) i to dlatego mamy przewagę recurtion (bez state) over iteration
2. fp służył historycznie do rozwiązywania algorytmów i tu rekurencja była łatwiejsza bez komp

- W **OOP** – state żyje _w obiekcie_, zmienia się lokalnie i często bez śledzenia.
- W **FP** – state jest oddzielony od funkcji, a nie ukryty w obiektach.

1. [[pure functions]]  
2. [[first-class functions]]  
3. [[higher-order functions ]] 
4. [[composition]]  
5. [[anonimous (lambda) Functions]]  
6. [[closure]]  
7. [[recursion]]  
8. [[ lazy evaluation]]  
9. [[immutability]]  
10. [[decorators]]  
11. [[generators and Iterators]]  
12. [[currying and partial applications]]  
13. [[referential tansparency]]  
14. [[stream and pipelines ]] 
15. [[monads and functors]]

