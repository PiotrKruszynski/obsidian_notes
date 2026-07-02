---
title: "Running scripts"
type: tool
topic: python
tags: ["python", "scripting", "tooling"]
created: 2026-06-09
status: draft
sr_due: 2026-07-01
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

Uruchomienie skryptu python z instalacją tymczasową zależności przy użyciu [[UV]].

```python

# file: example.py

import requests  
  
r = requests.get("https://api.nbp.pl/api/exchangerates/rates/a/usd?format=json") 
print(r.json())
```
```shell
uv run --with requests example.py

# -- with mówi jakie zależności powinny być zainstalowane, --with może być wiele razy
```

**Script dependencies**

Deklarowanie metadanych do uruchomienia skryptu automatycznie.

```python
# /// script  
# requires-python = ">=3.12"
# dependencies = [  
#   "requests",  
# ]  
# ///  
  
import requests  
  
r = requests.get("https://api.nbp.pl/api/exchangerates/rates/a/usd?format=json")  
print(r.json())
```
```shell
uv run example.py
```
