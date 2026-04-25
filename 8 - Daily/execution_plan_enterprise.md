
```
# execution_plan.md (Enterprise Version - Paweł Konior style)

## Cel

Zbudować **enterprise-grade aplikację flashcards** zgodną z najlepszymi praktykami inżynierii oprogramowania.

Nie budujemy POC. Budujemy **skalowalny, produkcyjny fundament systemu**, który:

- jest zgodny z clean architecture
- jest gotowy pod rozbudowę (RAG / AI / agents)
- ma wysoką jakość kodu (linting, typing, testy)
- posiada modularną strukturę
- wspiera przyszłe skalowanie (multi-user, microservices)

---

## Zakres (v1 - MVP produkcyjne)

### In scope
- ekran główny zgodny z mockiem
- pobieranie flashcard z backendu
- backend API (FastAPI)
- baza SQLite (ale przygotowana pod migrację do Postgres)
- testy jednostkowe i integracyjne
- testy E2E (Playwright)
- Lighthouse audit
- struktura repo zgodna z enterprise standardami

### Out of scope (na ten etap)
- auth (ale przygotowana architektura)
- multi-user
- AI generation
- spaced repetition engine

---

## Architektura (Enterprise)

### Frontend
- React (latest)
- Vite
- Tailwind
- TypeScript (strict)
- Feature-based architecture
- API layer abstraction

### Backend
- FastAPI
- SQLModel / SQLAlchemy
- SQLite (dev) → Postgres-ready
- Domain + Service + API layers

### QA
- Playwright (E2E)
- Lighthouse
- basic performance checks

---

## Struktura agentów

### 1. Orchestrator (Lead AI / Delivery Lead)
- zarządza delivery
- egzekwuje standardy enterprise
- pilnuje architektury
- prowadzi code reviews

### 2. UX Designer (Product UX)
- projektuje UX zgodny z iOS / Human Interface Guidelines
- definiuje system design tokens

### 3. Frontend Engineer (Senior FE)
- buduje UI zgodnie z design systemem
- stosuje clean architecture FE

### 4. Backend Engineer (Senior BE)
- buduje modularny backend
- stosuje layered architecture

### 5. QA Engineer
- buduje testy E2E
- waliduje jakość aplikacji

---

## Worktree Strategy (Enterprise)

```bash
git worktree add ../orchestrator -b feat/orchestrator
git worktree add ../ux -b feat/ux-system
git worktree add ../frontend -b feat/frontend-core
git worktree add ../backend -b feat/backend-core
git worktree add ../qa -b feat/qa-suite


Każdy agent:
- pracuje izolowanie
- ma własne środowisko
- dostarcza PR

---

## Plan dla Orchestratora

### Cel
Zarządzać delivery jak Tech Lead + Product Owner

### Kroki
1. Zdefiniuj architecture decision record (ADR)
2. Zdefiniuj kontrakt API
3. Ustal standardy:
   - lint (ruff / eslint)
   - typing (mypy / TS strict)
   - test coverage
4. Rozdziel zadania agentom
5. Review każdego PR
6. Pilnuj spójności

---

## Plan dla UX

### Cel
Zbudować system UX, nie tylko ekran

### Kroki
1. Zdefiniuj spacing scale (8pt system)
2. Zdefiniuj typography
3. Zdefiniuj design tokens (colors, gradients)
4. Zdefiniuj component states
5. Przygotuj spec dla FE

---

## Plan dla Backend

### Struktura


backend/
  app/
    domain/
    services/
    api/
    db/


### Kroki
1. Setup FastAPI
2. Setup DB abstraction
3. Model Flashcard
4. Service layer (business logic)
5. API layer
6. Testy

---

## Plan dla Frontend

### Struktura


frontend/
  src/
    features/
    shared/
    app/


### Kroki
1. Setup Vite + React + TS
2. Setup Tailwind
3. Design tokens
4. Flashcard feature
5. API client
6. State management (minimal)

---

## Plan dla QA

### Kroki
1. Setup Playwright
2. Test scenariuszy
3. Lighthouse audit
4. Raport jakości

---

## Definition of Done (Enterprise)

- kod zgodny z lint
- testy passing
- typing strict passing
- architektura zgodna z planem
- brak hacków POC
- gotowe pod skalowanie

---

## Guardrails

ZAKAZ:
- quick hacków
- braku testów
- inline logiki bez warstw
- mieszania UI z logiką

WYMAGANE:
- clean architecture
- testability
- modularność
- readability

---

## Mindset

To nie jest demo.

To jest **foundation pod produkt**, który można:
- skalować
- monetyzować
- rozwijać w kierunku AI / agents


