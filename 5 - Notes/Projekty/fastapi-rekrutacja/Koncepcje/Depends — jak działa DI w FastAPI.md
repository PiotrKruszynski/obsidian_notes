---
tags: [fastapi, koncepcja, dependency-injection]
powiązane: ["[[FastAPI co to jest i skąd się wziął]]", "[[Zależności jako bramki — auth, DB session, config]]", "[[TestClient — jak testować FastAPI bez serwera]]"]
---

# Depends — jak działa DI w FastAPI

> [!summary] W jednym zdaniu
> `Depends()` to mechanizm Dependency Injection w FastAPI — zamiast tworzyć zasoby (sesję DB, token auth, konfigurację) wewnątrz każdej funkcji, deklarujesz zależność a FastAPI tworzy ją, wstrzykuje i zarządza jej cyklem życia.

Wyobraź sobie że każdy endpoint potrzebuje połączenia z bazą danych. Bez DI:

```python
# BEZ Depends — powtarzasz się wszędzie
@app.get("/users")
def get_users():
    db = SessionLocal()  # tworzysz ręcznie
    try:
        users = db.query(User).all()
    finally:
        db.close()  # zamykasz ręcznie
    return users
```

Z `Depends`:
```python
# generator — yield oddaje sesję, po yield sprzątanie
def get_db():
    db = SessionLocal()
    try:
        yield db        # FastAPI wstrzykuje to do funkcji
    finally:
        db.close()      # FastAPI wywołuje to po zakończeniu requestu

@app.get("/users")
def get_users(db: Session = Depends(get_db)):
    return db.query(User).all()
    # db.close() wywołane automatycznie przez FastAPI
```

> [!example] Jak FastAPI przetwarza Depends krok po kroku
> 1. Przychodzi request `GET /users`
> 2. FastAPI widzi `db: Session = Depends(get_db)`
> 3. Wywołuje `get_db()` — generator startuje, tworzy sesję, zatrzymuje się na `yield`
> 4. FastAPI przekazuje sesję jako `db` do `get_users()`
> 5. `get_users()` kończy działanie
> 6. FastAPI wraca do `get_db()` po `yield` — wywołuje `finally`, zamyka sesję

> [!warning] Depends to nie tylko baza danych
> Najczęstszy błąd mentalny: myślenie że Depends = "coś do bazy". Depends to mechanizm ogólny. Używasz go do:
> - sesji DB (`get_db`)
> - weryfikacji tokenu JWT (`get_current_user`)
> - ustawień aplikacji (`get_settings`)
> - limitowania dostępu (permission check)
> - cachowania wyników
>
> Jeśli coś jest potrzebne w wielu endpointach i powinno być testowalne osobno — to kandydat na `Depends`.

> [!tip] Depends można zagnieżdżać
> ```python
> def get_current_user(token: str = Depends(oauth2_scheme), db = Depends(get_db)):
>     ...
> ```
> FastAPI sam ogarnie kolejność i współdzielenie — `get_db` wywoła się raz na request nawet jeśli kilka funkcji go potrzebuje.

## Połączenia
- [[Zależności jako bramki — auth, DB session, config]] — praktyczne wzorce użycia
- [[TestClient — jak testować FastAPI bez serwera]] — `app.dependency_overrides` pozwala podmieniać Depends w testach
- [[FastAPI co to jest i skąd się wziął]] — DI to jeden z filarów architektury FastAPI
