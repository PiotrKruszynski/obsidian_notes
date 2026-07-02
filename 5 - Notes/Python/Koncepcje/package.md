---
title: "package"
type: concept
topic: python
tags: ["python", "imports"]
created: 2026-06-10
status: draft
źródło: "sesja LLM, GPT-5 Codex, 2026-06-10"
sr_due: 2026-07-09
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# package

> [!summary]
> Package to moduł, który może zawierać inne moduły: w praktyce katalog importowalny przez Pythona, używany do grupowania kodu w przestrzenie nazw.

Model mentalny: `module` to pojedynczy rozdział, a `package` to teczka z rozdziałami. Dzięki temu nazwy nie leżą płasko w całym projekcie, tylko mają adres typu `app.models.user`.

Klasyczny package ma plik `__init__.py`:

```text
app/
  __init__.py
  models.py
  services.py
```

Wtedy możesz importować:

```python
from app import models
from app.services import create_user
```

`__init__.py` wykonuje się przy imporcie pakietu, więc nie powinien odpalać ciężkich efektów ubocznych. Najczęściej służy do oznaczenia katalogu jako pakietu albo do wystawienia wygodnego API importów.

> [!warning]
> Jeśli w `__init__.py` uruchomisz połączenie z bazą albo kosztowną inicjalizację, stanie się to już przy imporcie pakietu. Import powinien raczej definiować rzeczy niż wykonywać pracę aplikacji.

## Połączenia
- [[module]] — package jest szczególnym modułem, który organizuje inne moduły.
- [[namespace]] — package tworzy nazwę nadrzędną dla modułów wewnątrz.
- [[__init__|__init__]] — plik wykonywany przy imporcie klasycznego pakietu.
- import — package istnieje po to, żeby Python mógł odnajdywać kod przez mechanizm importów.
