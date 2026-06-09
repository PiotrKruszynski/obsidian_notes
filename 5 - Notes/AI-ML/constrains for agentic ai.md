---
title: "constrains for agentic ai"
type: concept
topic: ai-ml
tags: []
created: 2026-06-09
status: draft
---

#ai 

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




