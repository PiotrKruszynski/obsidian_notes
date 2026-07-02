---
tags: ["fastapi", "testing"]
powiązane: ["[[Depends — jak działa DI w FastAPI]]", "[[Pydantic model — co robi i dlaczego]]"]
sr_due: 2026-07-13
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# TestClient — jak testować FastAPI bez serwera

> [!summary] W jednym zdaniu
> `TestClient` to wrapper Starlette'a oparty na `httpx`, który wykonuje requesty HTTP bezpośrednio w procesie Pythona bez uruchamiania prawdziwego serwera — dzięki temu testy są szybkie i można podmieniać zależności przez `dependency_overrides`.

Bez TestClient musiałbyś uruchamiać serwer, czekać na port, robić requesty przez sieć. Z TestClient — wywołujesz funkcję w pamięci.

```python
from fastapi.testclient import TestClient
from myapp.main import app

client = TestClient(app)

def test_get_user():
    response = client.get("/users/1")
    assert response.status_code == 200
    assert response.json()["id"] == 1
```

> [!example] Podmienianie zależności w testach (dependency_overrides)
> To najważniejsza technika testowania FastAPI. Zamiast prawdziwej bazy danych — wstrzykujesz mock.
>
> ```python
> def override_get_db():
>     yield fake_db  # baza w pamięci zamiast PostgreSQL
>
> app.dependency_overrides[get_db] = override_get_db
>
> client = TestClient(app)
>
> def test_create_user():
>     response = client.post("/users", json={"name": "Jan", "age": 25})
>     assert response.status_code == 201
>
> # Po testach — wyczyść overrides
> app.dependency_overrides.clear()
> ```
> Twoja funkcja endpointu dostaje `fake_db` zamiast prawdziwej sesji. Pełny test integracyjny bez bazy danych.

> [!warning] TestClient jest synchroniczny mimo async app
> `TestClient` działa synchronicznie nawet jeśli aplikacja jest `async`. Do testowania prawdziwie asynchronicznego kodu (np. WebSocket, background tasks) używasz `httpx.AsyncClient` z `pytest-asyncio`.
>
> ```python
> import pytest
> import httpx
>
> @pytest.mark.asyncio
> async def test_async_endpoint():
>     async with httpx.AsyncClient(app=app, base_url="http://test") as client:
>         response = await client.get("/async-endpoint")
>     assert response.status_code == 200
> ```

> [!tip] Fixture pytest dla TestClient
> ```python
> import pytest
> from fastapi.testclient import TestClient
>
> @pytest.fixture
> def client():
>     with TestClient(app) as c:
>         yield c
> ```
> Używaj `with TestClient(app)` — obsłuży startup/shutdown events aplikacji.

## Połączenia
- [[Depends — jak działa DI w FastAPI]] — `dependency_overrides` podmienia Depends w testach
- [[Pydantic model — co robi i dlaczego]] — walidacja działa też w testach — możesz testować błędy 422
