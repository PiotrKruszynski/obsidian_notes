---
tags: [fastapi, python, koncepcja]
powiązane: ["[[ASGI vs WSGI]]", "[[Model Pydantic]]", "[[Uvicorn]]"]
---

# FastAPI — framework na Starlette i Pydantic

> [!summary] W jednym zdaniu
> FastAPI to cienka warstwa kleju, która łączy Starlette (asynchroniczna obsługa
> HTTP) z Pydantic (walidacja danych przez typy) — dlatego jest szybki jak
> Node.js/Go i jednocześnie sam pilnuje poprawności danych oraz generuje
> dokumentację, bo wszystko wyczytuje z adnotacji typów Pythona.

Model mentalny: FastAPI **prawie nic nie robi sam**. To dyrygent dwóch
wyspecjalizowanych bibliotek:

- **Starlette** — odbiera i wysyła żądania HTTP asynchronicznie (routing,
  middleware, WebSockety). Stąd wydajność.
- **Pydantic** — zamienia surowy JSON na obiekty Pythona i sprawdza typy.
  Stąd walidacja.

Wkład samego FastAPI to genialny pomysł: **adnotacje typów Pythona są jedynym
źródłem prawdy**. Z jednej deklaracji `price: float` FastAPI wyprowadza
naraz: walidację (odrzuci `"abc"`), konwersję (`"3.5"` → `3.5`), dokumentację
OpenAPI i podpowiedzi w edytorze. Nie piszesz tego czterokrotnie — piszesz raz.

> [!example] Minimalna aplikacja
> ```python
> from fastapi import FastAPI
>
> app = FastAPI()          # instancja aplikacji — serce wszystkiego
>
> @app.get("/")            # dekorator: "GET na / obsługuje ta funkcja"
> def root():
>     return {"msg": "Hello"}   # dict → FastAPI sam serializuje do JSON
> ```
> Uruchomienie: `uvicorn main:app --reload` (plik `main.py`, zmienna `app`).
> Pod `/docs` od razu masz interaktywną dokumentację — bez żadnej konfiguracji.

> [!tip] Na rozmowie
> Pytanie "dlaczego FastAPI jest szybki?" ma dwie warstwy odpowiedzi:
> (1) szybkość wykonania — asynchroniczność przez ASGI/Starlette,
> (2) szybkość pisania — typy robią walidację + dokumentację za darmo.
> Wymień obie, to pokazuje zrozumienie.

## Połączenia
- [[ASGI vs WSGI]] — standard, dzięki któremu FastAPI obsługuje async
- [[Model Pydantic]] — skąd bierze się walidacja
- [[Uvicorn]] — serwer, który faktycznie uruchamia aplikację
- [[Automatyczna dokumentacja OpenAPI]] — co FastAPI generuje z typów
- [[FastAPI na tle Flask i Django]] — porównanie, klasyk rekrutacyjny
