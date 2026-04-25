# 05 — Backend Implementation Plan

Status: Living Draft  
Owner: Backend Developer Agent  
Depends on: `04_openapi_alignment_plan.md`  
Next: `06_frontend_backend_integration_plan.md`  
Last updated: YYYY-MM-DD HH:MMZ

## Cel

Zaimplementować backend w `api/` zgodnie z zaakceptowanym `openapi.yaml`, modelem domenowym i flow MVP. Backend ma być wystarczający do integracji z frontendem, testowalny i ograniczony do MVP.

## Źródła wejściowe

Agent musi pracować na aktualnych plikach repozytorium, w szczególności:

- `project_assumptions.md` / `project_asumptions.md` — źródło prawdy dla zakresu produktu.
- `domain_model.md` — źródło prawdy dla encji, relacji i decyzji domenowych.
- `er_diagram.md` — źródło prawdy dla relacji danych.
- `user_flow.mmd` — źródło prawdy dla przepływu end-to-end.
- `openapi.yaml` — kontrakt API między `pwa/` i `api/`.
- `README.md` — instrukcje lokalne, jeżeli zawiera komendy uruchomieniowe.

Jeżeli nazwy plików różnią się między repozytorium a dokumentacją, agent ma użyć faktycznie istniejącej nazwy i zapisać niezgodność w `docs/open_questions.md`.


## Zakres

- FastAPI backend w `api/`.
- Pydantic schemas zgodne z `openapi.yaml`.
- Modele persystencji zgodne z `domain_model.md` i `er_diagram.md`.
- Endpointy MVP z `openapi.yaml`.
- Seed data do lokalnego uruchomienia.
- Deterministyczny generator grafiku MVP.
- Walidator twardych ograniczeń dla generowania, ręcznych korekt i zamian.
- Testy endpointów i usług domenowych.

## Poza zakresem

- Przepisywanie frontendu.
- Modyfikacja `pwa/`, poza ewentualnym odczytem kontraktu integracyjnego.
- Dodawanie endpointów poza `openapi.yaml`.
- Produkcyjna integracja SSO.
- Produkcyjny system e-mail/push; w MVP może być mock/outbox.
- Integracje HR/płacowe, P1, systemy państwowe.
- Finalna strategia backupu, CI/CD, hosting produkcyjny.
- Algorytm ML albo predykcyjny.

## Dozwolone ścieżki

- `api/src/**`
- `api/tests/**`
- `api/pyproject.toml`, `api/ruff.toml`, `api/pytest.toml`, `api/tox.toml`, tylko jeśli konieczne.
- `api/README.md` lub sekcja backendowa README, jeśli istnieje.
- `docs/open_questions.md`
- `docs/execution/05_backend_implementation_plan.md`

## Zabronione ścieżki

- `pwa/**`
- `openapi.yaml`, chyba że implementacja ujawni błąd blokujący; wtedy zatrzymaj i wpisz problem do handoffu.
- Dokumenty domenowe jako źródło prawdy.

## Protokół dynamicznej aktualizacji planu

Ten plik jest planem żywym. Agent może go aktualizować w trakcie kodowania, ale tylko w kontrolowany sposób:

- Aktualizuj `Status`, `Last updated` i `Change log` po istotnej zmianie zakresu lub wyniku.
- Odhaczaj wykonane zadania dopiero po walidacji.
- Nie usuwaj wcześniejszych ustaleń; dopisuj korekty jako nowe wpisy.
- Jeżeli pojawi się luka w wymaganiach, wpisz ją do `docs/open_questions.md`, a nie implementuj założenia „z głowy”.
- Jeżeli potrzebna jest zmiana architektoniczna, zaproponuj ADR albo aktualizację istniejącego ADR.


## Kolejność implementacji

### Slice 1 — bootstrap i health

- FastAPI app startuje.
- Routing i dependency setup.
- Test klienta API.
- Health endpoint tylko jeśli template już go przewiduje albo jest potrzebny lokalnie; jeżeli nie ma go w OpenAPI, nie traktuj go jako publiczny kontrakt MVP.

### Slice 2 — auth i seed użytkowników

- Minimalne lokalne auth zgodne z `/auth/login`, `/auth/refresh`, `/auth/me`.
- Role: `ADMIN`, `COORDINATOR`, `DOCTOR`.
- Nie implementuj produkcyjnego SSO w tej fazie.

### Slice 3 — podstawowe encje

- Users, roles.
- Departments.
- CoordinatorAssignment.
- DoctorProfile.
- DoctorInvitation.
- Qualifications.

### Slice 4 — schedule lifecycle

- Schedule CRUD MVP.
- Participants.
- Shifts 24h.
- Assignments.
- Status transitions:
  - `DRAFT -> GENERATED`
  - `GENERATED -> PUBLISHED`
  - `PUBLISHED -> ARCHIVED`
- Blokada zwykłych zmian po `PUBLISHED`.

### Slice 5 — availability, leave, generation

- Availability declarations.
- Availability days.
- Leave requests.
- Preference categories I–III.
- Deterministyczny generator.
- Conflict report przy braku zgodnej obsady.

### Slice 6 — validation

Wspólny walidator dla:

- generowania;
- ręcznej korekty assignmentu;
- swap request.

Minimalne twarde reguły MVP:

- dyżur 24h;
- jeden aktywny assignment na shift;
- brak overlapów dla lekarza;
- zgodność kwalifikacji, z obsługą statusu `UNKNOWN`;
- niedostępność/urlop blokuje assignment;
- minimalny odpoczynek między dyżurami;
- tygodniowe limity zgodnie z profilem `optOutSigned` i `weeklyHourLimitMinutes`, w uproszczeniu opisanym testami;
- opublikowany grafik zmieniany tylko przez swap.

