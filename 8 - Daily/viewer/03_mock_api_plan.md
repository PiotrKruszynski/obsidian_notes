# 03 — Mock API Plan

Status: Living Draft  
Owner: Mock API / Service Layer Agent  
Depends on: `02_frontend_refactor_plan.md`  
Next: `04_openapi_alignment_plan.md`  
Last updated: YYYY-MM-DD HH:MMZ

## Cel

Wprowadzić mock API po stronie frontendu: asynchroniczną warstwę `services`, która zachowuje się jak backend, ale korzysta z lokalnych danych mockowych. Komponenty React mają komunikować się z aplikacją przez funkcje serwisowe, nie przez bezpośredni import danych.

## Źródła wejściowe

Agent musi pracować na aktualnych plikach repozytorium, w szczególności:

- `project_assumptions.md` / `project_asumptions.md` — źródło prawdy dla zakresu produktu.
- `domain_model.md` — źródło prawdy dla encji, relacji i decyzji domenowych.
- `er_diagram.md` — źródło prawdy dla relacji danych.
- `user_flow.mmd` — źródło prawdy dla przepływu end-to-end.
- `openapi.yaml` — kontrakt API między `pwa/` i `api/`.
- `README.md` — instrukcje lokalne, jeżeli zawiera komendy uruchomieniowe.

Jeżeli nazwy plików różnią się między repozytorium a dokumentacją, agent ma użyć faktycznie istniejącej nazwy i zapisać niezgodność w `docs/open_questions.md`.


## Zasada

Mock API to tymczasowa imitacja backendu. Komponent woła np. `getSchedule(scheduleId)`, a implementacja na razie zwraca dane z `pwa/src/mocks`. Po integracji backendowej zmieni się wnętrze serwisu, a nie komponenty.

## Zakres

- Utworzenie `pwa/src/services/**`.
- Uporządkowanie `pwa/src/mocks/**`.
- Dodanie asynchronicznych funkcji serwisowych zgodnych z flow MVP.
- Dodanie prostego kontrolowanego stanu danych mockowych, jeżeli UI wymaga operacji create/update.
- Przygotowanie raportu niezgodności między usługami frontendowymi a `openapi.yaml`.

## Poza zakresem

- Prawdziwe `fetch` do backendu.
- Modyfikacja `api/`.
- Modyfikacja `openapi.yaml`; to robi faza 04.
- Implementacja algorytmu produkcyjnego.
- Rozbudowa UI ponad konieczne podłączenie usług.

## Dozwolone ścieżki

- `pwa/src/services/**`
- `pwa/src/mocks/**`
- `pwa/src/types/**`
- `pwa/src/features/**`, tylko w celu podłączenia services.
- `docs/open_questions.md`
- `docs/execution/03_mock_api_plan.md`

## Zabronione ścieżki

- `api/**`
- `openapi.yaml`
- Backend config, baza danych, migracje.

## Protokół dynamicznej aktualizacji planu

Ten plik jest planem żywym. Agent może go aktualizować w trakcie kodowania, ale tylko w kontrolowany sposób:

- Aktualizuj `Status`, `Last updated` i `Change log` po istotnej zmianie zakresu lub wyniku.
- Odhaczaj wykonane zadania dopiero po walidacji.
- Nie usuwaj wcześniejszych ustaleń; dopisuj korekty jako nowe wpisy.
- Jeżeli pojawi się luka w wymaganiach, wpisz ją do `docs/open_questions.md`, a nie implementuj założenia „z głowy”.
- Jeżeli potrzebna jest zmiana architektoniczna, zaproponuj ADR albo aktualizację istniejącego ADR.


## Docelowa struktura

```text
pwa/src/
  services/
    authService.ts
    userService.ts
    departmentService.ts
    doctorService.ts
    scheduleService.ts
    availabilityService.ts
    generationService.ts
    validationService.ts
    leaveRequestService.ts
    swapRequestService.ts
    metricsService.ts
    notificationService.ts
    calendarExportService.ts
    auditLogService.ts
    index.ts
  mocks/
    mockDb.ts
    seedUsers.ts
    seedDepartments.ts
    seedDoctors.ts
    seedSchedules.ts
    seedAvailability.ts
    seedSwaps.ts
    seedMetrics.ts
```

Jeżeli istniejący projekt preferuje inną strukturę, zachowaj ją, ale utrzymaj separację `services` i `mocks`.

## Minimalne funkcje serwisowe

### Auth / current user

- `login(email, password)`
- `refreshToken(refreshToken)`
- `getCurrentUser()`

### Users / admin

- `listUsers(filters)`
- `createUser(payload)`
- `updateUser(userId, payload)`
- `replaceUserRoles(userId, payload)`

### Departments / doctors

- `listDepartments()`
- `getDepartment(departmentId)`
- `assignCoordinator(departmentId, coordinatorUserId)`
- `listDoctorProfiles(filters)`
- `getDoctorProfile(doctorProfileId)`
- `createDoctorInvitation(payload)`
- `acceptDoctorInvitation(payload)`

### Schedules

- `listSchedules(filters)`
- `createSchedule(payload)`
- `getSchedule(scheduleId)`
- `updateSchedule(scheduleId, payload)`
- `listParticipants(scheduleId)`
- `addParticipant(scheduleId, payload)`
- `removeParticipant(scheduleId, doctorProfileId)`

### Availability / leave

- `listScheduleAvailability(scheduleId)`
- `getMyAvailability(scheduleId)`
- `submitMyAvailability(scheduleId, payload)`
- `listLeaveRequests(scheduleId)`
- `createLeaveRequest(scheduleId, payload)`
- `approveLeaveRequest(leaveRequestId, payload)`
- `rejectLeaveRequest(leaveRequestId, payload)`
- `cancelLeaveRequest(leaveRequestId)`

