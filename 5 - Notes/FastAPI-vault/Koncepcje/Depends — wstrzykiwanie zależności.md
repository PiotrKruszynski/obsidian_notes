---
tags: [fastapi, koncepcja, architektura]
powiązane: ["[[Path operation]]", "[[TestClient]]"]
sr_due: 2026-07-08
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Depends — wstrzykiwanie zależności

> [!summary] W jednym zdaniu
> `Depends(funkcja)` mówi FastAPI "zanim wywołasz mój endpoint, wywołaj tę
> funkcję i podaj mi jej wynik" — dzięki czemu wspólny kod (sesja bazy,
> autoryzacja, paginacja) piszesz raz, a FastAPI sam go dostarcza tam, gdzie
> zadeklarowano potrzebę.

Model mentalny: endpoint składa **zamówienie na składniki**, a FastAPI jest
magazynierem, który je kompletuje przed startem. Endpoint nie wie *jak*
powstała sesja bazy — deklaruje tylko, że jej *potrzebuje*.

> [!example] Klasyk: sesja bazy danych z yield
> ```python
> def get_db():
>     db = SessionLocal()
>     try:
>         yield db          # tu FastAPI "wstrzymuje" funkcję i oddaje db
>     finally:
>         db.close()        # wykona się PO odpowiedzi — zawsze, nawet po błędzie
>
> @app.get("/items")
> def list_items(db: Session = Depends(get_db)):
>     return db.query(Item).all()
> ```
> `yield` dzieli zależność na "przygotuj" (przed endpointem) i "posprzątaj"
> (po nim). To wzorzec na wszystko, co trzeba zamknąć: sesje, pliki, połączenia.

Zależności można **zagnieżdżać**: `get_current_user` zależy od `get_db` i od
tokena z nagłówka — FastAPI rozwiąże cały łańcuch i scachuje wyniki w obrębie
jednego żądania (ta sama zależność liczy się raz).

> [!tip] Dlaczego to wygrywa na rozmowie
> Dwa słowa-klucze: **DRY** (logika autoryzacji w jednym miejscu zamiast
> kopiowana po endpointach) i **testowalność** — w testach robisz
> `app.dependency_overrides[get_db] = fake_db` i podmieniasz prawdziwą bazę
> na atrapę bez zmiany ani linijki kodu produkcyjnego.

## Połączenia
- [[TestClient]] — dependency_overrides to podstawa testowania
- [[Path operation]] — gdzie deklarujesz zależności
- [[async def vs def w FastAPI]] — zależności też bywają async/sync
