# 🟦 Python Logging — Notatka dla programistów

Pythonowy moduł **logging** to standardowy sposób rejestrowania zdarzeń w aplikacji.  
Jest wydajny, konfigurowalny, w pełni thread-safe i gotowy do użycia w aplikacjach CLI, web, backend i systemach rozproszonych.

---

## 1. Cel logowania
- diagnoza błędów i problemów
- monitoring zachowania aplikacji
- zbieranie zdarzeń do analizy (audyt, bezpieczeństwo)
- zrozumienie przepływu wykonania kodu

---

## 2. Poziomy logowania (od najważniejszych)
Odzwierciedlają powagę zdarzenia:

| Poziom | Metoda | Znaczenie |
|--------|--------|-----------|
| CRITICAL | `logging.critical()` | system w stanie awaryjnym |
| ERROR | `logging.error()` | błąd wymagający interwencji |
| WARNING | `logging.warning()` | sytuacja nietypowa |
| INFO | `logging.info()` | informacja o normalnym działaniu |
| DEBUG | `logging.debug()` | szczegóły techniczne do debugowania |
| NOTSET | — | poziom domyślny |

Domyślny poziom: **WARNING** (info/debug nie będą widoczne bez konfiguracji).

---

## 3. Najprostsze użycie

```python
import logging

logging.warning("Uwaga!")
logging.info("To się nie wyświetli bez konfiguracji")
logging.debug("Debug info")
```

---

## 4. Podstawowa konfiguracja

```python
import logging

logging.basicConfig(
    level=logging.DEBUG,
    format="%(asctime)s | %(levelname)s | %(name)s | %(message)s"
)

logging.info("Aplikacja startuje")
```

Parametry:
- **level** – minimalny poziom wyświetlania
- **format** – wygląd logu  
- **filename** – zapis do pliku
- **filemode='w'** – tryb nadpisywania

---

## 5. Logowanie do pliku

```python
logging.basicConfig(
    filename="app.log",
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s"
)
```

Efekt:  
logi trafiają do `app.log`, nie na konsolę.

---

## 6. Logger aplikacyjny (zalecany sposób)

```python
import logging

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

logger.debug("Debug info")
logger.error("Błąd krytyczny")
```

Dlaczego tak?
- każdy moduł ma swój logger
- łatwe filtrowanie
- łatwe kierowanie logów do wielu odbiorców

---

## 7. Handlery — kierowanie logów do wielu miejsc jednocześnie

```python
import logging

logger = logging.getLogger("app")
logger.setLevel(logging.DEBUG)

console = logging.StreamHandler()
file = logging.FileHandler("app.log")

logger.addHandler(console)
logger.addHandler(file)

logger.info("Log idzie do konsoli i do pliku")
```

Typy handlerów:
- `StreamHandler` – konsola
- `FileHandler` – plik
- `RotatingFileHandler` – automatyczna rotacja plików
- `SMTPHandler` – wysyłanie logów mailem
- `SysLogHandler` – logi systemowe
- i wiele innych

---

## 8. Formatery — pełna kontrola wyglądu logów

```python
formatter = logging.Formatter(
    "%(asctime)s | %(levelname)s | %(name)s | %(message)s"
)

console.setFormatter(formatter)
file.setFormatter(formatter)
```

Popularne pola:
- `%(asctime)s` – timestamp
- `%(levelname)s` – poziom
- `%(name)s` – nazwa loggera
- `%(message)s` – treść
- `%(filename)s` – plik źródłowy
- `%(lineno)d` – numer linii
- `%(threadName)s` – wątek

---

## 9. Logowanie wyjątków

### Automatyczne logowanie stacktrace:

```python
try:
    1 / 0
except ZeroDivisionError:
    logger.exception("Błąd podczas dzielenia")
```

`logger.exception()` = `logger.error(..., exc_info=True)`

---

## 10. Najlepsze praktyki

✔ Twórz logger dla każdego modułu:  
`logger = logging.getLogger(__name__)`  

✔ Nie używaj `print()` do debugowania produkcyjnego.

✔ Nie ustawiaj globalnie `basicConfig()` w bibliotekach.

✔ Unikaj logowania w pętli wysokiej częstotliwości bez ograniczeń.

✔ Zawsze loguj wyjątki przez `logger.exception()`.

✔ W aplikacjach większych używaj `RotatingFileHandler`.

---

## 11. Logowanie asynchroniczne (zaawansowane)

W systemach o dużej przepustowości zaleca się:

- `QueueHandler`  
- `QueueListener`

Przykład:

```python
from logging.handlers import QueueHandler
import logging, queue

q = queue.Queue()
qh = QueueHandler(q)

logger = logging.getLogger("async")
logger.addHandler(qh)
```

QueueListener obsługuje zapis do pliku w osobnym wątku.

---

## 12. Ultra-skrót (TL;DR)

- logging to standard do logów w Pythonie  
- domyślny poziom to WARNING  
- do profesjonalnych projektów → logger per moduł  
- błędy loguj przez `logger.exception()`  
- do produkcji → handlery + formattery  

---

## 13. Minimalna konfiguracja produkcyjna

```python
import logging
from logging.handlers import RotatingFileHandler

logger = logging.getLogger("app")
logger.setLevel(logging.INFO)

handler = RotatingFileHandler("app.log", maxBytes=2_000_000, backupCount=5)
formatter = logging.Formatter("%(asctime)s | %(levelname)s | %(message)s")
handler.setFormatter(formatter)

logger.addHandler(handler)
```