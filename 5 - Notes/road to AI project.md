#ai 

research - business / ux / technical

`projects_assumptions.md` - single source of truth
```
## Roles  
## Core Workflow  
## Domain Concepts  
## Hard Constraints  
## Soft Constraints  
## Schedule Lifecycle (statusy)  
## MVP Scope
```

na jego podstawie równolegle:
- user flow (Mermaid)
- domain model (lista encji)
- ui_spec (interfejs dla Figma)

dopiero potem:
- ER diagram (z domain)
- OpenAPI (z UI + flow)

Narzędzia:
Figma Make narzędzie do **projektowania interfejsów** (UI/UX)



# POC
## 1
Potrzebuję stworzyć aplikację ___ułatwiającą zarządzanie dyżurami dla lekarzy___. Przeanalizuj najlepsze aplikacje tego typu na rynku. Zwróć mi porównania, jakie funkcjonalności mają znaczenie.
- nie wnikam technicznie
- research -> kradnę z enterprice

#### zaobserwowane problemy:
Za szeroko, za dużo wszystkiego -> dużo zależności jak w korpo, których nie potrzebuje 
Po uszczegółowieniu zakresu strona miała mniej niepotrzebnych elementów, ale UI nie wyglądał już tak sprytnie

## 2
Na podstawie reaserch stwórz execution_plan.md, który poinstruuje moich agentów krok po kroku co mają zrobić, aby wygenerować POC dla tej aplikacji. Potrzebuje tylko działający frontend, najnowsze technologie, react + tailwind + vite.

```
---

Track your progress using checkboxes with timestamps (UTC). Example:

- [ ] (YYYY-MM-DD HH:MMZ) Create types and services for OCR extraction and sensitive classification.
- [ ] (YYYY-MM-DD HH:MMZ) Integrate `useOCR` with CRAFT and CRNN models; verify bounding boxes.
- [ ] (YYYY-MM-DD HH:MMZ) Implement text embedding and classification service using `useTextEmbeddings` or `useLLM`.
- [ ] (YYYY-MM-DD HH:MMZ) Display candidate list with pending/accept/reject UI.
- [ ] (YYYY-MM-DD HH:MMZ) Implement `<sensitive>` replacement in sanitized text.
- [ ] (YYYY-MM-DD HH:MMZ) Map accepted tokens to blur regions and render overlays on image.
- [ ] (YYYY-MM-DD HH:MMZ) Persist user decisions for offline fine-tuning; implement stub for RL loop.
- [ ] (YYYY-MM-DD HH:MMZ) Validate pipeline end-to-end on a sample document.

Update these tasks as you work through them. Use the _Surprises & Discoveries_ section to capture unexpected findings or challenges.

```

- załączam `template execution_plan.md`
#### zaobserwowane problemy:

## 4 Praca z Virtual Studio Code Insiders
`execution_plan.md` przekazuje do VS Code Insiders - (narzędzie do tworzenia i zarządzania agentami)
`wykonaj execution plan`
`odpal bo chce zobaczyć`
`strona jest brzydka jak noc, użyj design.md i zrób najpiękniejszą na świecie, ux enterprice, ascetyczne teksty, usuń wszystko co nie potrzebne w UI`


# MVP
## 1 Inicjalizacja projektu
- tworze foldery `API`, `PWA`
`wygeneruj mi proste readme.md do nowej aplikacji, frontend react, backend fastapi`
`git init`
`git remote add origin <SSH>`
`git push`
- środowisko (templatki) generuje ręcznie.
`dodaje templatki: lintter, formatter, type, test, docs, logs, precommit`
- w enterprice nie da się jedną komendą wygenerować aplikacji. -> trzeba iteracyjnie
`za pomocą uv stwórz nowego enva w folderze API, python 3.14 odpal, sprawdź czy działa i skommituj`

[[constrains for agentic ai]]

`zainstaluj precommit w API`
`wgraj na github`

## 2 execution_plan.md 
`napisz execution plany dla mojej rodziny agentów, agenta do planowania i orchestracji, który będzie zlecał wykonanie zadań do subagentów, jeden frontend developer, backend developer, ux designer który wybada dobry ux, QA aby weryfikował czy wszystko jest poprawnie używając lighthouse i playwright. Każdy agent ma sobie pracować na swoim branch (użyj worktree). Tworzymy tulko to co jest na obrazku, front react, backend fastapi, baza sqlite `

#### uwagi
sqlite bo nie che narazie wprowadzać Docker

## 3 Codex tworzy agentów
- execution_plan.md
`przeanalizuj dokładnie execution_plan i stwórz sobie subagentów do wykonania całej pracy`
- ard.md 
Architectural Decision Record opisuje w jaki sposób podejmować decyzje


