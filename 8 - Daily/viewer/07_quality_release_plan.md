# 07 — Quality & Release Plan

Status: Living Draft  
Owner: QA Agent  
Depends on: `06_frontend_backend_integration_plan.md`  
Next: release decision / next iteration  
Last updated: YYYY-MM-DD HH:MMZ

## Cel

Zweryfikować MVP technicznie i produktowo przed wydaniem iteracji: testy backendu, testy frontendu, Playwright dla flow end-to-end, Lighthouse dla PWA i jakości UI oraz raport defektów.

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

- Testy backendowe.
- Testy frontendowe.
- Playwright E2E dla krytycznych flow.
- Lighthouse dla PWA / performance / accessibility / best practices.
- Podstawowa kontrola dostępności i responsywności.
- Raport jakości i lista defektów.
- Małe naprawy testów lub konfiguracji, jeżeli są jednoznaczne i mieszczą się w QA scope.

## Poza zakresem

- Dodawanie nowych funkcji.
- Przepisywanie UI lub backendu.
- Zmiana domeny lub kontraktu bez powrotu do właściwej fazy.
- Akceptowanie naruszeń twardych reguł jako „znanych ograniczeń”.
- Produkcyjny hardening NIS2/RODO poza oceną ryzyk MVP.

## Dozwolone ścieżki

- `pwa/tests/**`, `pwa/e2e/**` albo istniejący katalog testów.
- `api/tests/**`
- `docs/reports/quality_report.md`
- `docs/reports/defect_log.md`
- `docs/open_questions.md`
- Minimalne zmiany w kodzie tylko dla jednoznacznych napraw testowych.
- `docs/execution/07_quality_release_plan.md`

## Zabronione ścieżki

- Duże zmiany w `pwa/src/**`.
- Duże zmiany w `api/src/**`.
- `openapi.yaml`, chyba że QA tworzy raport błędu kontraktu, nie poprawkę.
- Zmiana assumptions/domain bez decyzji.

## Protokół dynamicznej aktualizacji planu

Ten plik jest planem żywym. Agent może go aktualizować w trakcie kodowania, ale tylko w kontrolowany sposób:

- Aktualizuj `Status`, `Last updated` i `Change log` po istotnej zmianie zakresu lub wyniku.
- Odhaczaj wykonane zadania dopiero po walidacji.
- Nie usuwaj wcześniejszych ustaleń; dopisuj korekty jako nowe wpisy.
- Jeżeli pojawi się luka w wymaganiach, wpisz ją do `docs/open_questions.md`, a nie implementuj założenia „z głowy”.
- Jeżeli potrzebna jest zmiana architektoniczna, zaproponuj ADR albo aktualizację istniejącego ADR.


## Krytyczne flow E2E

1. Admin zarządza użytkownikami i przypisuje Koordynatora do oddziału.
2. Koordynator tworzy nowy grafik miesięczny.
3. Lekarz składa dostępność, preferencje kategorii I–III i wniosek urlopowy.
4. System blokuje edycję availability po deadline.
5. Koordynator generuje grafik.
6. System pokazuje konflikt przy niemożliwej obsadzie.
7. Koordynator koryguje grafik bez naruszenia twardych reguł.
8. Koordynator publikuje grafik.
9. Lekarz widzi swój opublikowany grafik.
10. Lekarz inicjuje swap po publikacji.
11. Drugi lekarz akceptuje albo odrzuca swap.
12. System waliduje swap względem twardych reguł.
13. Koordynator zatwierdza zgodny swap.
14. System aktualizuje assignments i zapisuje audit log.
15. Koordynator archiwizuje grafik po zakończeniu okresu.

## Kontrole domenowe QA

- `PUBLISHED` schedule nie pozwala na zwykłą edycję assignmentów.
- Swap nie jest możliwy przed publikacją.
- Swap nie może być zatwierdzony przy twardym naruszeniu.
- Shift jest 24h.
- Każdy shift ma maksymalnie jeden aktywny assignment.
- `AssignmentSource` przy zamianie to `SWAP`.
- Stary assignment po zatwierdzonej zamianie ma status `REPLACED`.
- Audit log zawiera wpisy dla generowania, publikacji i swap approval.
- Conflict report ma konkretne reason codes i shift context.
- Lekarz nie widzi pełnych danych innych lekarzy poza wymaganym zakresem flow.

