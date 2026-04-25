# 06 — Frontend–Backend Integration Plan

Status: Living Draft  
Owner: Integration Agent  
Depends on: `05_backend_implementation_plan.md`  
Next: `07_quality_release_plan.md`  
Last updated: YYYY-MM-DD HH:MMZ

## Cel

Podmienić frontendowe mock services na realne wywołania backendu FastAPI przy zachowaniu nazw funkcji serwisowych i struktury komponentów. Integracja ma potwierdzić, że MVP działa end-to-end.

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

- Konfiguracja base URL API.
- Klient HTTP w `pwa`.
- Obsługa auth tokenów dla lokalnego MVP.
- Podmiana implementacji `services` z mocków na `fetch`/HTTP client.
- Zachowanie mocków jako tryb testowy/dev fallback, jeżeli to nie komplikuje architektury.
- Loading/error states w UI.
- CORS/proxy config, jeżeli potrzebne.
- Integracyjne testy krytycznych flow.

## Poza zakresem

- Przepisywanie backendu.
- Przepisywanie UI od zera.
- Zmiana `openapi.yaml`, chyba że wykryty błąd blokuje integrację; wtedy zatrzymaj i zgłoś do fazy 04/05.
- Dodawanie non-MVP funkcji.
- Produkcyjne SSO, płatności, HR, P1.

## Dozwolone ścieżki

- `pwa/src/services/**`
- `pwa/src/api/**` lub równoważny katalog klienta HTTP.
- `pwa/src/features/**`, tylko dla loading/error i integracji.
- `pwa/.env.example`, `pwa/vite.config.*`, jeśli potrzebne.
- `api/src/**`, tylko minimalne CORS/config fixes, jeśli backend działa inaczej niż lokalna integracja wymaga.
- `docs/open_questions.md`
- `docs/execution/06_frontend_backend_integration_plan.md`

## Zabronione ścieżki

- Duże zmiany w `api/` bez powrotu do Backend Developer Agenta.
- Duże zmiany w UI bez powrotu do Frontend Developer Agenta.
- Nieuzgodnione zmiany `openapi.yaml`.

## Protokół dynamicznej aktualizacji planu

Ten plik jest planem żywym. Agent może go aktualizować w trakcie kodowania, ale tylko w kontrolowany sposób:

- Aktualizuj `Status`, `Last updated` i `Change log` po istotnej zmianie zakresu lub wyniku.
- Odhaczaj wykonane zadania dopiero po walidacji.
- Nie usuwaj wcześniejszych ustaleń; dopisuj korekty jako nowe wpisy.
- Jeżeli pojawi się luka w wymaganiach, wpisz ją do `docs/open_questions.md`, a nie implementuj założenia „z głowy”.
- Jeżeli potrzebna jest zmiana architektoniczna, zaproponuj ADR albo aktualizację istniejącego ADR.


## Docelowy przepływ danych

```text
React components
  -> pwa/src/services/*
  -> pwa/src/api/httpClient.ts
  -> FastAPI endpoints
  -> persistence / seed data
```

Komponenty nie powinny bezpośrednio używać `fetch`.

## Zadania

