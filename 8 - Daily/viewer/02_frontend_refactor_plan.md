# 02 — Frontend Refactor Plan

Status: Living Draft  
Owner: Frontend Developer Agent  
Depends on: `01_figma_import_plan.md`  
Next: `03_mock_api_plan.md`  
Last updated: YYYY-MM-DD HH:MMZ

## Cel

Przekształcić zaimportowany React UI z Figma w utrzymywalną strukturę `pwa/src`, z rozdzieleniem komponentów, typów domenowych i danych mockowych. Frontend ma dalej działać bez backendu.

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

- Refaktor komponentów React/TypeScript.
- Utworzenie typów domenowych zgodnych z `domain_model.md`.
- Rozdzielenie widoków według ról: Lekarz, Koordynator, Admin.
- Usunięcie dużych bloków JSX z jednego pliku.
- Zachowanie wizualnej zgodności z importem Figma.
- Przygotowanie gruntu pod mock API w fazie 03.

## Poza zakresem

- Implementacja backendu.
- Modyfikacja `api/`.
- Modyfikacja `openapi.yaml`.
- Prawdziwe requesty HTTP.
- Zmiana zakresu MVP.
- Finalny design system lub kompletna biblioteka komponentów.

## Dozwolone ścieżki

- `pwa/src/**`
- `pwa/package.json`, tylko jeżeli potrzebne są istniejące/uzasadnione zależności frontendowe.
- `docs/open_questions.md`
- `docs/execution/02_frontend_refactor_plan.md`

## Zabronione ścieżki

- `api/**`
- `openapi.yaml`, z wyjątkiem samego odnotowania potrzeb zmian w handoffie.
- Pliki domenowe źródłowe poza `docs/open_questions.md`.

## Protokół dynamicznej aktualizacji planu

Ten plik jest planem żywym. Agent może go aktualizować w trakcie kodowania, ale tylko w kontrolowany sposób:

- Aktualizuj `Status`, `Last updated` i `Change log` po istotnej zmianie zakresu lub wyniku.
- Odhaczaj wykonane zadania dopiero po walidacji.
- Nie usuwaj wcześniejszych ustaleń; dopisuj korekty jako nowe wpisy.
- Jeżeli pojawi się luka w wymaganiach, wpisz ją do `docs/open_questions.md`, a nie implementuj założenia „z głowy”.
- Jeżeli potrzebna jest zmiana architektoniczna, zaproponuj ADR albo aktualizację istniejącego ADR.


## Docelowa struktura

Preferowana struktura:

```text
pwa/src/
  app/
    AppShell.tsx
    routes.tsx
  components/
    ui/
    layout/
    feedback/
  features/
    admin/
    coordinator/
    doctor/
    schedules/
    availability/
    swaps/
    conflicts/
    metrics/
  mocks/
    seedData.ts
  types/
    domain.ts
    api.ts
  utils/
```

Jeżeli projekt używa innej konwencji, agent może ją zachować, ale musi utrzymać separację: `components`, `features`, `types`, `mocks`.

## Typy domenowe do utworzenia

W `pwa/src/types/domain.ts` albo równoważnym miejscu zdefiniuj typy dla MVP:

- `User`, `RoleCode`, `UserRole`
- `Department`, `CoordinatorAssignment`
- `DoctorProfile`, `Qualification`, `DoctorQualification`
- `Schedule`, `ScheduleStatus`
- `Shift`, `ShiftStatus`
- `Assignment`, `AssignmentStatus`, `AssignmentSource`
- `AvailabilityDeclaration`, `AvailabilityDay`, `AvailabilityType`
- `PreferenceCategory`
- `LeaveRequest`, `LeaveRequestStatus`
- `GenerationRun`, `ConflictReport`, `ConflictItem`
- `ConstraintRule`, `ValidationResult`, `ConstraintViolation`
- `SwapRequest`, `SwapCandidate`, `SwapApproval`, `SwapRequestStatus`
- `Notification`
- `CalendarExport`
- `AuditLogEntry`
- `ScheduleMetricsResponse`

