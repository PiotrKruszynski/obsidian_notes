---
tags: ["fastapi", "pydantic", "validation"]
powiązane: ["[[FastAPI co to jest i skąd się wziął]]", "[[Response model — dlaczego oddzielny schemat wyjściowy]]", "[[Model Pydantic|Walidacja danych wejściowych — co się dzieje przed wywołaniem funkcji]]"]
sr_due: 2026-07-17
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Pydantic model — co robi i dlaczego

> [!summary] W jednym zdaniu
> Pydantic model to klasa Pythona dziedzicząca z `BaseModel`, która przy tworzeniu instancji automatycznie waliduje i konwertuje dane wejściowe zgodnie z type hints — FastAPI używa go jako kontraktu między JSON a Pythonem.

Pydantic to "bramka celna" dla danych. Zanim dane dotrą do twojej funkcji, Pydantic sprawdza czy mają właściwy kształt i typ. Jeśli nie — zwraca czytelny błąd 422, nie `KeyError` w środku kodu.

```python
from pydantic import BaseModel

class UserCreate(BaseModel):
    name: str
    age: int
    email: str
```

Gdy FastAPI dostaje JSON `{"name": "Jan", "age": "25", "email": "jan@x.pl"}`:
1. Pydantic widzi `age: int` i `"25"` jako string
2. Próbuje skonwertować → `int("25")` = `25` ✓
3. Twoja funkcja dostaje już `user.age` jako prawdziwy `int`

> [!example] Walidacja w akcji
> ```python
> @app.post("/users")
> def create_user(user: UserCreate):
>     # tutaj user.age to już int, user.name to str
>     # FastAPI obsłużył błąd zanim tu dotarłeś
>     return {"created": user.name}
> ```
> Request `{"name": "Jan", "age": "nie-liczba"}` → automatyczny błąd 422:
> ```json
> {"detail": [{"loc": ["body", "age"], "msg": "value is not a valid integer"}]}
> ```
> Twoja funkcja **nigdy się nie uruchomi** jeśli dane nie pasują.

> [!warning] Pydantic v1 vs v2 — breaking changes
> FastAPI od wersji 0.100+ używa Pydantic v2. Składnia walidatorów się zmieniła: `@validator` → `@field_validator`. Jeśli widzisz stary kod z `@validator`, to Pydantic v1. Na rozmowie warto wspomnieć że znasz różnicę.

> [!tip] Model = dokumentacja
> Każde pole Pydantic modelu automatycznie pojawia się w Swagger UI z typem i przykładem. Jeden model = kontrakt + walidacja + dokumentacja. To jest właśnie DRY w FastAPI.

## Połączenia
- [[FastAPI co to jest i skąd się wziął]] — Pydantic to jeden z filarów FastAPI
- [[Response model — dlaczego oddzielny schemat wyjściowy]] — osobny model dla output
- [[Model Pydantic|Walidacja danych wejściowych — co się dzieje przed wywołaniem funkcji]] — co Pydantic robi przed wywołaniem twojej funkcji
- [[Automatyczna dokumentacja OpenAPI — skąd FastAPI wie co wygenerować]] — model → Swagger
