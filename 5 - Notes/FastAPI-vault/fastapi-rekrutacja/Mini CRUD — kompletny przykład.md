---
tags: [fastapi, projekt, rekrutacja]
powiązane: ["[[Path operation]]", "[[Model Pydantic]]", "[[HTTPException]]"]
---

# Mini CRUD — kompletny przykład

> [!summary] W jednym zdaniu
> Jeden plik łączący wszystkie koncepcje z vaultu w działające API — przepisz
> go ręcznie (nie kopiuj), uruchom `uvicorn main:app --reload` i przeklikaj w
> `/docs`; to najszybsza droga, żeby na rozmowie mówić z pamięci mięśniowej.

```python
from fastapi import FastAPI, HTTPException, Depends
from pydantic import BaseModel, Field

app = FastAPI(title="Items API")

# --- Schematy (warstwa Pydantic) -------------------------------
class ItemIn(BaseModel):                  # to, co przyjmujemy
    name: str = Field(min_length=1)
    price: float = Field(gt=0)

class ItemOut(ItemIn):                    # to, co zwracamy (+ id)
    id: int

# --- "Baza" w pamięci ------------------------------------------
db: dict[int, ItemOut] = {}
next_id = 1

# --- Zależność współdzielona -----------------------------------
def get_item_or_404(item_id: int) -> ItemOut:
    if item_id not in db:
        raise HTTPException(404, detail="Item not found")
    return db[item_id]

# --- Endpointy --------------------------------------------------
@app.post("/items", response_model=ItemOut, status_code=201)
def create_item(item: ItemIn):
    global next_id
    saved = ItemOut(id=next_id, **item.model_dump())
    db[next_id] = saved
    next_id += 1
    return saved

@app.get("/items", response_model=list[ItemOut])
def list_items(skip: int = 0, limit: int = 10):     # query: ?skip=0&limit=10
    return list(db.values())[skip : skip + limit]

@app.get("/items/{item_id}", response_model=ItemOut)
def read_item(item: ItemOut = Depends(get_item_or_404)):
    return item

@app.put("/items/{item_id}", response_model=ItemOut)
def update_item(new: ItemIn, item: ItemOut = Depends(get_item_or_404)):
    updated = ItemOut(id=item.id, **new.model_dump())
    db[item.id] = updated
    return updated

@app.delete("/items/{item_id}", status_code=204)
def delete_item(item: ItemOut = Depends(get_item_or_404)):
    del db[item.id]
```

Co tu pokazujesz w jednym pliku:
- [[Skąd FastAPI bierze parametry]] — path (`item_id`), query (`skip`, `limit`), body (`ItemIn`)
- [[Model Pydantic]] — walidacja `gt=0`, `min_length=1` (wyślij `price: -5` w /docs i zobacz 422)
- [[response_model]] — wzorzec In/Out
- [[Depends — wstrzykiwanie zależności]] — `get_item_or_404` pisany raz, użyty w 3 trasach
- [[HTTPException]] — 404 rzucany z zależności, przebija się do klienta
- [[Path operation]] — 201 dla POST, 204 dla DELETE

> [!tip] Ćwiczenie sprawdzające (20 min)
> Bez patrzenia w notatkę dopisz `PATCH /items/{item_id}` zmieniający tylko
> cenę. Jeśli zrobisz to płynnie — rozumiesz, nie pamiętasz.

## Połączenia
- [[TestClient]] — naturalny następny krok: napisz 3 testy do tego API
- [[APIRouter]] — jak ten plik podzielić, gdy urośnie
