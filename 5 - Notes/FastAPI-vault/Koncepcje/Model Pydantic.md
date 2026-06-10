---
tags: [fastapi, pydantic, koncepcja]
powiązane: ["[[response_model]]", "[[Skąd FastAPI bierze parametry]]"]
---

# Model Pydantic

> [!summary] W jednym zdaniu
> Model Pydantic to klasa z adnotacjami typów, która na granicy systemu zamienia
> niezaufany JSON w zwalidowany obiekt Pythona — odrzucając złe dane z czytelnym
> błędem, zanim dotkną twojej logiki.

Model mentalny: **bramkarz na wejściu do klubu**. Świat zewnętrzny przysyła
cokolwiek (JSON to tylko tekst). Bramkarz sprawdza listę (typy pól) i wpuszcza
tylko to, co się zgadza — a po drodze "przebiera" dane w stroje Pythona
(`"2024-01-15"` → obiekt `date`).

```python
from pydantic import BaseModel, Field

class Item(BaseModel):
    name: str
    price: float = Field(gt=0)        # walidacja: musi być > 0
    tags: list[str] = []              # domyślna wartość = pole opcjonalne
    description: str | None = None    # może być null
```

Pydantic robi **konwersję, nie tylko sprawdzenie**: dostanie `"price": "3.5"`
(string) i zamieni na `3.5` (float). Dostanie `"price": "tanio"` — odrzuci.

> [!example] Złe dane → automatyczna odpowiedź 422
> Żądanie z `{"name": "czujnik", "price": -5}` nigdy nie dotrze do twojej
> funkcji. Klient dostanie:
> ```json
> {"detail": [{"loc": ["body", "price"],
>              "msg": "Input should be greater than 0",
>              "type": "greater_than"}]}
> ```
> Dokładna lokalizacja błędu, bez jednej linijki twojego kodu walidującego.

> [!warning] Model Pydantic ≠ model ORM
> Klasyczna pomyłka na rozmowie. Model Pydantic to **schemat danych na granicy
> API** (JSON ↔ Python). Model ORM (SQLAlchemy/Django) to **mapowanie na tabelę
> w bazie**. W praktyce masz oba i konwertujesz między nimi — stąd w projektach
> FastAPI plik `schemas.py` (Pydantic) obok `models.py` (ORM).

## Połączenia
- [[response_model]] — Pydantic działa też na wyjściu, nie tylko wejściu
- [[Skąd FastAPI bierze parametry]] — model w sygnaturze = ciało żądania
- [[FastAPI — framework na Starlette i Pydantic]] — Pydantic to połowa FastAPI