- [ ] (YYYY-MM-DD HH:MMZ) Przeczytaj handoff z fazy 05: base URL, auth, seed users, known limitations.
- [ ] (YYYY-MM-DD HH:MMZ) Uruchom backend lokalnie.
- [ ] (YYYY-MM-DD HH:MMZ) Uruchom frontend lokalnie.
- [ ] (YYYY-MM-DD HH:MMZ) Dodaj `pwa/.env.example` z `VITE_API_BASE_URL`.
- [ ] (YYYY-MM-DD HH:MMZ) Utwórz `httpClient` z obsługą base URL, JSON, bearer token, błędów i timeoutów.
- [ ] (YYYY-MM-DD HH:MMZ) Zachowaj dotychczasowe nazwy funkcji w `services`.
- [ ] (YYYY-MM-DD HH:MMZ) Podmień `authService` na realne endpointy.
- [ ] (YYYY-MM-DD HH:MMZ) Podmień services dla users/departments/doctors.
- [ ] (YYYY-MM-DD HH:MMZ) Podmień services dla schedules, participants, shifts, assignments.
- [ ] (YYYY-MM-DD HH:MMZ) Podmień services dla availability i leave requests.
- [ ] (YYYY-MM-DD HH:MMZ) Podmień services dla generation, validation i conflict report.
- [ ] (YYYY-MM-DD HH:MMZ) Podmień services dla swap flow.
- [ ] (YYYY-MM-DD HH:MMZ) Podmień services dla metrics, notifications, calendar exports, audit log.
- [ ] (YYYY-MM-DD HH:MMZ) Dodaj loading/error handling tam, gdzie wcześniej mocki były synchronicznie stabilne.
- [ ] (YYYY-MM-DD HH:MMZ) Zweryfikuj CORS lub Vite proxy.
- [ ] (YYYY-MM-DD HH:MMZ) Przejdź ręcznie flow krytyczne.
- [ ] (YYYY-MM-DD HH:MMZ) Uruchom walidacje frontend/backend.
- [ ] (YYYY-MM-DD HH:MMZ) Uzupełnij handoff dla QA Agenta.

## Krytyczne flow do sprawdzenia ręcznie

- Admin widzi użytkowników/oddziały i role.
- Koordynator tworzy grafik.
- Lekarz składa dostępność.
- Koordynator uruchamia generowanie grafiku.
- System pokazuje `ConflictReport`, jeżeli obsada jest niemożliwa.
- Koordynator publikuje poprawny grafik.
- Lekarz widzi swój opublikowany grafik.
- Lekarz tworzy wniosek o zamianę.
- Drugi lekarz odpowiada na zamianę.
- System waliduje zamianę.
- Koordynator zatwierdza zamianę.
- Audit log pokazuje operacje.

## Wykrywanie komend walidacyjnych

Przed uruchamianiem walidacji agent powinien sprawdzić faktyczne narzędzia projektu:

```bash
ls
find . -maxdepth 3 -name package.json -o -name pyproject.toml -o -name uv.lock -o -name pnpm-lock.yaml -o -name package-lock.json -o -name yarn.lock
```

Dla `pwa/` użyj menedżera pakietów wynikającego z lockfile. Dla `api/` użyj istniejącego toolingu, w szczególności `uv`, `ruff`, `pytest`, `coverage`, jeżeli są skonfigurowane.


## Komendy walidacyjne

Backend:

```bash
cd api
uv run ruff check .
uv run pytest
```

Frontend:

```bash
cd pwa
npm run build
npm run lint
npm run typecheck
npm run test
```

E2E, jeśli Playwright jest dostępny:

```bash
cd pwa
npx playwright test
```

## Kryteria akceptacji

- Frontend korzysta z backendu dla krytycznych flow.
- Mock services nie są domyślną ścieżką produkcyjną.
- Komponenty nie używają bezpośrednio `fetch`.
- Loading i error states są widoczne.
- Backend i frontend przechodzą testy.
- Znane ograniczenia są opisane w handoffie.

## Ryzyka

- Backend payloads różnią się od typów frontendowych.
- Auth i role utrudniają lokalne testy.
- UI założyło dane dostępne natychmiast z mocków.
- CORS/proxy blokuje integrację.
- OpenAPI wymaga korekty.

## Rollback

- Przywróć mock implementation jako fallback.
- Cofnij tylko implementacje services, nie komponenty.
- Jeżeli problem jest kontraktowy, wróć do fazy 04.
- Jeżeli problem jest backendowy, wróć do fazy 05.

## Handoff

- Completed:
- Validation:
- Integrated flows:
- Failing flows:
- Known issues:
- Open questions:
- Recommended next step:
