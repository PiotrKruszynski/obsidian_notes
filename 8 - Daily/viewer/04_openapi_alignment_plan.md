# 04 — OpenAPI Alignment Plan

Status: Living Draft  
Owner: Mock API / Contract Agent  
Depends on: `03_mock_api_plan.md`  
Next: `05_backend_implementation_plan.md`  
Last updated: YYYY-MM-DD HH:MMZ

## Cel

Dopasować `openapi.yaml` do faktycznych flow MVP, typów domenowych i frontendowej warstwy `services`, bez implementowania backendu. Po tej fazie `openapi.yaml` jest kontraktem dla backendu FastAPI i integracji frontendu.

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

- Przegląd `openapi.yaml` względem `project_assumptions.md`, `domain_model.md`, `er_diagram.md`, `user_flow.mmd`.
- Porównanie endpointów z funkcjami `pwa/src/services`.
- Korekta request/response schemas, enumów i operationId, jeżeli są niespójne.
- Utworzenie raportu alignmentu.
- Ograniczenie kontraktu do MVP.

## Poza zakresem

- Implementacja backendu.
- Zmiana kodu `api/`.
- Przepisywanie frontendu.
- Dodawanie non-MVP endpointów.
- Wybór docelowego hostingu, CI/CD, backupu, produkcyjnego RBAC poza kontraktem MVP.

## Dozwolone ścieżki

- `openapi.yaml`
- `docs/openapi_alignment_report.md`
- `docs/open_questions.md`
- `docs/execution/04_openapi_alignment_plan.md`

## Zabronione ścieżki

- `api/**`
- `pwa/src/**`, poza odczytem.
- Pliki assumptions/domain jako źródło prawdy nie powinny być zmieniane w tej fazie.

## Protokół dynamicznej aktualizacji planu

Ten plik jest planem żywym. Agent może go aktualizować w trakcie kodowania, ale tylko w kontrolowany sposób:

- Aktualizuj `Status`, `Last updated` i `Change log` po istotnej zmianie zakresu lub wyniku.
- Odhaczaj wykonane zadania dopiero po walidacji.
- Nie usuwaj wcześniejszych ustaleń; dopisuj korekty jako nowe wpisy.
- Jeżeli pojawi się luka w wymaganiach, wpisz ją do `docs/open_questions.md`, a nie implementuj założenia „z głowy”.
- Jeżeli potrzebna jest zmiana architektoniczna, zaproponuj ADR albo aktualizację istniejącego ADR.


## Endpointy bazowe oczekiwane w kontrakcie

Kontrakt powinien obejmować MVP:

- Auth: `/auth/login`, `/auth/refresh`, `/auth/me`
- Users / roles: `/users`, `/users/{userId}`, `/users/{userId}/roles`
- Departments: `/departments`, `/departments/{departmentId}`, `/departments/{departmentId}/coordinator`
- Doctors / invitations: `/doctor-profiles`, `/doctor-profiles/{doctorProfileId}`, `/doctor-invitations`, `/doctor-invitations/accept`
- Configuration: `/preference-categories`, `/constraint-rules`
- Schedules: `/schedules`, `/schedules/{scheduleId}`, participants, shifts, assignments
- Availability: `/schedules/{scheduleId}/availability`, `/availability/me`, `/availability/{doctorProfileId}`
- Generation: `/schedules/{scheduleId}/generate`, `/generation-runs/{generationRunId}`, `/conflict-report`
- Validation: `/schedules/{scheduleId}/validate`
- Lifecycle: `/publish`, `/archive`
- Leave requests: schedule-scoped list/create plus approve/reject/cancel
- Swaps: schedule-scoped list/create plus respond/validate/approve/reject
- Metrics: `/schedules/{scheduleId}/metrics`
- Notifications: `/notifications`, mark read
- Calendar exports: `/calendar-exports`, ICS token URL
- Audit: `/audit-log`

## Schematy i enumy krytyczne

Zweryfikuj szczególnie:

