---
tags: [fastapi, koncepcja, async]
powiązane: ["[[FastAPI co to jest i skąd się wziął]]", "[[async def vs def w FastAPI — kiedy co]]"]
---

# ASGI vs WSGI

> [!summary] W jednym zdaniu
> WSGI to synchroniczny protokół — jeden request blokuje wątek do końca obsługi; ASGI to asynchroniczny — jeden wątek może obsługiwać tysiące requestów jednocześnie, bo oddaje kontrolę podczas czekania na I/O.

Wyobraź sobie kelnerów w restauracji:
- **WSGI (Django, Flask)** — kelner bierze zamówienie, idzie do kuchni, STOI i czeka aż kucharz skończy, wraca z talerzem. Jeden kelner = jeden request na raz.
- **ASGI (FastAPI, Starlette)** — kelner bierze zamówienie, zanosi do kuchni, wraca na salę i bierze następne zamówienie. Jak kucharz woła "gotowe" — kelner odbiera i donosi. Jeden kelner = setki zamówień jednocześnie.

W praktyce:
- Twoja aplikacja czeka na bazę danych 50ms → WSGI blokuje wątek na 50ms
- ASGI w tym czasie obsługuje dziesiątki innych requestów

> [!example] Gdzie to widać w FastAPI
> ```python
> # ASGI — zwalnia wątek podczas await
> @app.get("/users")
> async def get_users(db: Session = Depends(get_db)):
>     users = await db.execute(select(User))  # wątek wolny podczas czekania
>     return users
> 
> # WSGI-style (też działa w FastAPI ale blokuje)
> @app.get("/users")
> def get_users_sync():
>     users = db.query(User).all()  # blokuje wątek
>     return users
> ```

> [!warning] FastAPI uruchamia sync funkcje w osobnym wątku
> Jeśli piszesz `def` (nie `async def`), FastAPI nie blokuje event loop — uruchamia funkcję w thread pool. Ale jeśli piszesz `async def` i w środku robisz blokującą operację (np. `time.sleep()`), blokujesz CAŁY event loop. To najczęstszy błąd z async w FastAPI.

## Połączenia
- [[FastAPI co to jest i skąd się wziął]] — dlaczego FastAPI wybrał ASGI
- [[async def vs def w FastAPI — kiedy co]] — praktyczna konsekwencja tego wyboru
