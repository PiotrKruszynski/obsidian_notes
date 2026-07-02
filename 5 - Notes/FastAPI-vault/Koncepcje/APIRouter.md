---
tags: [fastapi, architektura, koncepcja]
powiązane: ["[[Path operation]]", "[[Depends — wstrzykiwanie zależności]]"]
sr_due: 2026-07-14
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# APIRouter

> [!summary] W jednym zdaniu
> APIRouter to "mini-aplikacja" gromadząca trasy jednej domeny (users, items)
> we własnym pliku, którą potem podpinasz do głównej aplikacji jednym
> `include_router` — dzięki czemu projekt rośnie w moduły zamiast w jeden
> tysiąclinijkowy main.py.

Model mentalny: `app` to centrala, routery to oddziały. Każdy oddział prowadzi
własny rejestr tras, a centrala scala je przy starcie, doklejając wspólny
prefiks i tagi.

> [!example] Typowa struktura projektu
> ```
> app/
> ├── main.py          # tworzy app, podpina routery
> ├── routers/
> │   ├── users.py     # router /users
> │   └── items.py     # router /items
> ├── schemas.py       # modele Pydantic
> └── models.py        # modele ORM
> ```
> ```python
> # routers/items.py
> from fastapi import APIRouter
> router = APIRouter(prefix="/items", tags=["items"])
>
> @router.get("/")               # efektywnie: GET /items/
> def list_items(): ...
>
> # main.py
> from app.routers import items, users
> app = FastAPI()
> app.include_router(items.router)
> app.include_router(users.router)
> ```

> [!tip] Wspólne zależności na cały router
> `APIRouter(dependencies=[Depends(verify_token)])` — każda trasa oddziału
> wymaga tokena, bez powtarzania w każdym endpoincie. Tak robi się "strefę
> chronioną" API.

## Połączenia
- [[Path operation]] — router rejestruje te same path operations co app
- [[Depends — wstrzykiwanie zależności]] — zależności na poziomie routera
