---
tags: [fastapi, http, koncepcja]
powiązane: ["[[Skąd FastAPI bierze parametry]]", "[[APIRouter]]"]
---

# Path operation

> [!summary] W jednym zdaniu
> Path operation to para "ścieżka + metoda HTTP" przypięta dekoratorem do
> funkcji — dekorator rejestruje funkcję w routerze aplikacji, więc gdy
> przyjdzie pasujące żądanie, FastAPI wie, którą funkcję wywołać.

Model mentalny: `app` trzyma **tablicę routingu** — spis "kto obsługuje co".
Dekorator `@app.get("/items")` to wpis do tej tablicy: *GET na `/items` →
ta funkcja*. Sama funkcja (handler) to zwykła funkcja Pythona; dekorator
tylko ją rejestruje.

Metody HTTP mają umowne znaczenia (konwencja REST):

| Dekorator | Znaczenie | Przykład |
|---|---|---|
| `@app.get` | odczyt | pobierz listę / szczegóły |
| `@app.post` | utworzenie | dodaj nowy zasób |
| `@app.put` | pełna podmiana | nadpisz cały zasób |
| `@app.patch` | częściowa zmiana | zmień jedno pole |
| `@app.delete` | usunięcie | skasuj zasób |

> [!example] Status code i kolejność tras
> ```python
> @app.post("/items", status_code=201)   # 201 Created — konwencja dla POST
> def create_item(item: Item):
>     return item
>
> # KOLEJNOŚĆ MA ZNACZENIE: trasy sprawdzane od góry
> @app.get("/users/me")        # musi być PRZED /users/{user_id}
> def read_me(): ...
>
> @app.get("/users/{user_id}") # inaczej "me" wpadłoby tu jako user_id="me"
> def read_user(user_id: int): ...
> ```

> [!warning] Trasa stała po trasie dynamicznej
> Jeśli `/users/{user_id}` zadeklarujesz przed `/users/me`, żądanie `GET
> /users/me` trafi do pierwszej trasy, FastAPI spróbuje zrobić `int("me")`
> i zwróci 422. Trasy stałe zawsze deklaruj przed dynamicznymi.

## Połączenia
- [[Skąd FastAPI bierze parametry]] — jak handler dostaje dane z żądania
- [[APIRouter]] — jak nie trzymać wszystkich tras w jednym pliku
- [[HTTPException]] — jak handler sygnalizuje błąd