Typy powinny być zgodne semantycznie z `domain_model.md` i możliwie zbieżne z nazwami z `openapi.yaml`.

## Zadania

- [ ] (YYYY-MM-DD HH:MMZ) Przeczytaj handoff z fazy 01.
- [ ] (YYYY-MM-DD HH:MMZ) Zidentyfikuj największe komponenty/monolity JSX.
- [ ] (YYYY-MM-DD HH:MMZ) Wydziel layout aplikacji: shell, navigation, header, role switch / mock user context.
- [ ] (YYYY-MM-DD HH:MMZ) Wydziel widok Koordynatora: schedule editor, doctor sidebar, monthly grid, conflicts panel, metrics panel.
- [ ] (YYYY-MM-DD HH:MMZ) Wydziel widok Lekarza: availability submission, my schedule, swap request flow.
- [ ] (YYYY-MM-DD HH:MMZ) Wydziel widok Admina: users, roles, departments, coordinator assignment.
- [ ] (YYYY-MM-DD HH:MMZ) Utwórz typy domenowe.
- [ ] (YYYY-MM-DD HH:MMZ) Przenieś mocki z importu Figma do `pwa/src/mocks/seedData.ts` lub równoważnie.
- [ ] (YYYY-MM-DD HH:MMZ) Usuń dane domenowe bezpośrednio z JSX.
- [ ] (YYYY-MM-DD HH:MMZ) Dodaj podstawowe stany UI: empty, loading placeholder, error placeholder — bez prawdziwego API.
- [ ] (YYYY-MM-DD HH:MMZ) Zweryfikuj, że `Schedule.status` kontroluje dostępne akcje w UI.
- [ ] (YYYY-MM-DD HH:MMZ) Zweryfikuj, że po `PUBLISHED` UI nie pokazuje zwykłej edycji przydziałów poza flow zamiany.
- [ ] (YYYY-MM-DD HH:MMZ) Uruchom build/lint/typecheck.
- [ ] (YYYY-MM-DD HH:MMZ) Uzupełnij handoff dla Mock API Agenta.

## Reguły domenowe, których UI nie może łamać

- Grafik ma status: `DRAFT`, `GENERATED`, `PUBLISHED`, `ARCHIVED`.
- Dyżur jest 24-godzinny.
- Jeden aktywny przydział na dyżur.
- Twarde ograniczenia są blokujące.
- Po publikacji modyfikacja grafiku odbywa się przez `SwapRequest`.
- Zamiana wymaga akceptacji lekarzy i finalnej akceptacji Koordynatora.
- Log audytowy jest append-only.
- Jeden aktywny Koordynator odpowiada za grafik oddziału.

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

Jeżeli skrypt nie istnieje, wpisz to w handoffie. Dodanie skryptu jest dozwolone tylko wtedy, gdy wymagane zależności już istnieją lub jest to mała, uzasadniona zmiana.

## Kryteria akceptacji

- UI zachowuje wygląd i główne flow z Figma.
- Komponenty są rozdzielone i zrozumiałe.
- Typy domenowe istnieją i są używane.
- Mock data nie jest trzymana bezpośrednio w JSX.
- Brak prawdziwych requestów HTTP.
- Build przechodzi.
- `api/` i `openapi.yaml` nie zostały zmienione.

## Ryzyka

- Zbyt agresywny refaktor zmieni wygląd Figma.
- Typy frontendowe rozjadą się z `openapi.yaml`.
- Agent dopisze non-MVP widoki.
- Za wcześnie powstanie klient HTTP zamiast mocków.

## Rollback

- Przywróć `pwa/src` do stanu po fazie 01.
- Cofnij zmiany w `package.json`, jeżeli zależności nie są konieczne.
- Zostaw opis problemów w handoffie.

## Handoff

- Completed:
- Validation:
- Known issues:
- Open questions:
- Recommended next step:
