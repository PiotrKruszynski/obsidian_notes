Created: 2026-01-04  16:58
___
Note:

Pythonowy moduł **logging** to **standardowy, produkcyjny mechanizm obserwowalności** aplikacji.  
Zapewnia:

- kontrolę przepływu informacji
    
- diagnostykę błędów
    
- audyt zdarzeń
    
- integrację z systemami monitoringu
    

> logging ≠ print()
> 
> logging = **kontrakt obserwowalności aplikacji**

---

## 1. Mentalny model (kluczowe)

**Logowanie to nie wypisywanie tekstu.**

W Pythonie:

- **logger** = obiekt emitujący zdarzenia
    
- **handler** = gdzie zdarzenie trafia
    
- **formatter** = jak wygląda zapis
    
- **level** = filtr semantyczny
    

➡️ Logger _nie wie_, gdzie zapisze log.  
➡️ Handler _nie wie_, skąd pochodzi log.

To celowy **rozplot odpowiedzialności**.

---
## 2. Poziomy logowania (semantyka)

|Poziom|Znaczenie|Kiedy używać|
|---|---|---|
|CRITICAL|aplikacja w stanie awaryjnym|brak możliwości dalszego działania|
|ERROR|błąd logiczny / runtime|operacja nie powiodła się|
|WARNING|stan nietypowy|fallback, retry, degradacja|
|INFO|normalny przebieg|lifecycle, start/stop|
|DEBUG|detale techniczne|debug, śledzenie|

Domyślny poziom root loggera: **WARNING**

---
## 3. Najczęstszy błąd początkujących ❌

```python
import logging

logger = logging.getLogger(__name__)

logging.basicConfig(level=logging.DEBUG)
logger.info("info")
```

**Dlaczego to jest problem?**

- `basicConfig()` **konfiguruje root logger**
    
- wywołany w bibliotece → psuje konfigurację aplikacji
    

Zasada:

> **basicConfig tylko w punkcie startowym aplikacji**

---
## 4. Poprawny wzorzec (entry point)

```python
# main.py
import logging

logging.basicConfig(
    level=logging.DEBUG,
    format="%(asctime)s | %(levelname)s | %(name)s | %(message)s"
)

from app import run
run()
```

---
## 5. Logger per moduł (złoty standard)

```python
# some_module.py
import logging

logger = logging.getLogger(__name__)


def process():
    logger.debug("start process")
    logger.info("processing data")
```

Dlaczego `__name__`?

- pełna ścieżka modułu
- naturalna hierarchia loggerów
- możliwość selektywnego filtrowania

---
## 6. Analiza Twojego kodu (krok po kroku)

### Kod wejściowy

```python
import logging

logger = logging.getLogger(__name__)


def main():
    logging.basicConfig(level=logging.DEBUG)

    logger.debug("debug message")
    logger.info("info message")
    logger.warning("warning message")
    logger.error("error message")
    logger.critical("critical message")

    try:
        1 / 0
    except ZeroDivisionError:
        logger.exception("exception message")


if __name__ == "__main__":
    main()
```

### Co tu się **naprawdę** dzieje

1. `logger = logging.getLogger(__name__)`
    
    - tworzysz **referencję do loggera**
    - brak handlerów → dziedziczy z root
        
2. `basicConfig()`
    
    - konfiguruje **root logger**
    - dodaje `StreamHandler`
        
3. `logger.exception()`
    
    - loguje ERROR
    - **automatycznie dołącza traceback**
        

---

## 7. Poprawiona wersja (produkcyjna)

```python
import logging
from logging.handlers import RotatingFileHandler


def configure_logging() -> None:
    root = logging.getLogger()
    root.setLevel(logging.DEBUG)

    handler = RotatingFileHandler(
        "app.log",
        maxBytes=2_000_000,
        backupCount=5,
        encoding="utf-8",
    )

    formatter = logging.Formatter(
        "%(asctime)s | %(levelname)s | %(name)s | %(message)s"
    )

    handler.setFormatter(formatter)
    root.addHandler(handler)


logger = logging.getLogger(__name__)


def main():
    logger.debug("debug message")
    logger.info("info message")
    logger.warning("warning message")
    logger.error("error message")

    try:
        1 / 0
    except ZeroDivisionError:
        logger.exception("division failed")


if __name__ == "__main__":
    configure_logging()
    main()
```

---

## 8. Logowanie wyjątków — zasada seniora

❌ źle:

```python
except Exception as e:
    logger.error(e)
```

✔ dobrze:

```python
except Exception:
    logger.exception("contextual message")
```

Dlaczego?

- traceback = **najcenniejsza informacja diagnostyczna**
    

---

## 9. Wzorce zapamiętywania

### Mnemonika

**LHF** → Logger → Handler → Formatter

### Asocjacja

Logger = _kamera_  
Handler = _kabel_  
Formatter = _filtr obrazu_

### Wzorzec strukturalny

```
EVENT
  ↓
LOGGER
  ↓
FILTER
  ↓
HANDLER
  ↓
FORMATTER
  ↓
OUTPUT
```

---

## 10. Dokumentacja i źródła

- [https://docs.python.org/3/library/logging.html](https://docs.python.org/3/library/logging.html)
- [https://docs.python.org/3/howto/logging.html](https://docs.python.org/3/howto/logging.html)
- [https://docs.python.org/3/howto/logging-cookbook.html](https://docs.python.org/3/howto/logging-cookbook.html)
    

___
Metadata:

```yaml
---
type: tool    # concept | tool | pattern
language: python # python | js | sql | etc.
---
```

Status: #pending
Tags: #logging #debuggin 
