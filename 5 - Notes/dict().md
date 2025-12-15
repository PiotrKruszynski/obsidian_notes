
1. Hashmap
2. kolekcja
3. uporządkowana od cPython 3.6+ ( nie wolno używać tej własności, jeżeli potrzebujesz użyć orderdict)
4. heterogeniczna
5. mutable, można modyfikować
6. składa się z par: klucz wartość, oddzielonych przecinkami

Keys

	1. Unikalne, nie mog się powtarzać
	2. Tylko hasable date types

Values
	 1. Każdy poprawny typ pythona -> jak wyjdziemy z poza świata pythona to istnieje dziesątki innych typów danych które nie pasują


```python
from collections import OrderedDict

y = dict([(1,2), (3,4), (4,4)])

print(y)


x = OrderedDict([(1,2), (3,4), (4,4)])
print(x)

```
  
## **🧠 Metafora**

> defaultdict(funkcja) = „jeśli klucza nie ma, automatycznie dodaj go z wartością funkcja()”

```python
from collections import defaultdict

d = defaultdict(str)
print(d['x'])  # pusty string ''

```

podobny efekt można uzyskać
`y.get("yolo", 42)` # przekazując domyślną wartość ( bo y["yolo"] rzuca KeyError)


przykład warty zapamiętania z ==poprawnymi kluczami==

```python
class Magic:
	pass

def magic_fn():
	...



x = {
	1: 0,
	False: 1,
	True: 2,
	0:3,
	"ala": 4,
	'': 5,
	'': 6,
	(1,): 7,
	(1,2):8,
	None: 9,
	Magic: 10,
	Magic(): 11,
	magic_fn: 12
}

print(x[0.0000000000]) # dowód, że szuka po hash (h0=h0.00=False i to po nim szuka)

```





Różne sposoby tworzenia  
pusty = {}  # Pusty słownik  
pusty2 = dict()  # Też pusty słownik  
slownik = {'a': 1, 'b': 2}  # Z parami klucz-wartość  
z_tupli = dict([('a', 1), ('b', 2)])  # Z listy tupli  
ze_slow = dict(a=1, b=2)  # Z nazwanych argumentów  

podstawowe operacje  
d = {'a': 1, 'b': 2}  
  
Dodawanie/modyfikacja  
d['c'] = 3  # Dodaje nową parę  
d['a'] = 10  # Modyfikuje istniejącą  
  
Dostęp do elementów  
value = d['a']  # Podstawowy dostęp  
value = d.get('x', 0)  # Bezpieczny dostęp z wartością domyślną  
  
Usuwanie  
del d['a']  # Usuwa parę  
d.pop('b')  # Usuwa i zwraca wartość  
d.popitem()  # Usuwa i zwraca ostatnią parę  
d.clear()  # Usuwa wszystkie elementy  

  
 metody słownika  

Metody zwracające widoki  
d.keys()    # Widok kluczy  
d.values()  # Widok wartości  
d.items()   # Widok par klucz-wartość  
  
 Inne metody  
_d.update({'x': 1, 'y': 2})  # Aktualizuje/dodaje wiele par  
d.setdefault('key', 'default')  # Zwraca wartość lub ustawia domyślną_  
  

