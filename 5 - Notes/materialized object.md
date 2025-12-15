fizyczna lista / tupla / kolekcja wyliczona 

do momentu w którym generator nie jest wyliczony , to nie jest zmaterializowany i każdy jego element trzeba będzie liczyć


Mamy dwa podejścia:

lazy - wtedy kiedy są potrzebne 
eager - wykonuje operacje natychmiastowo. Pozwalają na to generatory

> 	 video_ds_ : project_fn_v4 do 26:00 

```python

x = [i * 2 for i in range(10)]
y = (i * 2 for i in range(10))

print(len(x))
print(len(list(y)))

# to to samo, ale podobno x jest minimalnie szybszy

```

Kiedy materializować [[lazy evaluation]] ?

jak potrzebujemy len -> trzeba będzie zmaterializować generator, czyli potrzebujemy wszystkie elementy

jak potrzebujemy elementy więcej niż jeden raz -> trzeba go będzie zmaterializować, bo nie da się wykonać 2x  generatora bo się zużywa,

jak nie potrzebujemy wszystkich elementów, to lepiej jest użyć lazy evaluation / generator function

Kolejny przykład

```python

z = "ala"[::-1]
z1 = reversed("ala")

```

slicing mniej wydajny bo musi zrobić pośredni materialized object do odwrócenia.
reversed nie musi, więc jak pracujemy na lazy to lepiej.

[[functional programming]]