### Slice 7 — swap flow

- Create swap after `PUBLISHED`.
- Candidate response: first accepted candidate wins.
- Validation before coordinator approval.
- Coordinator approve/reject.
- On approve: old assignment `REPLACED`, new assignment source `SWAP`.
- Audit log entry.

### Slice 8 — metrics, notifications, calendar, audit

- Schedule metrics.
- Notification outbox/mock.
- ICS export endpoint.
- Audit log list.
- Append-only audit behavior.

## Zadania

- [ ] (YYYY-MM-DD HH:MMZ) Przeczytaj handoff z fazy 04 i potwierdź, że OpenAPI jest gotowe.
- [ ] (YYYY-MM-DD HH:MMZ) Sprawdź istniejący template `api/`, pyproject, zależności, strukturę `src/` i testów.
- [ ] (YYYY-MM-DD HH:MMZ) Wybierz implementację zgodną z template; nie wymieniaj stacku bez potrzeby.
- [ ] (YYYY-MM-DD HH:MMZ) Utwórz/uzupełnij Pydantic schemas zgodne z `openapi.yaml`.
- [ ] (YYYY-MM-DD HH:MMZ) Utwórz/uzupełnij modele persystencji zgodne z `domain_model.md`.
- [ ] (YYYY-MM-DD HH:MMZ) Dodaj seed data dla jednego oddziału, koordynatora, lekarzy, grafików i preferencji.
- [ ] (YYYY-MM-DD HH:MMZ) Implementuj endpointy Auth.
- [ ] (YYYY-MM-DD HH:MMZ) Implementuj endpointy Users, Departments, Doctors, Invitations.
- [ ] (YYYY-MM-DD HH:MMZ) Implementuj endpointy Schedules, Participants, Shifts, Assignments.
- [ ] (YYYY-MM-DD HH:MMZ) Implementuj Availability i Leave Requests.
- [ ] (YYYY-MM-DD HH:MMZ) Implementuj GenerationRun i ConflictReport.
- [ ] (YYYY-MM-DD HH:MMZ) Implementuj ValidationResult i ConstraintViolation.
- [ ] (YYYY-MM-DD HH:MMZ) Implementuj publish/archive z blokadą stanu.
- [ ] (YYYY-MM-DD HH:MMZ) Implementuj SwapRequest flow.
- [ ] (YYYY-MM-DD HH:MMZ) Implementuj Metrics, Notifications, CalendarExports i AuditLog.
- [ ] (YYYY-MM-DD HH:MMZ) Dodaj testy unit dla walidatora.
- [ ] (YYYY-MM-DD HH:MMZ) Dodaj testy API dla krytycznych endpointów.
- [ ] (YYYY-MM-DD HH:MMZ) Uruchom walidację backendu.
- [ ] (YYYY-MM-DD HH:MMZ) Uzupełnij handoff dla Integration Agenta.

## Wymagane testy domenowe

- Utworzenie grafiku w `DRAFT`.
- Złożenie availability przez lekarza przed deadline.
- Blokada availability po deadline.
- Generowanie grafiku sukcesem.
- Generowanie grafiku z konfliktem.
- Ręczny assignment blokowany przez twarde naruszenie.
- Publikacja tylko poprawnego grafiku.
- Brak zwykłej edycji assignmentów po `PUBLISHED`.
- Swap odrzucony przy naruszeniu twardej reguły.
- Swap zatwierdzony tworzy nowy assignment i oznacza stary jako `REPLACED`.
- AuditLogEntry powstaje przy generowaniu, publikacji i swap approval.

## Wykrywanie komend walidacyjnych

Przed uruchamianiem walidacji agent powinien sprawdzić faktyczne narzędzia projektu:

```bash
ls
find . -maxdepth 3 -name package.json -o -name pyproject.toml -o -name uv.lock -o -name pnpm-lock.yaml -o -name package-lock.json -o -name yarn.lock
```

Dla `pwa/` użyj menedżera pakietów wynikającego z lockfile. Dla `api/` użyj istniejącego toolingu, w szczególności `uv`, `ruff`, `pytest`, `coverage`, jeżeli są skonfigurowane.


## Komendy walidacyjne

Dostosować do faktycznego toolingu `api/`:

```bash
cd api
uv sync
uv run ruff check .
uv run pytest
uv run coverage run -m pytest
uv run coverage report
```

Jeżeli mypy jest skonfigurowany:

```bash
uv run mypy src tests
```

## Kryteria akceptacji

- Backend startuje lokalnie.
- Endpointy z `openapi.yaml` są zaimplementowane albo jawnie oznaczone jako niezaimplementowane z powodem blokującym MVP.
- Testy API i testy domenowe przechodzą.
- Dane seed umożliwiają frontendową integrację.
- `pwa/` nie zostało zmienione.
- Brak endpointów poza kontraktem.
- Handoff zawiera base URL, sposób auth, seed users i znane ograniczenia.

## Ryzyka

- OpenAPI okaże się zbyt szerokie względem MVP.
- Walidator prawny zostanie nadmiernie uproszczony.
- Generator będzie niedeterministyczny.
- Auth produkcyjne zacznie blokować MVP.
- Modele bazy będą odbiegać od `domain_model.md`.

## Rollback

- Przywróć `api/src` i `api/tests` do stanu sprzed fazy.
- Zachowaj raport implementacyjny i błędy kontraktu w handoffie.
- Jeżeli problem jest w `openapi.yaml`, wróć do fazy 04 zamiast patchować kontrakt po cichu.

## Handoff

- Completed:
- Validation:
- API base URL:
- Auth/seed users:
- Known limitations:
- OpenAPI deviations:
- Open questions:
- Recommended next step:
