		paradygmat
		o zgodności typu decyduje zachowanie obiektu, a nie jego dziedziczenie 
		lub deklarowany typ
		
		liczy się **interfejs operacyjny** (metody/atrybuty dostępne na obiekcie)
		
	    nie pytaj „czy jesteś kaczką?”, tylko „czy możesz kwakać?”.
	    “If it walks like a duck and quacks like a duck, it’s a duck.”

1. jest [[protocols]] a nie [[type]].

		nie pytam _czy obiekt dziedziczy po Animal?_ zadaje pytanie _czy ma
		metode run()?_
		
2. Duck typing protocols in Python
		- protokół sekwencji: `__len__, __getitem__
		- protokół iteratora: `__iter__, __next__
		- protokół kontekstowy: `__enter__, __exit__
		- protokół arytmetyczny: `__add__, __mul__, …
		- protokół atrybutów:` __get__, __set__, __delete__`

3. [[descriptor]] = duck typing dla protokołu obsługi atrybutów
	
		Deskryptor to obiekt, który implementuje część protokołu duck 
		typingowego:
			- `__get__
			- `__set__
			- `__delete__
		
		Wystarczy, że obiekt ma te metody to jest deskryptorem
		
3. [[virtual inheritance]] = formalizacja duck typingu przez [[abstract class]] lub [[protocols]]

		duck typing jest dynamiczny! Ale czasem chcemy formalnie opisać kontrakt!
		A. ABC [[abstract class]] -> klasyczne wirtualne dziedziczenie
			deklarujemy metody abstrakcyjne
			klasy muszą je zaimplementować

![[Pasted image 20251206185105.png]]

			
		B. [[protocols]] -> najczystsza forma interfejsów w Python, 
		statycznie typowalna
		zgodność nie zależy od dziedziczenia, tylko czy klasa ma odpowiednie 
		metody
		
		
		```
		from typing import Protocol
		class Vehicle(Protocol):
			def drive(self) -> None: ...
		```
		
		każda klasa która ma `drive()` jest zgodna - bez dziedziczenia!
		
		To nadal duck typing ale:
			- statycznie sprawdzalny (mypy, pyright)
			- bez hierarchii klas

4.  [[metaclass]] to nadal duck typing
			metaklasa nie wymaga dziedziczenia
			tylko sprawdza obecność metody
			zgodność wynika ze struktury klasy
		






