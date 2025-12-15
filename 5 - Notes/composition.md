 
- funkcje można komponować ze sobą  , wynika to z [[higher-order functions]]
- elastyczna alternatywa dla dziedziczenia  
- wynik jednej fn staje się argumentem kolejnej  
- w zależności, jaką fn przekaże do fn mam róźne zachowania tej fn (np. map / filter / reduce )  
  
```python  
  
def magic(fn):  
    return fn('ala')  
magic(len) # 3  
magic(print) # None  
  
```  

  
-------------------------------------------------

[[functional programming]]