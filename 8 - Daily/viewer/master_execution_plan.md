# Master Execution Plan — SHIFTS_MVP

Status: Living Draft  
Owner: Planning & Orchestration Agent  
Last updated: YYYY-MM-DD HH:MMZ

## Cel

Skoordynować pracę rodziny agentów nad MVP systemu do planowania 24-godzinnych dyżurów lekarskich. Ten dokument jest krótki i koordynacyjny; szczegóły wykonawcze znajdują się w planach fazowych `01`–`07`.

## Źródła prawdy

1. `project_assumptions.md` / `project_asumptions.md` — zakres MVP, role, ograniczenia, polityka zamian.
2. `domain_model.md` — encje i decyzje domenowe.
3. `er_diagram.md` — relacje danych.
4. `user_flow.mmd` — workflow end-to-end.
5. `openapi.yaml` — kontrakt API.

## Kolejność faz

| Faza | Plan | Agent | Cel | Warunek przejścia |
|---|---|---|---|---|
| 1 | `01_figma_import_plan.md` | Figma Import Agent | Przenieść UI z Figma Make do `pwa/src` bez backendu. | `pwa` renderuje wybrany UI i przechodzi build. |
| 2 | `02_frontend_refactor_plan.md` | Frontend Developer Agent | Uporządkować React, typy domenowe i strukturę feature. | Komponenty są rozdzielone, dane nie siedzą w JSX. |
| 3 | `03_mock_api_plan.md` | Mock API Agent | Utworzyć asynchroniczną warstwę usług i mocki. | UI działa przez services, nie przez inline data. |
| 4 | `04_openapi_alignment_plan.md` | Contract Agent | Dopasować `openapi.yaml` do MVP i usług frontendu. | Endpointy, payloady i typy są spójne. |
| 5 | `05_backend_implementation_plan.md` | Backend Developer Agent | Zaimplementować FastAPI według `openapi.yaml`. | Testy API przechodzą, endpointy istnieją. |
| 6 | `06_frontend_backend_integration_plan.md` | Integration Agent | Podmienić mock services na realne API. | Krytyczne flow działa przez backend. |
| 7 | `07_quality_release_plan.md` | QA Agent | Zweryfikować MVP przez testy, Playwright i Lighthouse. | Raport jakości bez blokujących defektów. |

## Globalne reguły

- Nie wymyślaj nowych wymagań produktowych.
- Nie modyfikuj plików poza zakresem przypisanej fazy.
- Nie implementuj backendu przed mock services i alignmentem OpenAPI.
- Figma import nie może modyfikować `api/`.
- Backend agent nie może przepisywać `pwa/`.
- `Schedule.status` jest strażnikiem akcji: `DRAFT`, `GENERATED`, `PUBLISHED`, `ARCHIVED`.
- Dyżur ma stałą długość 24h i dokładnie jednego aktywnego lekarza, jeżeli jest obsadzony.
- Twarde ograniczenia prawne nie mogą być zatwierdzane jako naruszone.
- Opublikowany grafik jest niemodyfikowalny poza procedurą zamiany.
- Log audytowy jest append-only.
- Braki i niejasności zapisuj w `docs/open_questions.md`.

## Handoff

Każdy agent kończy fazę wpisem:

```md
## Handoff
- Completed:
- Validation:
- Known issues:
- Open questions:
- Recommended next step:
```

Następny agent zaczyna od przeczytania handoffu poprzedniej fazy oraz sprawdzenia, czy warunki wejściowe są spełnione.

## Stop conditions

Agent musi przerwać pracę, jeżeli:

- nie ma dostępu do wymaganego źródła Figma w fazie 1;
- lokalny stan repozytorium odbiega od planu tak bardzo, że wymaga zmiany zakresu;
- wymaganie jest sprzeczne z `project_assumptions.md` lub `domain_model.md`;
- zmiana wymaga decyzji architektonicznej bez ADR;
- walidacja nie przechodzi i defekt nie mieści się w zakresie bieżącej fazy.

## Change log

| Timestamp UTC | Agent | Zmiana |
|---|---|---|
| YYYY-MM-DD HH:MMZ | Planning & Orchestration Agent | Initial plan. |
