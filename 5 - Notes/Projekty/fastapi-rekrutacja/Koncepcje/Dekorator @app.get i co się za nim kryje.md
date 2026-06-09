---
tags: [fastapi, koncepcja, routing]
powiązane: ["[[Path parameters vs Query parameters]]", "[[Request body — jak FastAPI parsuje JSON]]", "[[Status codes w FastAPI]]", "[[Automatyczna dokumentacja OpenAPI — skąd FastAPI wie co wygenerować]]"]
---

# Dekorator @app.get i co się za nim kryje

> [!summary] W jednym zdaniu
> `@app.get("/path")` rejestruje funkcję jako handler HTTP GET dla danej ścieżki i jednocześnie analizuje jej sygnaturę — type hints parametrów decydują czy FastAPI szuka ich w URL, query string czy body.

Dekorator to nie magia. Robi dwie rzeczy:
1. Rejestruje route w wewnętrznym routerze Starlette
2. Analizuje sygnaturę funkcji przez introspection → buduje "instrukcję obsługi" requestu

```python
@app.get("/users/{user_id}")
def get_user(user_id: int, include_posts: bool = False):
    ...
```

FastAPI patrzy na parametry i decyduje:
- `user_id: int` — jest w ścieżce `{user_id}` → **path parameter**
- `include_posts: bool = False` — nie ma w ścieżce → **query parameter** (`?include_posts=true`)

> [!example] Skąd FastAPI wie co jest gdzie — reguła
> ```
> Parametr funkcji:
> ├── Nazwa pasuje do {placeholder} w ścieżce → Path parameter
> ├── Typ to Pydantic BaseModel → Request body (JSON)
> ├── Typ to prymityw (int, str, bool) i nie ma w ścieżce → Query parameter
> └── Typ to Body(), Query(), Path() explicite → jak zadeklarujesz
> ```
>
> ```python
> @app.get("/items/{item_id}")
> def read_item(
>     item_id: int,           # path — jest w {item_id}
>     q: str | None = None,   # query — nie ma w ścieżce
> ):
>     ...
> ```

> [!warning] Kolejność routów ma znaczenie
> ```python
> @app.get("/users/me")    # musi być PRZED
> def get_me(): ...
>
> @app.get("/users/{user_id}")  # bo inaczej "me" zostanie dopasowane jako user_id
> def get_user(user_id: str): ...
> ```
> FastAPI sprawdza routy w kolejności rejestracji. `"/users/me"` zarejestrowane po `"/users/{user_id}"` nigdy nie będzie osiągalne — każdy request dopasuje się do ogólniejszego wzorca.

> [!tip] Inne metody HTTP
> `@app.post()`, `@app.put()`, `@app.patch()`, `@app.delete()` — działają identycznie, tylko metoda HTTP się zmienia. `@app.api_route("/path", methods=["GET", "POST"])` jeśli chcesz kilka metod na jednej ścieżce.

## Połączenia
- [[Path parameters vs Query parameters]] — szczegóły skąd FastAPI bierze wartości
- [[Request body — jak FastAPI parsuje JSON]] — jak działa parsowanie ciała requestu
- [[Status codes w FastAPI]] — jak ustawiać kody odpowiedzi
- [[Automatyczna dokumentacja OpenAPI — skąd FastAPI wie co wygenerować]] — dekorator = źródło dokumentacji
