---
tags: [python, backend, koncepcja]
powiązane: ["[[ASGI vs WSGI]]", "[[FastAPI — framework na Starlette i Pydantic]]"]
sr_due: 2026-07-20
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Uvicorn

> [!summary] W jednym zdaniu
> Uvicorn to serwer ASGI — program, który nasłuchuje na porcie, rozumie surowe
> bajty protokołu HTTP i przekazuje gotowe żądania aplikacji FastAPI; bez niego
> FastAPI to tylko biblioteka, która sama z siebie niczego nie nasłuchuje.

Podział pracy:
- **Uvicorn**: gniazda sieciowe, parsowanie HTTP, pętla zdarzeń, workery.
- **FastAPI**: routing, walidacja, twoja logika.

Analogia: FastAPI to kucharz, Uvicorn to cały lokal z drzwiami i kelnerami.
Kucharz bez lokalu nie przyjmie żadnego gościa.

> [!example] Dev vs produkcja
> ```bash
> uvicorn main:app --reload            # development: auto-restart po zmianie pliku
> uvicorn main:app --workers 4         # produkcja: 4 procesy = 4 rdzenie CPU
> ```
> `main:app` czytaj: "w pliku `main.py` znajdź zmienną `app`".
> `--reload` nigdy na produkcji — kosztuje wydajność i stabilność.

> [!tip] Workery a async — to nie konkurencja
> Async daje współbieżność **w obrębie jednego procesu** (tysiące czekających
> żądań). Workery dają równoległość **między rdzeniami CPU** (Python przez GIL
> używa jednego rdzenia na proces). Produkcyjnie łączysz oba: kilka workerów,
> każdy z pętlą zdarzeń. Często jeszcze przed tym stoi nginx jako reverse proxy.

## Połączenia
- [[ASGI vs WSGI]] — standard, który Uvicorn implementuje
- [[FastAPI — framework na Starlette i Pydantic]] — aplikacja, którą Uvicorn serwuje