- `RoleCode`: `ADMIN`, `COORDINATOR`, `DOCTOR`
- `ScheduleStatus`: `DRAFT`, `GENERATED`, `PUBLISHED`, `ARCHIVED`
- `ShiftStatus`: `UNASSIGNED`, `ASSIGNED`, `CONFLICTED`
- `AssignmentStatus`: `PROPOSED`, `CONFIRMED`, `REPLACED`, `CANCELLED`
- `AssignmentSource`: `GENERATED`, `MANUAL`, `SWAP`
- `AvailabilityType`: `AVAILABLE`, `UNAVAILABLE`, `PREFERRED`, `NOT_PREFERRED`
- `LeaveRequestStatus`: `SUBMITTED`, `APPROVED`, `REJECTED`, `CANCELLED`
- `SwapRequestStatus`, w tym akceptacja lekarzy i decyzja Koordynatora
- `ValidationResult` i `ConstraintViolation`
- `ConflictReport` i `ConflictItem`
- `ScheduleMetricsResponse`
- `AuditLogEntry`

## Zadania

- [ ] (YYYY-MM-DD HH:MMZ) Przeczytaj handoff z fazy 03, zwłaszcza mapowanie services → endpointy.
- [ ] (YYYY-MM-DD HH:MMZ) Sprawdź, czy każda funkcja services ma odpowiadający endpoint lub uzasadniony brak endpointu.
- [ ] (YYYY-MM-DD HH:MMZ) Sprawdź, czy każdy endpoint z `openapi.yaml` jest potrzebny w MVP albo jest uzasadniony jako przygotowany kontrakt.
- [ ] (YYYY-MM-DD HH:MMZ) Porównaj enumy OpenAPI z typami frontendowymi i `domain_model.md`.
- [ ] (YYYY-MM-DD HH:MMZ) Porównaj request/response schemas dla grafiku, dyżurów, przydziałów, dostępności, urlopów, zamian, walidacji i audytu.
- [ ] (YYYY-MM-DD HH:MMZ) Zweryfikuj, że endpointy lifecycle respektują state machine: `DRAFT -> GENERATED -> PUBLISHED -> ARCHIVED`.
- [ ] (YYYY-MM-DD HH:MMZ) Zweryfikuj, że `PUBLISHED` nie ma zwykłej edycji assignmentów poza swap flow; jeżeli kontrakt pozwala na niebezpieczne operacje, opisz ograniczenia w schemas/description albo report.
- [ ] (YYYY-MM-DD HH:MMZ) Zweryfikuj, że twarde naruszenia są reprezentowane przez `ValidationResult` i nie prowadzą do zatwierdzenia.
- [ ] (YYYY-MM-DD HH:MMZ) Zaktualizuj `openapi.yaml` tylko tam, gdzie wymaga tego MVP albo spójność kontraktu.
- [ ] (YYYY-MM-DD HH:MMZ) Utwórz `docs/openapi_alignment_report.md`.
- [ ] (YYYY-MM-DD HH:MMZ) Uruchom walidację OpenAPI.
- [ ] (YYYY-MM-DD HH:MMZ) Uzupełnij handoff dla Backend Developer Agenta.

## Walidacja OpenAPI

Preferowane komendy, jeśli narzędzia są dostępne:

```bash
npx @redocly/cli lint openapi.yaml
npx swagger-cli validate openapi.yaml
```

Jeżeli narzędzi nie ma, użyj dostępnego walidatora albo odnotuj brak w handoffie. Nie instaluj globalnych zależności bez potrzeby.

## Raport alignmentu

`docs/openapi_alignment_report.md` powinien zawierać:

- listę services z mapowaniem do endpointów;
- listę zmian w `openapi.yaml`;
- listę świadomie pozostawionych endpointów;
- listę braków i pytań;
- decyzję, czy backend może startować.

## Kryteria akceptacji

- `openapi.yaml` jest syntaktycznie poprawny.
- Kontrakt pokrywa kluczowe flow z `user_flow.mmd`.
- Schematy odzwierciedlają `domain_model.md`.
- Nie dodano non-MVP endpointów bez uzasadnienia.
- Backend Developer Agent może implementować API bez zgadywania.

## Ryzyka

- Kontrakt jest zbyt szeroki jak na MVP.
- Frontend services i OpenAPI mają różne modele błędów.
- OpenAPI pozwala na operacje, które domenowo powinny być blokowane.
- Brakuje explicit description dla ograniczeń `PUBLISHED`.

## Rollback

- Cofnij `openapi.yaml` do wersji sprzed fazy.
- Zachowaj `docs/openapi_alignment_report.md` z listą konfliktów.
- Zatrzymaj backend implementation do czasu rozwiązania kontraktu.

## Handoff

- Completed:
- Validation:
- OpenAPI ready for backend: yes/no
- Breaking changes for frontend:
- Known issues:
- Open questions:
- Recommended next step:
