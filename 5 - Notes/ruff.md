Created: 2025-12-17  00:36
___
Note:

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


___
Metadata:

```yaml
---
type: tool    # concept | tool | pattern
language: python # python | js | sql | etc.
level: beginner  # beginner | intermediate | advanced
status: understood    # draft | understood
---
```

Status: #pending
Tags:  #python #ruff #linting #formatter #code-quality #static-analysis
