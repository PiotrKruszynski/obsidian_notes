
- **__slots__ = deklaracja pól instancji** (np. name, age), dzięki czemu interpreter nie tworzy standardowego **__dict__** w obiekcie.


- Zamiast dynamicznej tablicy atrybutów (dict) tworzona jest **sztywna tablica wskaźników** do pól → **mniej pamięci, szybszy dostęp**.


- **Ograniczenie**: nie możesz przypisać atrybutu spoza listy w __slots__.

