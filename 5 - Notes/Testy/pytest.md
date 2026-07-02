---
title: "pytest"
type: concept
topic: testing
tags: ["pytest", "python", "tdd", "testing"]
created: 2026-06-09
status: draft
sr_due: 2026-07-10
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

[[test runner]] do testów automatycznych w Pythonie. Upraszcza pisanie testów (brak klas testowych), oferuje czytelne asserty, rozbudowany system _fixtures_ oraz potężny mechanizm pluginów. Jest standardem de-facto w projektach Pythonowych

**dokumentacja**
 https://docs.pytest.org/en/stable/how-to/usage.html

- **Testy jako funkcje** (bez unittest.TestCase)
- **Zwykłe** **assert** (pytest sam pokazuje diff)
- **Fixtures** – wstrzykiwanie zależności (setup/teardown)
- **Parametryzacja** – jeden test, wiele przypadków
- **Bogaty ekosystem pluginów** (coverage, xdist, django, asyncio)

**fixtures**
```python
import pytest

@pytest.fixture
def user():
    return {"name": "Alice", "active": True}

def test_user_active(user):
    assert user["active"] is True
```

fixture to funkcja -> pytest wstrzykuje ją do testu po nazwie

**parametryzacja**
```python
import pytest

@pytest.mark.parametrize(
    "a,b,expected",
    [
        (1, 2, 3),
        (0, 0, 0),
        (-1, 1, 0),
    ]
)
def test_add(a, b, expected):
    assert a + b == expected
```


**mapowanie pojęć**
- test case → **funkcja testowa**
- setUp / tearDown → **fixture**
- TestSuite → **katalog / moduł**
- unittest.TestCase → **niepotrzebne**


**flagi**
```bash
pytest -v        # verbose
pytest -q        # quiet
pytest -x        # stop po pierwszym błędzie
pytest --lf     # tylko ostatnie nieudane
pytest -k name  # filtr po nazwie
```
