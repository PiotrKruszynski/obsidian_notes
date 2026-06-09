---
title: "mypy"
type: tool
topic: python
tags: ["devops", "mypy", "protocols", "python", "tdd", "typing"]
created: 2026-06-09
status: draft
---

#### statyczne sprawdzanie typów
# Najważniejsze idee (mentalny model)

- **Python pozostaje dynamiczny** → mypy to _opcjonalna_ warstwa kontroli.
    
- **„Zaufaj adnotacjom”** → mypy zakłada, że typy w sygnaturach są prawdą.
    
- **Duck typing + Protocols** → liczy się _co obiekt potrafi_, nie z czego dziedziczy.
    
- **Gradual typing** → możesz typować fragmentami, stopniowo.



- [Oficjalna]( https://mypy-lang.org/)
- [Docs](https://mypy.readthedocs.io/)
- [PEP 484 (Type Hints):](https://peps.python.org/pep-0484/)
- [PEP 544 (Protocols): ](https://peps.python.org/pep-0544/)
