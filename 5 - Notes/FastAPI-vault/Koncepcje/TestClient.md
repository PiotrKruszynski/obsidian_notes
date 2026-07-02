---
tags: [fastapi, testy, koncepcja]
powiązane: ["[[Depends — wstrzykiwanie zależności]]", "[[HTTPException]]"]
sr_due: 2026-07-19
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# TestClient

> [!summary] W jednym zdaniu
> TestClient wywołuje aplikację FastAPI w pamięci, bez uruchamiania serwera i
> bez sieci — test wygląda jak prawdziwe żądanie HTTP, a działa jak zwykłe
> wywołanie funkcji, więc jest szybki i deterministyczny.

Model mentalny: TestClient "udaje przeglądarkę", ale zamiast wysyłać bajty
przez gniazdo, wkłada żądanie prosto w aplikację ASGI. Testujesz pełną ścieżkę
(routing → walidacja → handler → serializacja), tylko bez warstwy sieci.

> [!example] Test endpointu z pytest
> ```python
> from fastapi.testclient import TestClient
> from main import app
>
> client = TestClient(app)
>
> def test_create_item():
>     r = client.post("/items", json={"name": "czujnik", "price": 99.5})
>     assert r.status_code == 201
>     assert r.json()["name"] == "czujnik"
>
> def test_validation():
>     r = client.post("/items", json={"name": "x", "price": -1})
>     assert r.status_code == 422        # Pydantic odrzucił, testujemy kontrakt
> ```

> [!tip] Podmiana bazy w testach
> ```python
> app.dependency_overrides[get_db] = get_test_db
> ```
> Testy chodzą na SQLite w pamięci, produkcja na PostgreSQL — kod endpointów
> identyczny. To bezpośrednia wypłata z inwestycji w [[Depends — wstrzykiwanie zależności]].

## Połączenia
- [[Depends — wstrzykiwanie zależności]] — dependency_overrides to klucz do izolacji testów
- [[HTTPException]] — testujesz też ścieżki błędów (404, 401), nie tylko sukcesy
