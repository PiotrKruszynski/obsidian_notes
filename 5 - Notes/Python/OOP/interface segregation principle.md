---
title: "interface segregation principle"
type: concept
topic: python
tags: ["python"]
created: 2026-06-09
status: draft
sr_due: 2026-07-01
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

oddzielenie logiki od szczegółu implementacyjnego
wymuszenie implementacji na dziecku

	tworzymy klase (dowolna, abstrakcyjna, interfejs)
	definiuje wszystko co ma byc w tej klasie # tu jest logika
	
	klasy bazowe mają spełnić interfejs
	
powinna wymuszać spełnianie interfejsów
	w moim świecie definiuje, że samochód ma cztery koła i silnik. Teraz jeżeli ktoś chce zbudować samochód musi przestrzegać moich zasad
		To klasa powinna decydować
