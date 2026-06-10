---
tags: [python, backend, koncepcja, rekrutacja]
powiązane: ["[[ASGI vs WSGI]]", "[[FastAPI — framework na Starlette i Pydantic]]"]
---

# FastAPI na tle Flask i Django

> [!summary] W jednym zdaniu
> Flask to minimalny zestaw "zrób wszystko sam", Django to kompletna fabryka z
> ORM i panelem admina, a FastAPI to specjalista od API: async natywnie,
> walidacja i dokumentacja z typów — wybór zależy od tego, czy budujesz API,
> pełny serwis WWW, czy mały prototyp.

| | Flask | Django | FastAPI |
|---|---|---|---|
| Filozofia | mikroframework | "batteries included" | nowoczesne API |
| Standard | WSGI (sync) | WSGI (ASGI od 3.0+) | ASGI (async natywnie) |
| Walidacja | sam/dodatki | Django Forms/DRF | Pydantic wbudowany |
| Dokumentacja API | dodatki | dodatki (drf-spectacular) | automatyczna /docs |
| ORM | brak (dobierz sam) | wbudowany + migracje | brak (zwykle SQLAlchemy) |
| Admin panel | brak | wbudowany | brak |

Jak wybrać (wersja na rozmowę):
- **API/mikroserwis, dużo I/O, frontend osobno** → FastAPI.
- **Pełny serwis z panelem admina, auth, szybki time-to-market** → Django.
- **Mały prototyp, pełna kontrola nad doborem klocków** → Flask.

> [!warning] Nie mów "FastAPI jest po prostu lepszy"
> Brak wbudowanego ORM, migracji i admina to realny koszt: w FastAPI składasz
> stack sam (SQLAlchemy + Alembic + ...). Rekruter docenia, że widzisz
> kompromisy, nie fanboystwo. Dobra puenta: "do API wybrałbym FastAPI, do CMS-a
> z adminem — Django".

## Połączenia
- [[ASGI vs WSGI]] — fundamentalna różnica techniczna między nimi
- [[FastAPI — framework na Starlette i Pydantic]] — co dokładnie daje FastAPI
