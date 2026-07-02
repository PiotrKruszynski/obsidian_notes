---
tags: ["sql"]
powiązane: ["[[Model relacyjny]]", "[[JOIN — typy i co zwracają]]", "[[Normalizacja (1NF, 2NF, 3NF)]]", "[[Indeks — jak działa i kiedy pomaga]]"]
sr_due: 2026-07-13
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Klucz główny i obcy

> [!summary] W jednym zdaniu
> Klucz główny (PK) jednoznacznie identyfikuje wiersz w tabeli; klucz obcy (FK) to kolumna wskazująca na PK innej tabeli — i to FK spina [[Model relacyjny|relacje]] między tabelami.

**Klucz główny (PRIMARY KEY)** — kolumna (lub zestaw kolumn), której wartość jest **unikalna i nie-NULL** dla każdego wiersza. Np. `users.id`. Baza zwykle automatycznie zakłada na nim [[Indeks — jak działa i kiedy pomaga|indeks]], bo musi szybko sprawdzać unikalność.

**Klucz obcy (FOREIGN KEY)** — kolumna, która przechowuje wartość PK z innej tabeli. `orders.user_id` wskazuje na `users.id`. To wymusza **integralność referencyjną**: nie wstawisz zamówienia dla nieistniejącego użytkownika, a baza może blokować usunięcie użytkownika, który ma zamówienia.

```
users                 orders
┌────┬───────┐        ┌────┬─────────┬────────┐
│ id │ name  │        │ id │ user_id │ amount │
├────┼───────┤        ├────┼─────────┼────────┤
│ 1  │ Ala   │◄───────┤ 10 │   1     │  120   │
│ 2  │ Bob   │        │ 11 │   1     │   80   │
└────┴───────┘        └────┴─────────┴────────┘
   PK                          FK → users.id
```

> [!tip] Pytanie rozmowowe
> "Czym różni się PK od UNIQUE?" — PK jest jeden na tabelę i nie-NULL; kolumn UNIQUE może być wiele i (zwykle) dopuszczają jeden NULL. "Czym różni się PK od FK?" — PK identyfikuje wiersz tu, FK odwołuje się do PK gdzie indziej.

## Połączenia
- [[Model relacyjny]] — kontekst tabel i relacji
- [[JOIN — typy i co zwracają]] — łączenie po PK=FK
- [[Indeks — jak działa i kiedy pomaga]] — PK zwykle ma indeks
- [[Normalizacja (1NF, 2NF, 3NF)]] — klucze a rozkład tabel
