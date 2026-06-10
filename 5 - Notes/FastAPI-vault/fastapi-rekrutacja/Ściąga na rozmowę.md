---
tags: [fastapi, rekrutacja]
powiązane: ["[[00 — MOC FastAPI]]"]
---

# Ściąga na rozmowę

> [!summary] W jednym zdaniu
> Najczęstsze pytania o FastAPI z odpowiedzią w dwóch zdaniach każdą — do
> powtórki na godzinę przed rozmową; po szczegóły linki do notatek.

**Czym jest FastAPI i dlaczego "fast"?**
Framework do API oparty o Starlette (async/ASGI) i Pydantic (walidacja).
"Fast" podwójnie: wydajność porównywalna z Node.js dzięki async oraz szybkość
developmentu — typy dają walidację i dokumentację za darmo.
→ [[FastAPI — framework na Starlette i Pydantic]]

**Różnica ASGI vs WSGI?**
WSGI jest synchroniczne — wątek czeka na I/O. ASGI pozwala jednemu procesowi
obsługiwać wiele żądań współbieżnie, bo podczas czekania na bazę/API procesor
obsługuje kolejne żądania. → [[ASGI vs WSGI]]

**Kiedy `async def`, kiedy `def`?**
`async def` gdy używam bibliotek asynchronicznych (httpx, asyncpg); zwykłe
`def` FastAPI odpala w threadpoolu, więc jest bezpieczne dla kodu blokującego.
Pułapka: blokujące wywołanie w `async def` zatrzymuje całą pętlę zdarzeń.
→ [[async def vs def w FastAPI]]

**Jak FastAPI waliduje dane?**
Pydantic: deklaruję model z typami, FastAPI parsuje JSON, konwertuje i waliduje
przed wywołaniem funkcji. Złe dane → automatyczne 422 ze wskazaniem pola.
→ [[Model Pydantic]]

**Skąd FastAPI wie, czy parametr to path, query czy body?**
Z sygnatury: nazwa w ścieżce → path, typ prosty poza ścieżką → query, model
Pydantic → body. → [[Skąd FastAPI bierze parametry]]

**Po co `response_model`?**
Filtruje odpowiedź do zadeklarowanych pól (np. wycina hasło), gwarantuje
kontrakt API i zasila dokumentację. → [[response_model]]

**Co robi `Depends`?**
Wstrzykiwanie zależności: wspólna logika (sesja DB, auth) jako funkcja, którą
FastAPI wywołuje i wynik podaje do endpointu. Wariant z `yield` sprząta po
odpowiedzi; w testach podmienialne przez `dependency_overrides`.
→ [[Depends — wstrzykiwanie zależności]]

**Jak obsłużyć błąd 404?**
`raise HTTPException(404, detail=...)` — wyjątek, nie return, więc działa
z dowolnej głębokości, także z zależności. → [[HTTPException]]

**Czym jest Uvicorn?**
Serwer ASGI: nasłuchuje na porcie, parsuje HTTP, przekazuje żądania aplikacji.
Produkcyjnie z `--workers N` dla wielu rdzeni. → [[Uvicorn]]

**Skąd bierze się /docs?**
FastAPI generuje schemat OpenAPI z adnotacji typów; Swagger UI to interaktywny
widok tego schematu. Dokumentacja nie może się zdezaktualizować, bo pochodzi
z kodu. → [[Automatyczna dokumentacja OpenAPI]]

**FastAPI vs Flask/Django?**
FastAPI do API (async, walidacja, docs); Django gdy potrzebny ORM, migracje,
admin "z pudełka"; Flask do małych rzeczy z pełną kontrolą. Uczciwie wymienić
koszt FastAPI: stack DB składasz sam. → [[FastAPI na tle Flask i Django]]

**Jak testujesz FastAPI?**
TestClient wywołuje aplikację w pamięci bez serwera; bazę podmieniam przez
`dependency_overrides`. Testuję też ścieżki błędów (422, 404). → [[TestClient]]

> [!tip] Twoja przewaga
> Masz Shifts MVP (FastAPI, 82 endpointy, 100% coverage jako bramka CI).
> Każdą odpowiedź teoretyczną kotwicz w projekcie: "w moim projekcie
> rozwiązałem to tak...". To bije recytowanie dokumentacji.

## Połączenia
- [[00 — MOC FastAPI]] — pełna mapa nauki
- [[Mini CRUD — kompletny przykład]] — kod do przepisania ręcznie
