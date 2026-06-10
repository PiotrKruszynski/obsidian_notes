---
tags: [fastapi, python, async, koncepcja, pułapka]
powiązane: ["[[ASGI vs WSGI]]", "[[Path operation]]"]
---

# async def vs def w FastAPI

> [!summary] W jednym zdaniu
> `async def` mówi FastAPI "ufaj mi, nigdzie się nie zablokuję — puść mnie w
> pętli zdarzeń", a zwykłe `def` mówi "mogę blokować — odpal mnie w osobnym
> wątku z puli"; dlatego blokujący kod w `async def` to katastrofa, a w `def`
> jest bezpieczny.

FastAPI przyjmuje **oba** rodzaje funkcji i traktuje je różnie:

| Deklaracja | Gdzie się wykonuje | Kiedy używać |
|---|---|---|
| `async def` | pętla zdarzeń (event loop) | gdy używasz bibliotek async (`await`): httpx, asyncpg, SQLAlchemy async |
| `def` | pula wątków (threadpool) | gdy używasz bibliotek blokujących: requests, psycopg2, klasyczne ORM |

Model mentalny: pętla zdarzeń to **jeden pas autostrady**, po którym mkną
wszystkie żądania. `await` to zjazd na parking — auto zjeżdża, pas wolny dla
innych. Ale jeśli w `async def` wywołasz funkcję blokującą (bez `await`),
auto **staje na środku pasa** i blokuje cały ruch.

> [!example] Dobrze i źle
> ```python
> import httpx, requests
>
> @app.get("/dobrze-async")
> async def dobrze():
>     async with httpx.AsyncClient() as c:
>         r = await c.get("https://api.example.com")  # await = zjazd z pasa
>     return r.json()
>
> @app.get("/dobrze-sync")
> def tez_dobrze():
>     r = requests.get("https://api.example.com")  # blokuje, ale tylko swój wątek
>     return r.json()
> ```

> [!warning] Najczęstszy błąd w FastAPI
> ```python
> @app.get("/katastrofa")
> async def zle():
>     r = requests.get("https://api.example.com")  # blokujące w async def!
>     return r.json()
> ```
> `requests` nie zna `await`, więc blokuje pętlę zdarzeń. Skutek: przy 100
> równoczesnych żądaniach **wszystkie** czekają w kolejce jedno za drugim,
> serwer "wisi". Reguła: w `async def` tylko biblioteki ze słowem `await`.

> [!tip] Reguła kciuka
> Nie wiesz, czy biblioteka jest async? Użyj zwykłego `def` — FastAPI wrzuci ją
> do threadpoola i nic nie zepsujesz. `async def` to optymalizacja, nie wymóg.

## Połączenia
- [[ASGI vs WSGI]] — skąd w ogóle bierze się pętla zdarzeń
- [[Path operation]] — funkcje, których to dotyczy
- [[Depends — wstrzykiwanie zależności]] — zależności też mogą być async lub sync
