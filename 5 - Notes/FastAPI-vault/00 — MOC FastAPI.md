---
tags: [fastapi, moc]
---

# 00 — MOC FastAPI

Mapa treści pod rozmowę rekrutacyjną (junior Python backend). Nie czytaj
liniowo — wchodź przez sekcje, wracaj przez linki.

**Jak używać (plan na kilka godzin):**
1. Fundament (3 notatki) → zrozum *dlaczego* FastAPI działa, jak działa.
2. Codzienne narzędzia (5 notatek) → 80% pytań rekrutacyjnych.
3. Przepisz ręcznie [[Mini CRUD — kompletny przykład]] i przeklikaj w `/docs`.
4. Architektura i testy (4 notatki).
5. Na godzinę przed rozmową: [[Ściąga na rozmowę]] + pytania kontrolne niżej.

## Fundament
- [[FastAPI — framework na Starlette i Pydantic]] — co to jest i z czego się składa
- [[ASGI vs WSGI]] — dlaczego async w ogóle pomaga
- [[Uvicorn]] — kto faktycznie serwuje aplikację

## Codzienne narzędzia
- [[Path operation]] — routing i metody HTTP
- [[Skąd FastAPI bierze parametry]] — path / query / body z sygnatury
- [[Model Pydantic]] — walidacja na wejściu
- [[response_model]] — filtr i kontrakt na wyjściu
- [[HTTPException]] — błędy i kody statusu

## Asynchroniczność
- [[async def vs def w FastAPI]] — najczęstsza pułapka frameworka

## Architektura i jakość
- [[Depends — wstrzykiwanie zależności]] — DRY i testowalność
- [[APIRouter]] — struktura rosnącego projektu
- [[Middleware w FastAPI]] — sprawy globalne (CORS, logowanie)
- [[TestClient]] — testy bez serwera

## Kontekst rekrutacyjny
- [[FastAPI na tle Flask i Django]] — pytanie porównawcze, klasyk
- [[Mini CRUD — kompletny przykład]] — wszystko w jednym działającym pliku
- [[Ściąga na rozmowę]] — szybka powtórka Q&A

## Pytania kontrolne (sprawdź się bez zaglądania)
1. Z jakich dwóch bibliotek składa się FastAPI i co każda wnosi? → [[FastAPI — framework na Starlette i Pydantic]]
2. Czemu blokujące `requests.get()` w `async def` "wiesza" cały serwer, a w `def` nie? → [[async def vs def w FastAPI]]
3. Po czym FastAPI poznaje, że parametr ma przyjść w query, a nie w body? → [[Skąd FastAPI bierze parametry]]
4. Jaki kod statusu zwraca FastAPI przy błędzie walidacji i czym różni się od 400? → [[HTTPException]]
5. Jak `response_model` zapobiega wyciekowi hasła? → [[response_model]]
6. Co robi `yield` w zależności i kiedy wykonuje się kod po nim? → [[Depends — wstrzykiwanie zależności]]
7. Czemu `/users/me` musi być zadeklarowane przed `/users/{user_id}`? → [[Path operation]]
8. Skąd `/docs` "wie" o twoich endpointach? → [[Automatyczna dokumentacja OpenAPI]]
9. Czym różni się współbieżność (async) od równoległości (workery Uvicorna)? → [[Uvicorn]]
10. Kiedy uczciwie odradzisz FastAPI na rzecz Django? → [[FastAPI na tle Flask i Django]]
11. Jak podmienić prawdziwą bazę na testową bez zmiany kodu endpointów? → [[TestClient]]
12. Middleware czy Depends do autoryzacji wybranych tras — i dlaczego? → [[Middleware w FastAPI]]
