kolekcja, nieuporządkowana, heterogeniczna -> tylko z hashable, mutowalna, unique

sam set jest mutowalny wiec nie jest hashable
  
służy do unique -> gdy wartości mają być unikalne.  
Set używamy w celu posiadania tylko unikalnych wartości  
y = {1,1,1,2,3,4,5,6,6,6}  
y  
{1,2,3,4,5,6}  
ma wszystkie własności zbiorów matematycznych  
  

[[hashable]], tzn że da się wyliczyć hash ( cig znaków, który spelnia 2 warunki)[](http://localhost:8888/lab/workspaces/auto-g/tree/Developer/notebooks/8_data_structures.ipynb#Hashable,-tzn-%C5%BCe-da-si%C4%99-wyliczy%C4%87-hash-\(-cig-znak%C3%B3w,-kt%C3%B3ry-spelnia-2-warunki\))

1. Zawsze taki sam dla tej samej wartości ( np. 'ala')
2. Zawsze różny dla 2 różnych wartości ( np. 'ala', 'ula')

  
gdyby set nie był oparty o [[hash]] byłby niewiarygodnie wolny. sprawdzając czy istnieje element musiałby przeszukiwać po wszystkich elementach (jak w liście), a jest niewiarygodnie szybki.  
  
[[hash]] - ciąg znaków. Hashe tworzą coś w rodzaju indeksu jak w książkach, wszystkie elementy są zindeksowane. jak chcemy sprawdzić czy element jest  to set w najgorszym przypadku musi sprawdzić jeden element  


set jest outlier
==zachowuje się troche jak sequence, a troche jak hashmapa==

klucze w słowniku są reprezentowane set'em  
  
_x = {1,2,3,4,'ala'}  
type(x)  
>> set_  
  
da sie iterować po secie, ale jest autosortowanie  
_x = {5,3,2,10,'10','5'}  
>> {10, '10',2,3,5,'5'}_  
  

  
metody set'a to głównie operacje na zbiorach

  

  

_{1,2,3} | {2,3,4}  ten znak to union  
{1,2,3,4,}_   -> bierze jeden zbiór i drugi i łączy ! | to union, można też zrobić | na słownikach !!!

  

mozna też x={1,2,3}

_x.union({2,3,4})_

_{1,2,3,4}_

_x={1,2,3}_

_x.intersection({2,3,4})_

_{2,3}_

  

dodawanie set'a

  

_x = {1,2,3}_

_x.add(42)_

_x={1,2,3,42}_

  

_x = {1,2,3}_

_x.update(42)_

_>> TypeError: 'int' object is not iterable    -> update przyjmuje coś po czym można iterować i  iteruje po iterable_

  

pusty set  
_d = {1}_

_d.pop()_

_print(type(d), d)_

_>> <class 'set'> set()_