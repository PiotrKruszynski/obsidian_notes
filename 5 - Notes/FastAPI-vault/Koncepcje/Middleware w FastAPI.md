---
tags: [fastapi, http, koncepcja]
powiązane: ["[[Path operation]]", "[[Depends — wstrzykiwanie zależności]]"]
---

# Middleware w FastAPI

> [!summary] W jednym zdaniu
> Middleware to funkcja opakowująca **każde** żądanie — widzi je przed routingiem
> i odpowiedź po handlerze — więc to miejsce na sprawy globalne: logowanie,
> CORS, mierzenie czasu, nagłówki bezpieczeństwa.

Model mentalny: **cebula**. Żądanie przechodzi przez warstwy middleware do
środka (endpoint), odpowiedź wraca przez te same warstwy na zewnątrz. Każda
warstwa może coś dopisać, zmierzyć albo zawrócić żądanie.

> [!example] Middleware mierzący czas odpowiedzi
> ```python
> import time
>
> @app.middleware("http")
> async def add_process_time(request, call_next):
>     start = time.perf_counter()
>     response = await call_next(request)   # "wejdź głębiej w cebulę"
>     response.headers["X-Process-Time"] = str(time.perf_counter() - start)
>     return response
> ```
> `call_next` to granica: kod przed nim działa na żądaniu, kod po — na odpowiedzi.

Praktyczny klasyk — **CORS** (przeglądarka frontendu na innej domenie nie
dostanie odpowiedzi bez tych nagłówków):
```python
from fastapi.middleware.cors import CORSMiddleware
app.add_middleware(CORSMiddleware,
    allow_origins=["http://localhost:5173"],
    allow_methods=["*"], allow_headers=["*"])
```

> [!tip] Middleware vs Depends — pytanie rozjemcze
> Middleware = globalnie, każde żądanie, nie zna szczegółów endpointu.
> Depends = wybiórczo, per endpoint/router, wynik trafia do parametru funkcji.
> Logowanie wszystkiego → middleware. Autoryzacja konkretnych tras → Depends.

## Połączenia
- [[Depends — wstrzykiwanie zależności]] — narzędzie do spraw per-endpoint
- [[ASGI vs WSGI]] — middleware w FastAPI to middleware ASGI (ze Starlette)
