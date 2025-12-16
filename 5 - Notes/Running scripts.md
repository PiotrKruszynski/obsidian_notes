Created: 2025-12-16  14:40
___
Note:

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




___
Metadata:

Status: #pending
Tags: #empty
