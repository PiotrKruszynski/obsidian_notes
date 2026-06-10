---
tags: [fastapi, koncepcja]
powiązane: ["[[Model Pydantic]]", "[[Path operation]]"]
---

# Skąd FastAPI bierze parametry

> [!summary] W jednym zdaniu
> FastAPI patrzy na sygnaturę funkcji i wnioskuje źródło każdego parametru z
> samej deklaracji: nazwa obecna w ścieżce → parametr ścieżki, typ prosty
> nieobecny w ścieżce → parametr zapytania (?x=1), model Pydantic → ciało
> żądania (JSON).

To jeden mechanizm, trzy źródła. Żadnych ręcznych `request.args.get(...)` jak
we Flasku — deklarujesz, FastAPI dostarcza i **waliduje**.

> [!example] Wszystkie trzy źródła w jednej funkcji
> ```python
> from pydantic import BaseModel
>
> class Item(BaseModel):
>     name: str
>     price: float
>
> @app.put("/items/{item_id}")          # {item_id} → ścieżka
> def update_item(
>     item_id: int,        # jest w ścieżce        → PATH:  /items/5
>     item: Item,          # model Pydantic        → BODY:  JSON w żądaniu
>     notify: bool = False # prosty typ, nie w ścieżce → QUERY: ?notify=true
> ):
>     return {"item_id": item_id, "item": item, "notify": notify}
> ```
> Żądanie `PUT /items/5?notify=true` z JSON-em `{"name":"czujnik","price":99.5}`
> wypełni wszystkie trzy. FastAPI sam skonwertuje `"5"` → `5` i `"true"` → `True`.

Co jeśli dane są złe? `PUT /items/abc` → FastAPI **nie wywoła twojej funkcji**,
tylko od razu zwróci `422 Unprocessable Entity` z opisem: pole `item_id`,
oczekiwano int. Walidacja dzieje się **przed** twoim kodem.

> [!tip] Parametr opcjonalny vs wymagany
> Wartość domyślna = opcjonalny (`notify: bool = False`). Brak domyślnej =
> wymagany (`item_id: int`). Do dodatkowych ograniczeń służą `Query`, `Path`,
> `Body`: `q: str = Query(min_length=3)` — odrzuci za krótkie.

## Połączenia
- [[Model Pydantic]] — co się dzieje z ciałem żądania
- [[Path operation]] — gdzie te parametry deklarujesz
- [[Automatyczna dokumentacja OpenAPI]] — parametry lądują w /docs automatycznie
