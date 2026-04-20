1. Idea
	1. flowchart
	2. class diagram
2. init template
3. start

### 1. Start
github -> new respository
`git remote add origin <SSH>`


initialize a project in the working directory:
```
mkdir hello-world
cd hello-world
uv init
```

### 2. GitHub (Inicjalizacja Repozytorium)

Teraz czas na połączenie ze światem.

1. Wejdź na GitHub i stwórz **New Repository**.
    
2. **Nazwa:** taka sama jak folderu (`moj-projekt`).
    
3. **Ważne:** Nie dodawaj README ani `.gitignore` przez stronę (bo `uv init` już stworzył te pliki lokalnie).
    
4. Skopiuj adres URL repozytorium (np. `[https://github.com/user/moj-projekt.git](https://github.com/user/moj-projekt.git)`).

### 3. Push
Wróć do terminala wewnątrz folderu projektu:

Bash

```
git init
git add .
git commit -m "Initial commit from uv"
git branch -M main
git remote add origin https://github.com/twoj-user/moj-projekt.git
git push -u origin main
```

### 4. Konfiguracja "Template" (Twój Szablon)

Zamiast za każdym razem wpisywać biblioteki z palca, otwórz plik `pyproject.toml` i wklej swój ulubiony zestaw startowy.

**Przykład uniwersalnego szablonu `pyproject.toml`:**

Ini, TOML

```
[project]
name = "moj-projekt"
version = "0.1.0"
description = "Opis projektu"
readme = "README.md"
requires-python = ">=3.12"
dependencies = [
    "requests",
    "pydantic",
    "python-dotenv", # Do zarządzania kluczami API w .env
]

[tool.uv]
dev-dependencies = [
    "pytest",
    "ruff",   # Szybki linter i formatter
    "mypy",   # Sprawdzanie typów
]

[tool.ruff]
line-length = 88
# Tutaj możesz dodać własne reguły lintera
```

### 5. Finalizacja: `uv sync`

Gdy już uzupełnisz plik `.toml` o to, czego potrzebujesz:

Bash

```
# To stworzy .venv, pobierze paczki i wygeneruje uv.lock
uv sync
```

---


[writing your pyproject.toml](https://packaging.python.org/en/latest/guides/writing-pyproject-toml/)

