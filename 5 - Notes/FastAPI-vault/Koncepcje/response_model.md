---
tags: [fastapi, pydantic, koncepcja, bezpieczeństwo]
powiązane: ["[[Model Pydantic]]", "[[Path operation]]"]
sr_due: 2026-07-05
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# response_model

> [!summary] W jednym zdaniu
> `response_model` to filtr na wyjściu: cokolwiek zwróci funkcja, FastAPI
> przepuści przez wskazany model i **wytnie pola spoza niego** — dzięki czemu
> hasło z obiektu użytkownika nigdy nie wycieknie do JSON-a, nawet gdy
> programista zwróci cały obiekt przez nieuwagę.

Walidacja na wejściu chroni **ciebie** przed klientem. `response_model` chroni
**klienta (i twoje sekrety)** przed tobą. To druga połowa tej samej bramki.

> [!example] Wzorzec UserIn / UserOut
> ```python
> class UserIn(BaseModel):
>     email: str
>     password: str          # przychodzi przy rejestracji
>
> class UserOut(BaseModel):
>     email: str             # hasła celowo BRAK
>
> @app.post("/users", response_model=UserOut)
> def create_user(user: UserIn):
>     saved = save_to_db(user)
>     return saved           # zwracasz obiekt Z hasłem...
> ```
> ...ale klient dostaje tylko `{"email": "..."}`. FastAPI przefiltrował
> odpowiedź przez `UserOut`. Jedna deklaracja = brak całej klasy wycieków.

Bonus: `response_model` ląduje też w dokumentacji — frontend widzi w `/docs`
dokładny kształt odpowiedzi.

> [!tip] Na rozmowie
> Pytanie "po co response_model, skoro mogę zwrócić dict?" — odpowiedź:
> (1) filtracja pól wrażliwych, (2) gwarancja kontraktu API (zła struktura
> odpowiedzi = błąd serwera, nie cichy bałagan), (3) dokumentacja.

## Połączenia
- [[Model Pydantic]] — ten sam mechanizm, kierunek odwrotny
- [[Automatyczna dokumentacja OpenAPI]] — schemat odpowiedzi w /docs
