---
title: "int"
type: concept
topic: python
tags: ["python", "types"]
created: 2026-06-10
status: draft
źródło: "sesja LLM, GPT-5 Codex, 2026-06-10"
sr_due: 2026-07-20
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# int

> [!summary]
> `int` to typ liczby całkowitej w Pythonie: reprezentuje wartości bez części ułamkowej i może rosnąć tak długo, jak pozwala pamięć procesu.

Model mentalny: `int` jest pudełkiem na liczbę całkowitą, ale pudełkiem elastycznym. W C często musisz wybrać rozmiar (`int32`, `int64`), a w Pythonie interpreter powiększa reprezentację liczby, kiedy wynik przestaje mieścić się w małym zakresie.

```python
x = 10
y = 2 ** 200

print(type(x))  # <class 'int'>
print(y)        # ogromna liczba, nadal int
```

`bool` jest podtypem `int`, dlatego `True == 1` i `False == 0`, ale semantycznie warto traktować je jako osobny typ logiczny.

> [!warning]
> Pythonowy `int` nie przepełnia się jak liczby całkowite w C, ale operacje na ogromnych liczbach nadal kosztują czas i pamięć. Brak overflow nie znaczy brak kosztu.

## Połączenia
- [[bool]] — `bool` dziedziczy po `int`, ale reprezentuje prawdę/fałsz.
- [[float]] — `float` reprezentuje przybliżenia liczb rzeczywistych, a `int` liczby całkowite.
- [[casting]] — `int()` często służy do konwersji tekstu albo liczby zmiennoprzecinkowej.
- [[type()]] — pozwala sprawdzić, że dana wartość jest obiektem typu `int`.
