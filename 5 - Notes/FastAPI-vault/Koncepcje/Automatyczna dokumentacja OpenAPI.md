---
tags: [fastapi, openapi, koncepcja]
powiązane: ["[[Model Pydantic]]", "[[response_model]]"]
---

# Automatyczna dokumentacja OpenAPI

> [!summary] W jednym zdaniu
> FastAPI z samych adnotacji typów buduje schemat OpenAPI (JSON opisujący każde
> endpointy, parametry i modele), a pod `/docs` serwuje Swagger UI — interaktywną
> dokumentację, w której można klikać i wysyłać prawdziwe żądania bez Postmana.

Mechanizm: dokumentacja **nie jest pisana — jest wyprowadzana**. Każdy
`item_id: int`, każdy model Pydantic, każdy `response_model` i `status_code`
ląduje w schemacie pod `/openapi.json`. Swagger UI (`/docs`) i ReDoc
(`/redoc`) to tylko dwa różne widoki tego samego schematu.

Konsekwencja, którą warto nazwać na rozmowie: dokumentacja **nie może się
zdezaktualizować**, bo jej źródłem jest działający kod. W Flasku dokumentację
piszesz obok kodu i rozjazd to kwestia czasu.

> [!example] Wzbogacanie dokumentacji
> ```python
> @app.post("/items",
>     response_model=Item,
>     status_code=201,
>     summary="Utwórz przedmiot",
>     tags=["items"])                  # grupowanie w UI
> def create_item(item: Item):
>     """Dłuższy opis — trafia do /docs jako opis endpointu."""
>     return item
> ```
> Docstring funkcji = opis w dokumentacji. Zero dodatkowych plików.

> [!tip] OpenAPI to standard, nie wynalazek FastAPI
> Ze schematu `/openapi.json` można wygenerować klienta TypeScript dla
> frontendu albo testy kontraktowe. To argument "dlaczego FastAPI" w pracy
> zespołowej: kontrakt API jest maszynowo czytelny od pierwszego dnia.

## Połączenia
- [[Model Pydantic]] — modele stają się schematami w dokumentacji
- [[response_model]] — kształt odpowiedzi widoczny w /docs
- [[FastAPI — framework na Starlette i Pydantic]] — typy jako jedyne źródło prawdy
