Created: 2025-12-1523:19
___
Note:
Jedno narzędzie, które zastępuje kilka klasycznych:

- pip
- pip-tools (pip-compile)
- virtualenv
- częściowo poetry / pipenv

Jest napisane w **Rust**, dlatego działa **bardzo szybko**.
### **Do czego służy**

- tworzenie i zarządzanie **virtualenv**
- instalowanie pakietów (pip install)
- generowanie lockfile (powtarzalne buildy)
- zarządzanie wersjami Pythona
- uruchamianie narzędzi w izolowanym środowisku 

### **Najważniejsze cechy**

- **10–100× szybsze** niż pip
- jeden binarny plik (łatwa instalacja)
- deterministyczne zależności (lockfile)
- pełna zgodność z PyPI i PEP
- bardzo dobrze nadaje się do **Dockerów i CI**

**Commands**

```bash
# uv & uvx — Python cheat-sheet

## uv — środowiska, Python, zależności

### Python
uv python list
uv python install 3.12
uv python pin 3.12

### Virtualenv
uv venv
uv venv --python 3.12
source .venv/bin/activate

### Pakiety (zamiennik pip)
uv pip install requests
uv pip install django pytest ruff
uv pip install -r requirements.txt
uv pip uninstall requests
uv pip list
uv pip freeze
uv pip install --upgrade requests

### Lockfile / deterministyczne zależności
uv pip compile pyproject.toml -o uv.lock
uv pip compile requirements.in -o requirements.txt
uv pip sync uv.lock

### Uruchamianie poleceń w venv
uv run python main.py
uv run pytest
uv run django-admin startproject app

### Aktualizacje
uv self update

---

## uvx — jednorazowe narzędzia CLI (jak pipx)

### Uruchamianie narzędzi
uvx black .
uvx ruff check .
uvx mypy src/
uvx pytest

### Konkretna wersja pakietu
uvx black==24.4.2 .

### Przekazywanie argumentów
uvx django-admin startproject mysite
uvx httpx https://example.com

### Konkretna wersja Pythona
uvx --python 3.12 black .

---

## Typowe workflow

### Nowy projekt
uv python install 3.12
uv python pin 3.12
uv venv
uv pip install django pytest ruff

### CI / Docker
uv pip sync uv.lock
uv run pytest

### Jednorazowe narzędzie
uvx ruff check .
uvx black .

---

## TL;DR
uv  → Python, venv, zależności, lockfile  
uvx → jednorazowe narzędzia CLI z PyPI


```


___
Metadata:

Status: #pending
Tags: #empty
