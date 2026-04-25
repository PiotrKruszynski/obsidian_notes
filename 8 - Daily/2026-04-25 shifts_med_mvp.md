Created: 2026-04-25  16:14
___
Note:


## Etap 1 — pobranie / przeniesienie React z Figma
```
Use Figma MCP Server to inspect the selected Figma Make React prototype.

Target directory:
pwa/src/

Goal:
Bring the generated React UI into this repository.

Rules:
- Do not modify api/ yet.
- Do not invent backend logic.
- Preserve the current visual structure from Figma.
- Create or update React components only inside pwa/src.
- If generated code is too large, split it into components.
- Keep all business data mocked for now.
- After changes, run frontend build/lint commands if available.
```

## Etap 2 — stabilizacja PWA
Po imporcie Reacta z Figma pierwszy agent powinien zrobić refactor, nie backend.
Plan:
`docs/execution/frontend_refactor_plan.md`

## Etap 3 — mock API przed backendem
```
To jest most między Figma UI a backendem.

Tworzysz w `pwa` takie pliki:

pwa/src/services/doctorService.ts  
pwa/src/services/scheduleService.ts  
pwa/src/services/preferenceService.ts  
pwa/src/services/swapRequestService.ts

Na razie zwracają mocki z:

pwa/src/mocks/doctors.mock.ts  
pwa/src/mocks/schedules.mock.ts  
pwa/src/mocks/preferences.mock.ts

Zasada: komponenty React **nie wiedzą**, czy dane są z mocków, czy z backendu. One wołają serwis:

const schedule = await getMonthlySchedule(month);

Później zamienisz wnętrze `getMonthlySchedule()` z mocka na `fetch("/api/schedules/...")`.
```

## Etap 4 — dopasowanie `openapi.yaml`
Masz już `openapi.yaml`, więc nie generowałbym go od zera. Zrób agentowi zadanie:

```
Compare:  
- project_assumptions.md  
- domain_model.md  
- er_diagram.md  
- user_flow.mmd  
- current pwa/src/services/*  
- openapi.yaml  
  
Goal:  
Update openapi.yaml so it matches the frontend service layer and MVP domain.  
  
Rules:  
- Do not add non-MVP features.  
- Do not implement backend.  
- Add missing endpoints only if required by existing frontend flows.  
- Keep request/response schemas explicit.  
- Add open questions to docs/open_questions.md.
```

To jest kluczowe: `openapi.yaml` ma być kontraktem między `pwa` i `api`.

## Etap 5 — backend dopiero teraz
Dopiero gdy masz:
```
pwa działa  
mock services istnieją  
openapi.yaml pasuje do UI  
domain_model.md jest stabilny
```

wtedy dajesz agentowi backend:

```
Implement FastAPI backend in api/ based strictly on openapi.yaml.  
  
Rules:  
- Do not change pwa.  
- Do not change product assumptions.  
- Implement only endpoints defined in openapi.yaml.  
- Use Pydantic schemas.  
- Use existing api project tooling.  
- Add tests for every endpoint.  
- Use SQLite/PostgreSQL depending on existing template.  
- Seed realistic test data.
```

Backend ma spełnić kontrakt, nie wymyślać aplikację.

---

## Etap 6 — integracja frontend/backend

Dopiero ostatni agent:

Replace mock services in pwa/src/services with real API calls to api/.  
  
Rules:  
- Preserve service function names.  
- Add loading states.  
- Add error handling.  
- Keep mocks available for local fallback or tests.  
- Do not rewrite UI components unless required.

Wtedy architektura zostaje czysta:

React components  
→ services  
→ API client  
→ FastAPI endpoints  
→ DB

---

## Jak podzi







___
Metadata:

```yaml
---
type: tool    # concept | tool | pattern
language: python # python | js | sql | etc.
---
```

Status: #pending
Tags: #empty
