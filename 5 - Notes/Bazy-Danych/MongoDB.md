---
title: "MongoDB"
type: concept
topic: databases
tags: ["databases", "nosql"]
created: 2026-06-09
status: draft
---

# MongoDB

> [!summary] W jednym zdaniu
> MongoDB to document database — przechowuje dane jako dokumenty BSON (JSON-like), bez sztywnego schematu. Dobra gdy dane są hierarchiczne i rzadko potrzebują JOIN-ów.

Open-source, napisana w C++. Najpopularniejsza baza dokumentowa.

---

## Kluczowe pojęcia

| SQL | MongoDB |
|-----|---------|
| database | database |
| table | collection |
| row | document |
| column | field |
| JOIN | `$lookup` (lub embed) |

Dokument to JSON/BSON — może mieć zagnieżdżone obiekty i tablice:

```json
{
  "_id": "abc123",
  "name": "Jan Kowalski",
  "address": {
    "city": "Warszawa",
    "zip": "00-001"
  },
  "orders": [1, 2, 3]
}
```

---

## Kiedy używać

MongoDB dobrze pasuje gdy:
- dane są hierarchiczne (naturalnie pasują do jednego dokumentu)
- schemat często się zmienia
- brak skomplikowanych relacji między encjami
- potrzebujesz szybkiego odczytu całego dokumentu (locality)

## Kiedy NIE używać

- dużo relacji many-to-many (JOIN w kodzie jest drogi)
- potrzebujesz silnych gwarancji ACID między wieloma kolekcjami
- dane tabelaryczne z ustaloną strukturą → PostgreSQL

---

## CAP: CP

MongoDB domyślnie jest CP — przy partycji sieciowej wybiera spójność nad dostępność.

---

## Powiązane notatki
- [[types of databases|Typy baz danych]] — porównanie z innymi NoSQL
- [[Kiedy SQL, kiedy NoSQL]] — kiedy document DB to dobry wybór
- [[JOIN — siła relacyjnego modelu]] — czego MongoDB nie ma natywnie
