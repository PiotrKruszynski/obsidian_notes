

Created: 2025-12-16  22:53
___
Note:

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




___
Metadata:
```yaml
type: tool
category: testing
language: python
level: beginner-intermediate
```


Status: #pending
Tags: #python #testing #pytest #tdd #qa
