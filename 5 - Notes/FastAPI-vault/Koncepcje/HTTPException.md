---
tags: [fastapi, http, koncepcja]
powiązane: ["[[Path operation]]", "[[Skąd FastAPI bierze parametry]]"]
sr_due: 2026-07-17
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# HTTPException

> [!summary] W jednym zdaniu
> `raise HTTPException(status_code=404, detail="...")` to sposób, by z dowolnej
> głębokości kodu przerwać obsługę żądania i zwrócić klientowi kontrolowany
> błąd HTTP z JSON-em — `raise` zamiast `return`, bo wyjątek przebija się przez
> wszystkie warstwy wywołań.

Dlaczego **raise**, a nie return? Bo błąd często wykrywasz trzy funkcje w głąb
(np. w zależności sprawdzającej uprawnienia). Wyjątek wyskakuje stamtąd od
razu do FastAPI, który zamienia go na odpowiedź HTTP. Z `return` musiałbyś
przekazywać błąd ręcznie przez każdą warstwę.

> [!example] Klasyczne 404
> ```python
> from fastapi import HTTPException
>
> @app.get("/items/{item_id}")
> def read_item(item_id: int):
>     item = db.get(item_id)
>     if item is None:
>         raise HTTPException(status_code=404, detail="Item not found")
>     return item
> ```
> Klient dostanie status 404 i ciało `{"detail": "Item not found"}`.

Kody, które musisz znać na rozmowie:

| Kod | Znaczenie | Kiedy |
|---|---|---|
| 200 | OK | udany GET/PUT |
| 201 | Created | udany POST |
| 204 | No Content | udany DELETE bez ciała |
| 400 | Bad Request | logicznie złe żądanie |
| 401 | Unauthorized | brak/zły token (kim jesteś?) |
| 403 | Forbidden | znam cię, ale nie wolno ci |
| 404 | Not Found | zasób nie istnieje |
| 422 | Unprocessable Entity | walidacja Pydantic odrzuciła dane |
| 500 | Internal Server Error | nieobsłużony wyjątek w twoim kodzie |

> [!warning] 422 vs 400
> FastAPI sam zwraca **422** (nie 400) przy błędzie walidacji typów — to częste
> pytanie podchwytliwe. 400 zostaje dla błędów logiki biznesowej, które
> sygnalizujesz sam przez HTTPException.

## Połączenia
- [[Skąd FastAPI bierze parametry]] — skąd bierze się automatyczne 422
- [[Depends — wstrzykiwanie zależności]] — autoryzacja rzuca 401/403 z zależności