## Zadania

- [ ] (YYYY-MM-DD HH:MMZ) Przeczytaj handoff z fazy 06.
- [ ] (YYYY-MM-DD HH:MMZ) Uruchom pełny test suite backendu.
- [ ] (YYYY-MM-DD HH:MMZ) Uruchom pełny test suite frontendu.
- [ ] (YYYY-MM-DD HH:MMZ) Utwórz albo uzupełnij testy Playwright dla krytycznych flow.
- [ ] (YYYY-MM-DD HH:MMZ) Uruchom Playwright lokalnie.
- [ ] (YYYY-MM-DD HH:MMZ) Uruchom Lighthouse na widokach Koordynatora i Lekarza.
- [ ] (YYYY-MM-DD HH:MMZ) Sprawdź podstawową dostępność: keyboard navigation, labels, contrast, focus states, landmarks.
- [ ] (YYYY-MM-DD HH:MMZ) Sprawdź responsive layout: desktop-first dla Koordynatora, mobile-first dla Lekarza.
- [ ] (YYYY-MM-DD HH:MMZ) Zweryfikuj zgodność flow z `user_flow.mmd`.
- [ ] (YYYY-MM-DD HH:MMZ) Zweryfikuj zgodność encji i statusów z `domain_model.md`.
- [ ] (YYYY-MM-DD HH:MMZ) Utwórz `docs/reports/defect_log.md`.
- [ ] (YYYY-MM-DD HH:MMZ) Utwórz `docs/reports/quality_report.md`.
- [ ] (YYYY-MM-DD HH:MMZ) Oznacz defekty blokujące, wysokie, średnie i niskie.
- [ ] (YYYY-MM-DD HH:MMZ) Wpisz decyzję release: `GO`, `GO WITH KNOWN ISSUES`, albo `NO-GO`.
- [ ] (YYYY-MM-DD HH:MMZ) Uzupełnij finalny handoff.

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
uv run coverage run -m pytest
uv run coverage report
```

Frontend:

```bash
cd pwa
npm run build
npm run lint
npm run typecheck
npm run test
```

Playwright:

```bash
cd pwa
npx playwright test
npx playwright show-report
```

Lighthouse, przykładowo:

```bash
cd pwa
npm run build
npm run preview
npx lighthouse http://localhost:4173 --view
```

Jeżeli port albo preview script są inne, użyj faktycznej konfiguracji projektu.

## Progi jakości

Proponowane progi dla MVP, nie production hardening:

- Backend tests: 100% pass.
- Frontend build/typecheck: 100% pass.
- Playwright critical flows: 100% pass.
- Lighthouse:
  - Performance: target >= 80
  - Accessibility: target >= 90
  - Best Practices: target >= 90
  - PWA: brak blokujących problemów
- Brak defektów blokujących w flow: generate, publish, swap approval, audit log.

## Format defect log

```md
# Defect Log

| ID | Severity | Area | Summary | Repro steps | Expected | Actual | Owner phase |
|---|---|---|---|---|---|---|---|
```

## Format quality report

```md
# Quality Report

## Summary
Release decision: GO / GO WITH KNOWN ISSUES / NO-GO

## Validation results
- Backend:
- Frontend:
- Playwright:
- Lighthouse:

## Critical flows
## Defects
## Risks
## Recommended next iteration
```

## Kryteria akceptacji

- Powstał raport jakości.
- Powstał defect log.
- Wszystkie krytyczne flow są zweryfikowane.
- Lighthouse i Playwright zostały uruchomione albo brak narzędzi jest jasno opisany.
- Release decision jest jawna.
- Defekty mają przypisaną fazę właścicielską.

## Ryzyka

- QA naprawia zbyt dużo zamiast raportować.
- Lighthouse wyniki są niestabilne lokalnie.
- Playwright wymaga seed reset między testami.
- Testy E2E zależą od kolejności i stanu aplikacji.
- Brak jasnych danych testowych dla różnych ról.

## Rollback

- Jeżeli testy E2E uszkodziły stan danych, zresetuj seed/backend DB.
- Cofnij niezamierzone zmiany kodu.
- Zachowaj raporty nawet przy `NO-GO`.

## Handoff

- Completed:
- Validation:
- Release decision:
- Blocking defects:
- Known issues:
- Open questions:
- Recommended next step:
