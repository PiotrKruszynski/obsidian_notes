# 01 — Figma Import Plan

Status: Living Draft  
Owner: Figma Import Agent  
Depends on: `master_execution_plan.md`  
Next: `02_frontend_refactor_plan.md`  
Last updated: YYYY-MM-DD HH:MMZ

## Cel

Przenieść albo odtworzyć wybrany React UI z Figma Make do `pwa/src` w sposób kontrolowany, bez implementacji backendu i bez zmiany kontraktu API.

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

Agent ma użyć Figma MCP Server do inspekcji wybranego frame/prototypu Figma Make i utworzyć działający frontendowy punkt startowy w `pwa/src`.

Preferowany początkowy ekran: widok Koordynatora `Schedule Editor`, ponieważ centralizuje cykl grafiku: `DRAFT -> GENERATED -> PUBLISHED -> ARCHIVED`, obsadę 24h dyżurów, konflikty, metryki i publikację.

## Poza zakresem

- Implementacja backendu.
- Modyfikacja `api/`.
- Modyfikacja `openapi.yaml`.
- Tworzenie realnych requestów HTTP.
- Dodawanie nowych funkcji poza MVP.
- Projektowanie finalnego design systemu.
- Refaktor architektury komponentów ponad minimum potrzebne do renderowania UI.

## Dozwolone ścieżki

- `pwa/src/**`
- `pwa/public/**`, tylko jeżeli Figma wymaga assetów.
- `pwa/package.json`, tylko jeżeli brakuje zależności wymaganej do uruchomienia importowanego UI.
- `docs/open_questions.md`, tylko do zapisania braków.
- Ten plan: `docs/execution/01_figma_import_plan.md`.

## Zabronione ścieżki

- `api/**`
- `openapi.yaml`
- `domain_model.md`
- `er_diagram.md`
- `project_assumptions.md` / `project_asumptions.md`
- `user_flow.mmd`

## Preconditions

- Figma MCP Server jest skonfigurowany i widzi wybrany plik/frame.
- Repozytorium ma istniejący projekt frontendowy w `pwa/`.
- Agent zna komendy startowe/buildowe `pwa/` albo potrafi je wykryć z `package.json`.
- Wybrany jest konkretny frame/prototyp. Jeżeli nie, agent zapisuje pytanie w `docs/open_questions.md` i zatrzymuje fazę.

## Protokół dynamicznej aktualizacji planu

Ten plik jest planem żywym. Agent może go aktualizować w trakcie kodowania, ale tylko w kontrolowany sposób:

- Aktualizuj `Status`, `Last updated` i `Change log` po istotnej zmianie zakresu lub wyniku.
- Odhaczaj wykonane zadania dopiero po walidacji.
- Nie usuwaj wcześniejszych ustaleń; dopisuj korekty jako nowe wpisy.
- Jeżeli pojawi się luka w wymaganiach, wpisz ją do `docs/open_questions.md`, a nie implementuj założenia „z głowy”.
- Jeżeli potrzebna jest zmiana architektoniczna, zaproponuj ADR albo aktualizację istniejącego ADR.


## Docelowa struktura po fazie

Minimalnie:

```text
pwa/src/
  App.tsx
  main.tsx
  figma-import/
    FigmaPrototype.tsx
    figmaMockData.ts
    figmaTypes.ts
    assets/              # tylko jeśli potrzebne
```

Jeżeli istniejąca struktura `pwa/src` jest już inna, agent ma ją uszanować i wprowadzić import bez destrukcyjnego przepisywania projektu.

## Zadania

- [ ] (YYYY-MM-DD HH:MMZ) Zweryfikuj dostęp do Figma MCP Server i wybranego frame/prototypu.
- [ ] (YYYY-MM-DD HH:MMZ) Zidentyfikuj nazwę pliku Figma, stronę, frame i kluczowe widoki do importu.
- [ ] (YYYY-MM-DD HH:MMZ) Zapisz krótką notatkę w tym planie: które widoki z Figma zostały użyte.
- [ ] (YYYY-MM-DD HH:MMZ) Sprawdź strukturę `pwa/`, `package.json`, lockfile i istniejące skrypty.
- [ ] (YYYY-MM-DD HH:MMZ) Przenieś albo odtwórz React UI z Figma Make w `pwa/src/figma-import/`.
- [ ] (YYYY-MM-DD HH:MMZ) Podłącz `FigmaPrototype` do aktualnego entrypointu aplikacji bez usuwania istniejących plików, chyba że są ewidentnie puste.
- [ ] (YYYY-MM-DD HH:MMZ) Zastąp dane inline minimalnymi lokalnymi mockami w `figmaMockData.ts`.
- [ ] (YYYY-MM-DD HH:MMZ) Upewnij się, że mocki reprezentują MVP: role `ADMIN`, `COORDINATOR`, `DOCTOR`, grafik, dyżury 24h, lekarzy, konflikty, zamiany.
- [ ] (YYYY-MM-DD HH:MMZ) Zachowaj wizualną strukturę Figma; nie optymalizuj jeszcze komponentów pod finalną architekturę.
- [ ] (YYYY-MM-DD HH:MMZ) Usuń albo skomentuj elementy wygenerowane przez Figma, które są sprzeczne z MVP.
- [ ] (YYYY-MM-DD HH:MMZ) Uruchom walidację frontendową.
- [ ] (YYYY-MM-DD HH:MMZ) Uzupełnij sekcję `Handoff`.

## Minimalne dane mockowe dla importu

Mocki powinny zawierać przynajmniej:

- jeden oddział;
- jednego Koordynatora;
- kilku Lekarzy z kwalifikacjami;
- jeden grafik miesięczny;
- listę `Shift` dla 24h dyżurów;
- kilka `Assignment`;
- status grafiku;
- przykładowe konflikty;
- przykładowe metryki;
- jeden przykładowy `SwapRequest`.

Nie twórz jeszcze warstwy `services/`; to jest zakres fazy 03.

## Wykrywanie komend walidacyjnych

Przed uruchamianiem walidacji agent powinien sprawdzić faktyczne narzędzia projektu:

```bash
ls
find . -maxdepth 3 -name package.json -o -name pyproject.toml -o -name uv.lock -o -name pnpm-lock.yaml -o -name package-lock.json -o -name yarn.lock
```

Dla `pwa/` użyj menedżera pakietów wynikającego z lockfile. Dla `api/` użyj istniejącego toolingu, w szczególności `uv`, `ruff`, `pytest`, `coverage`, jeżeli są skonfigurowane.


## Komendy walidacyjne

Przykładowe komendy, dostosować do faktycznego lockfile:

```bash
cd pwa
npm install
npm run build
npm run lint
npm run typecheck
```

Jeżeli `lint` albo `typecheck` nie istnieją, agent zapisuje to w handoffie. Nie dodaje nowych narzędzi bez potrzeby.

## Kryteria akceptacji

- UI z wybranego Figma Make frame renderuje się w `pwa`.
- `api/` i `openapi.yaml` nie zostały zmienione.
- Dane są lokalne i mockowane.
- Build frontendu przechodzi albo defekty są jasno opisane.
- Nie dodano wymagań poza MVP.
- Handoff zawiera wskazówki dla Frontend Developer Agenta.

## Ryzyka

- Figma MCP nie widzi właściwego frame.
- Figma Make generuje zbyt duży monolit `App.tsx`.
- Kod z Figma zawiera zależności nieobecne w projekcie.
- Wizualny prototyp zawiera flow spoza MVP.
- Assety z Figma nie są dostępne lokalnie.

## Rollback

- Przywróć zmienione pliki `pwa/src/**` z ostatniego commita.
- Usuń katalog `pwa/src/figma-import/`, jeżeli import jest nieużywalny.
- Cofnij zmiany w `pwa/package.json`, jeżeli dodane zależności nie są konieczne.

## Handoff

- Completed:
- Validation:
- Known issues:
- Open questions:
- Recommended next step:
