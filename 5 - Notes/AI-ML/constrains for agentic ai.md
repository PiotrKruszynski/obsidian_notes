---
title: "constrains for agentic ai"
type: concept
topic: ai-ml
tags: ["ai"]
created: 2026-06-09
status: draft
sr_due: 2026-07-03
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

##### Constraints dla projektu Agentic AI
- krótkie pliki
- każda fn/obj musi miec docstring
- `type` wszędzie
- tests , coverage 100% <- regresja
- `pre-commit ` ostatnia linia obrony, obowiązkowo

| **Kategoria** | **Python**     | **JavaScript / TypeScript** | **Go (w infra)**       |
| ------------- | -------------- | --------------------------- | ---------------------- |
| Linter        | ruff           | eslint                      | golangci-lint          |
| Formatter     | ruff format    | prettier                    | gofmt / goimports      |
| Types         | mypy / pyright | typescript (tsc)            | wbudowany system typów |
| Tests         | pytest         | vitest / jest               | go test                |
| Logs          | logging        | pino / winston              | log / zap              |
| Docs          | sphinx         | typedoc / docusaurus        | godoc                  |
| Build/dev     | poetry / uv    | vite                        | go build               |
| Coverage      | pytest-cov     | c8 / vitest coverage        | go test -cover         |
