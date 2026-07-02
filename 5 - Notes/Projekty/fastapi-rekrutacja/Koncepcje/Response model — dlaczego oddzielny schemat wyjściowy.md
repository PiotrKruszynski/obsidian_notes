---
tags: ["fastapi", "pydantic", "security"]
powiązane: ["[[Pydantic model — co robi i dlaczego]]", "[[Dekorator @app.get i co się za nim kryje]]"]
sr_due: 2026-07-03
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Response model — dlaczego oddzielny schemat wyjściowy

> [!summary] W jednym zdaniu
> `response_model` w dekoratorze definiuje kształt odpowiedzi i filtruje dane wyjściowe — bez niego FastAPI zwróci wszystko co zwróci funkcja, łącznie z polami których nie chcesz pokazywać (np. `password_hash`).

Schemat wejściowy (`UserCreate`) i wyjściowy (`UserResponse`) powinny być oddzielne. Dlaczego?

```python
class UserCreate(BaseModel):
    name: str
    password: str          # przyjmujesz hasło przy tworzeniu

class UserResponse(BaseModel):
    id: int
    name: str
    # NIE MA password — celowo
```

Bez `response_model`:
```python
@app.post("/users")
def create_user(user: UserCreate):
    db_user = User(name=user.name, password_hash=hash(user.password))
    db.add(db_user)
    return db_user  # zwróci WSZYSTKIE pola obiektu, łącznie z password_hash!
```

Z `response_model`:
```python
@app.post("/users", response_model=UserResponse)
def create_user(user: UserCreate):
    db_user = User(name=user.name, password_hash=hash(user.password))
    db.add(db_user)
    return db_user  # FastAPI przefiltruje — zwróci tylko id i name
```

> [!example] Co response_model robi krok po kroku
> 1. Funkcja zwraca obiekt ORM (lub dict) z wieloma polami
> 2. FastAPI przekazuje go do `UserResponse(**data)`
> 3. Pydantic tworzy instancję — bierze tylko zadeklarowane pola
> 4. Serializuje do JSON — tylko te pola trafiają do klienta
> 5. Swagger UI pokazuje schemat `UserResponse` jako dokumentację response

> [!warning] response_model nie waliduje — filtruje
> `response_model` odrzuca nadmiarowe pola (te których nie ma w modelu). Nie zgłosi błędu jeśli zwrócisz za dużo — po cichu to ukryje. To feature, nie bug — ale ważne żeby rozumieć że walidacja output jest słabsza niż input.

> [!tip] response_model_exclude_unset
> ```python
> @app.patch("/users/{id}", response_model=UserResponse, response_model_exclude_unset=True)
> ```
> Przy PATCH — zwraca tylko pola które faktycznie zostały ustawione, nie wszystkie z modelu. Przydatne do partial update.

## Połączenia
- [[Pydantic model — co robi i dlaczego]] — response_model to też Pydantic model
- [[Dekorator @app.get i co się za nim kryje]] — response_model jest parametrem dekoratora
