---
tags: ["fastapi", "openapi"]
powiązane: ["[[FastAPI co to jest i skąd się wziął]]", "[[Pydantic model — co robi i dlaczego]]", "[[Dekorator @app.get i co się za nim kryje]]"]
sr_due: 2026-07-20
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Automatyczna dokumentacja OpenAPI — skąd FastAPI wie co wygenerować

> [!summary] W jednym zdaniu
> FastAPI generuje specyfikację OpenAPI 3.x w locie — analizuje dekoratory (ścieżka, metoda), type hints parametrów i Pydantic modele, składa z tego JSON Schema i serwuje pod `/openapi.json`; Swagger UI (`/docs`) i ReDoc (`/redoc`) tylko ten JSON wizualizują.

Dokumentacja nie jest pisana ręcznie. Pochodzi z kodu:

```
@app.post("/users", response_model=UserResponse)  ← ścieżka, metoda, response schema
def create_user(user: UserCreate):                 ← request body schema
```

FastAPI zbiera:
- **z dekoratora** → HTTP method, path, status code, tagi, opis
- **z type hints parametrów** → czy to path/query/body i jakiego typu
- **z Pydantic modeli** → JSON Schema każdego pola (typ, required, przykład, opis)
- **z docstringa funkcji** → opis endpointu w Swagger

> [!example] Enriched dokumentacja z docstringiem i przykładami
> ```python
> class UserCreate(BaseModel):
>     name: str = Field(..., example="Jan Kowalski", description="Pełne imię")
>     age: int = Field(..., ge=18, le=120, description="Wiek w latach")
>
> @app.post(
>     "/users",
>     response_model=UserResponse,
>     status_code=201,
>     tags=["users"],
>     summary="Utwórz nowego użytkownika",
> )
> def create_user(user: UserCreate):
>     """
>     Tworzy nowego użytkownika w systemie.
>
>     - **name**: pełne imię i nazwisko
>     - **age**: musi mieć co najmniej 18 lat
>     """
>     ...
> ```
> Wszystko to pojawi się w Swagger UI automatycznie.

> [!tip] Walidacja przez Field
> `Field(ge=18, le=120)` to nie tylko dokumentacja — Pydantic faktycznie waliduje zakres. Jeśli wyślesz `age: 150` → błąd 422 zanim dotrzesz do funkcji. Dokumentacja i walidacja z jednego miejsca.

> [!warning] Wyłącz /docs na produkcji
> ```python
> app = FastAPI(docs_url=None, redoc_url=None)  # produkcja
> ```
> Swagger UI ujawnia pełną strukturę API. Na produkcji wyłącz lub zabezpiecz autoryzacją.

## Połączenia
- [[FastAPI co to jest i skąd się wziął]] — OpenAPI to jeden z głównych powodów istnienia FastAPI
- [[Pydantic model — co robi i dlaczego]] — modele to źródło JSON Schema w dokumentacji
- [[Dekorator @app.get i co się za nim kryje]] — dekorator to źródło metadanych endpointu