### Shifts / assignments

- `listShifts(scheduleId)`
- `createShift(scheduleId, payload)`
- `updateShift(scheduleId, shiftId, payload)`
- `listAssignments(scheduleId)`
- `createAssignment(scheduleId, payload)`
- `updateAssignment(scheduleId, assignmentId, payload)`
- `deleteAssignment(scheduleId, assignmentId)`

### Generation / validation

- `generateSchedule(scheduleId, payload)`
- `getGenerationRun(generationRunId)`
- `getConflictReport(generationRunId)`
- `validateSchedule(scheduleId, payload)`
- `publishSchedule(scheduleId, payload)`
- `archiveSchedule(scheduleId, payload)`

### Swaps

- `listSwapRequests(scheduleId)`
- `createSwapRequest(scheduleId, payload)`
- `getSwapRequest(swapRequestId)`
- `respondToSwapRequest(swapRequestId, payload)`
- `validateSwapRequest(swapRequestId)`
- `approveSwapRequest(swapRequestId, payload)`
- `rejectSwapRequest(swapRequestId, payload)`

### Metrics / notifications / audit

- `getScheduleMetrics(scheduleId)`
- `listNotifications()`
- `markNotificationRead(notificationId)`
- `listCalendarExports()`
- `createCalendarExport(payload)`
- `deleteCalendarExport(calendarExportId)`
- `listAuditLog(filters)`

## Zadania

- [ ] (YYYY-MM-DD HH:MMZ) Przeczytaj handoff z fazy 02.
- [ ] (YYYY-MM-DD HH:MMZ) Sprawdź, gdzie komponenty importują mock data bezpośrednio.
- [ ] (YYYY-MM-DD HH:MMZ) Utwórz `mockDb` zawierający encje z `domain_model.md`.
- [ ] (YYYY-MM-DD HH:MMZ) Dodaj asynchroniczne funkcje serwisowe z minimalną symulacją latency, jeśli nie utrudnia testów.
- [ ] (YYYY-MM-DD HH:MMZ) Przenieś logikę pobierania danych z komponentów do services.
- [ ] (YYYY-MM-DD HH:MMZ) Obsłuż podstawowe operacje mutujące: submit availability, generate schedule, publish schedule, create/respond/approve swap.
- [ ] (YYYY-MM-DD HH:MMZ) Upewnij się, że mutacje mockowe respektują `Schedule.status`.
- [ ] (YYYY-MM-DD HH:MMZ) Upewnij się, że mock `generateSchedule` może zwrócić zarówno sukces, jak i `ConflictReport`.
- [ ] (YYYY-MM-DD HH:MMZ) Upewnij się, że mock `validateSwapRequest` zwraca `ValidationResult`.
- [ ] (YYYY-MM-DD HH:MMZ) Wygeneruj notatkę do fazy 04: lista funkcji services i odpowiadających endpointów OpenAPI.
- [ ] (YYYY-MM-DD HH:MMZ) Uruchom build/lint/typecheck/test.
- [ ] (YYYY-MM-DD HH:MMZ) Uzupełnij handoff dla Contract Agenta.

## Reguły implementacji mocków

- Funkcje mają być `async`, nawet jeśli zwracają dane lokalne.
- Komponenty nie powinny wiedzieć, czy dane są z mocków, czy z backendu.
- Mocki muszą używać typów domenowych.
- Błędy powinny być modelowane jako wyjątki albo typowane error objects — wybierz jedną konwencję i opisz ją w handoffie.
- Nie dodawaj endpointów ani funkcji dla rzeczy poza MVP.

## Wykrywanie komend walidacyjnych

Przed uruchamianiem walidacji agent powinien sprawdzić faktyczne narzędzia projektu:

```bash
ls
find . -maxdepth 3 -name package.json -o -name pyproject.toml -o -name uv.lock -o -name pnpm-lock.yaml -o -name package-lock.json -o -name yarn.lock
```

Dla `pwa/` użyj menedżera pakietów wynikającego z lockfile. Dla `api/` użyj istniejącego toolingu, w szczególności `uv`, `ruff`, `pytest`, `coverage`, jeżeli są skonfigurowane.


## Komendy walidacyjne

```bash
cd pwa
npm run build
npm run lint
npm run typecheck
npm run test
```

## Kryteria akceptacji

- Dane są pobierane przez `services`, nie importowane bezpośrednio przez komponenty.
- Services pokrywają kluczowe flow z `user_flow.mmd`.
- Mocki reprezentują encje z `domain_model.md`.
- UI działa bez backendu.
- Brak zmian w `api/` i `openapi.yaml`.
- Handoff zawiera mapowanie services → oczekiwane endpointy.

## Ryzyka

- Mock services staną się niezgodne z OpenAPI.
- Agent zaimplementuje zbyt dużo logiki biznesowej w frontendzie.
- Mutacje mockowe będą nieliniowe lub trudne do testowania.
- UI będzie zależny od specyficznej struktury mocków zamiast kontraktu.

## Rollback

- Przywróć komponenty do importu seed data, jeżeli services są niestabilne.
- Usuń `pwa/src/services/**`, jeśli warstwa jest błędna.
- Zachowaj `pwa/src/mocks/**`, jeżeli dane są poprawne i potrzebne do kolejnej próby.

## Handoff

- Completed:
- Validation:
- Services to OpenAPI mapping:
- Known issues:
- Open questions:
- Recommended next step:
