---
tags: [python, backend, koncepcja]
powiązane: ["[[Uvicorn]]", "[[async def vs def w FastAPI]]"]
---

# ASGI vs WSGI

> [!summary] W jednym zdaniu
> WSGI obsługuje jedno żądanie na wątek i blokuje się na czekaniu (np. na bazę
> danych), a ASGI pozwala jednemu procesowi żonglować tysiącami żądań
> jednocześnie, bo gdy jedno czeka na I/O, procesor zajmuje się następnym.

Oba to **standardy interfejsu** między serwerem WWW a aplikacją Pythona —
umowa "jak serwer przekazuje żądanie do twojego kodu".

Model mentalny — restauracja:
- **WSGI** (Flask, Django klasycznie): kelner przyjmuje zamówienie, idzie do
  kuchni i **stoi tam, czekając**, aż danie będzie gotowe. Obsługa kolejnego
  stolika wymaga zatrudnienia kolejnego kelnera (wątku/procesu).
- **ASGI** (FastAPI, Starlette): kelner przyjmuje zamówienie, oddaje do kuchni
  i **od razu idzie do kolejnego stolika**. Jeden kelner obsługuje całą salę,
  bo nigdy nie stoi bezczynnie.

"Czekanie" w backendzie to głównie **I/O**: zapytania do bazy, wywołania innych
API, odczyt plików. Typowy endpoint 95% czasu czeka, 5% liczy. ASGI odzyskuje
te 95%.

> [!warning] ASGI nie przyspiesza obliczeń
> Jeśli endpoint liczy coś ciężkiego na CPU (np. hashuje hasła w pętli),
> async nic nie da — a wręcz zaszkodzi, bo zablokuje pętlę zdarzeń i **wszystkie**
> żądania staną. Async pomaga wyłącznie przy czekaniu na I/O.

> [!tip] Na rozmowie
> Skrót: WSGI = synchroniczny standard (Flask), ASGI = asynchroniczny następca
> (FastAPI). ASGI dodatkowo wspiera WebSockety i HTTP/2, czego WSGI nie umie
> z definicji, bo jego model to "jedno żądanie → jedna odpowiedź → koniec".

## Połączenia
- [[Uvicorn]] — implementacja serwera ASGI
- [[async def vs def w FastAPI]] — jak z ASGI korzystać w praktyce
- [[FastAPI — framework na Starlette i Pydantic]] — kto stoi na ASGI
