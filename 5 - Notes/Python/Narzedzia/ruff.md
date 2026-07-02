---
title: "ruff"
type: tool
topic: python
tags: ["linting", "python"]
created: 2026-06-09
status: draft
sr_due: 2026-07-14
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

https://docs.astral.sh/ruff/

narzędzie do **statycznej analizy kodu** (linting) oraz **formatowania** Pythona. Jego główna przewaga to:

- **ekstremalna szybkość** (Rust),
- **jeden config** zamiast wielu narzędzi,
- **kompatybilność z ekosystemem flake8** (reguły, kody błędów).

  

Można go traktować jako:
`_flake8 + isort + pyupgrade + autoflake + (częściowo) pylint_ w jednym`

### **Podstawowe możliwości**

- wykrywanie błędów logicznych i stylistycznych
- usuwanie nieużywanych importów i zmiennych
- sortowanie importów (jak isort)
- automatyczne poprawki (--fix)
- formatter (alternatywa dla black, coraz częściej używana razem lub zamiast)

**instalacja**
```bash
uv add ruff --dev
# albo
pip install ruff
```

**podstawowe użycie**

```bash
ruff check . # uruchamia linting (styl, importy, błędy logiczne)
ruff check . --fix # poprawia to co bezpieczne automatycznie
ruff format . # formatuje wcięcia, długość linii, cudzysłowy , podobnie do black
```

👉 **Lint** = poprawność + jakość + bezpieczeństwo (nieużywane importy, zmienne, składnia, PEP8)
👉 **Format** = zmiana wyglądu, bez zmiany znaczenia (wcięcia, długości linii, spacje, jednolity styl (black))

**pyproject.toml**

```toml
[tool.ruff]  
include = ["pyproject.toml", "src/project_template/**/*.py"]  
line-length = 120  
  
[tool.ruff.format]  
exclude = ["docs"]  
quote-style = "single"  
indent-style ="tab"  
docstring-code-format = true  
docstring-code-line-length = 50
```
