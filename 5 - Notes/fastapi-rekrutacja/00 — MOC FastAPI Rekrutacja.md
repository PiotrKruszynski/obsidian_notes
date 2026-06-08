# MOC — FastAPI Rekrutacja

Punkt wejścia do vaultu. Czytaj nie liniowo — wchodź przez pytanie, które cię blokuje.

## Jak używać
Każda notatka = jedna koncepcja. Jeśli nie rozumiesz terminu w notatce — kliknij wikilinka do pojęcia nadrzędnego.

---

## Fundament — zanim powiesz cokolwiek o FastAPI

- [[FastAPI co to jest i skąd się wziął]]
- [[ASGI vs WSGI]]
- [[Pydantic model — co robi i dlaczego]]

## Routing i endpointy

- [[Dekorator @app.get i co się za nim kryje]]
- [[Path parameters vs Query parameters]]
- [[Request body — jak FastAPI parsuje JSON]]
- [[Status codes w FastAPI]]

## Dependency Injection

- [[Depends — jak działa DI w FastAPI]]
- [[Zależności jako bramki — auth, DB session, config]]

## Walidacja i schematy

- [[Pydantic model — co robi i dlaczego]]
- [[Response model — dlaczego oddzielny schemat wyjściowy]]
- [[Walidacja danych wejściowych — co się dzieje przed wywołaniem funkcji]]

## Async

- [[async def vs def w FastAPI — kiedy co]]
- [[Await i event loop — model mentalny]]

## Testowanie

- [[TestClient — jak testować FastAPI bez serwera]]
- [[pytest-asyncio — testy async endpointów]]

## OpenAPI i dokumentacja

- [[Automatyczna dokumentacja OpenAPI — skąd FastAPI wie co wygenerować]]

---

## Pytania kontrolne (sprawdź się przed rozmową)

1. Co się dzieje gdy wpisujesz `@app.get("/users/{id}")` — krok po kroku?  → [[Dekorator @app.get i co się za nim kryje]]
2. Czym różni się `Path parameter` od `Query parameter`? → [[Path parameters vs Query parameters]]
3. Jak FastAPI wie jakiego typu jest parametr? → [[Pydantic model — co robi i dlaczego]]
4. Po co `Depends()`? Kiedy go używasz? → [[Depends — jak działa DI w FastAPI]]
5. Kiedy piszesz `async def`, a kiedy zwykłe `def`? → [[async def vs def w FastAPI — kiedy co]]
6. Jak testujesz endpoint bez uruchamiania serwera? → [[TestClient — jak testować FastAPI bez serwera]]
7. Czym jest `response_model`? → [[Response model — dlaczego oddzielny schemat wyjściowy]]
8. Skąd pochodzi dokumentacja Swagger w FastAPI? → [[Automatyczna dokumentacja OpenAPI — skąd FastAPI wie co wygenerować]]
