---
tags: ["async", "fastapi"]
powiązane: ["[[ASGI vs WSGI]]", "[[async def vs def w FastAPI|Await i event loop — model mentalny]]"]
sr_due: 2026-07-09
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# async def vs def w FastAPI — kiedy co

> [!summary] W jednym zdaniu
> W FastAPI piszesz `async def` gdy używasz bibliotek które obsługują `await` (async ORM, httpx, aiofiles) — wtedy zwalniasz event loop podczas czekania; piszesz zwykłe `def` gdy biblioteka jest synchroniczna (SQLAlchemy sync, requests) — FastAPI sam przenosi ją do thread pool.

To jedna z najczęstszych pułapek na rozmowach. Zasada:

| Sytuacja | Co pisać |
|---|---|
| Używasz `await` wewnątrz funkcji | `async def` |
| Biblioteka jest sync (requests, SQLAlchemy sync) | `def` |
| Nie wiesz — ostrożny wybór | `def` |

Dlaczego `def` jest "bezpieczniejszy" gdy nie wiesz? Bo FastAPI uruchamia go w thread pool — nie blokuje event loop. `async def` z blokującą operacją w środku blokuje CAŁY serwer.

> [!example] Dobry async vs zły async
> ```python
> import time
> import asyncio
> 
> # ŹLE — async def z blokującą operacją
> @app.get("/bad")
> async def bad_endpoint():
>     time.sleep(5)     # blokuje event loop — CAŁY serwer stoi przez 5 sekund
>     return {"ok": True}
> 
> # DOBRZE — async def z prawdziwym await
> @app.get("/good")
> async def good_endpoint():
>     await asyncio.sleep(5)  # zwalnia event loop — inne requesty działają
>     return {"ok": True}
> 
> # DOBRZE — sync def z blokującą operacją
> @app.get("/also-good")
> def also_good():
>     time.sleep(5)     # FastAPI przenosi do thread pool — event loop wolny
>     return {"ok": True}
> ```

> [!warning] Najczęstszy błąd
> `async def endpoint()` + wewnątrz `requests.get(url)` (biblioteka synchroniczna).
> `requests` blokuje wątek. W `async def` ten wątek to event loop.
> Efekt: serwer obsługuje jeden request na raz mimo że piszesz "async".
> Zamiast `requests` → użyj `httpx` z `await client.get(url)`.

> [!tip] Reguła kciuka
> Masz `await` w ciele funkcji → `async def`.
> Nie masz `await` → `def`.
> Prosto.

## Połączenia
- [[ASGI vs WSGI]] — dlaczego w ogóle istnieje ten wybór
- [[async def vs def w FastAPI|Await i event loop — model mentalny]] — co się dzieje "pod spodem" podczas await
