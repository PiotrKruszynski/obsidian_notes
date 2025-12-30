
- **__slots__ = deklaracja pól instancji** , dzięki czemu interpreter nie tworzy standardowego **__dict__** w obiekcie.
- powoduje **ograniczenie**: nie możesz przypisać atrybutu spoza listy w __slots__.
- zamiast dynamicznej tablicy atrybutów (dict) tworzona jest **sztywna tablica wskaźników** do pól → **mniej pamięci, szybszy dostęp**.


>[! Important]
>Przy dziedziczeniu musimy pamiętać aby zawsze dodawać slots do Y(x)
>```python
>class X:
>__slots__ = ('yolo')
>
>class Y(X):
>__slots__ = ('magic') # musimy dodać



