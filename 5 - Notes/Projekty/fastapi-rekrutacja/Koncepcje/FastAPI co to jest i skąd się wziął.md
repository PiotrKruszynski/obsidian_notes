---
tags: ["fastapi"]
powiązane: ["[[ASGI vs WSGI]]", "[[Pydantic model — co robi i dlaczego]]", "[[Automatyczna dokumentacja OpenAPI — skąd FastAPI wie co wygenerować]]"]
---

# FastAPI co to jest i skąd się wziął

> [!summary] W jednym zdaniu
> FastAPI to framework webowy dla Pythona zbudowany na ASGI (asynchroniczny), który używa type hints do walidacji danych i automatycznego generowania dokumentacji OpenAPI — dlatego jest szybszy w pisaniu i mniej podatny na błędy niż Flask czy Django REST Framework.

FastAPI = trzy warstwy sklejone razem:
- **Starlette** — obsługa HTTP, routing, middleware (ASGI)
- **Pydantic** — walidacja i parsowanie danych przez type hints
- **Python type hints** — źródło prawdy dla wszystkiego: walidacji, dokumentacji, IDE

Dzięki temu piszesz normalny Python z typami, a FastAPI sam generuje:
- walidację requestu (400 jeśli nie pasuje)
- serializację response
- dokumentację Swagger pod `/docs`
- dokumentację ReDoc pod `/redoc`

> [!example] Minimalna aplikacja
> ```python
> from fastapi import FastAPI
> 
> app = FastAPI()
> 
> @app.get("/users/{user_id}")
> def get_user(user_id: int) -> dict:
>     return {"id": user_id}
> ```
> FastAPI czyta `user_id: int` i automatycznie:
> - wyciąga `user_id` z URL
> - konwertuje na `int` (błąd 422 jeśli nie da się skonwertować)
> - wpisuje do dokumentacji że parametr jest `integer`

> [!tip] Dlaczego FastAPI, nie Flask?
> Flask nie waliduje — sam musisz sprawdzać typy. FastAPI waliduje z type hints. W dużym projekcie to setki linii mniej kodu i mniej bugów.

## Połączenia
- [[ASGI vs WSGI]] — fundament techniczny: dlaczego FastAPI jest async
- [[Pydantic model — co robi i dlaczego]] — serce walidacji w FastAPI
- [[Automatyczna dokumentacja OpenAPI — skąd FastAPI wie co wygenerować]] — jak type hints stają się Swaggerem
