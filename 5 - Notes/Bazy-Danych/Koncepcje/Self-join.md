---
tags: [sql, koncepcja, średni]
powiązane: ["[[JOIN — typy i co zwracają]]", "[[Klucz główny i obcy]]"]
---

# Self-join

> [!summary] W jednym zdaniu
> Self-join to [[JOIN — typy i co zwracają|JOIN]] tabeli **z samą sobą** — używasz dwóch aliasów tej samej tabeli, by porównywać wiersze między sobą; typowe dla hierarchii i par.

Tabela `employees(id, name, salary, manager_id)`, gdzie `manager_id` wskazuje na `id` innego pracownika ([[Klucz główny i obcy|FK na własną tabelę]]).

**Hierarchia — pracownik i jego przełożony:**
```sql
SELECT e.name AS pracownik, m.name AS przelozony
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id;
```
Ta sama tabela występuje dwa razy pod aliasami `e` i `m`. `LEFT JOIN` zachowa też prezesa (bez przełożonego → `m` jako NULL).

**Klasyczne pytanie: kto zarabia więcej niż jego przełożony:**
```sql
SELECT e.name
FROM employees e
JOIN employees m ON e.manager_id = m.id
WHERE e.salary > m.salary;
```

> [!tip] Dlaczego to pyta rozmówca
> Self-join sprawdza, czy rozumiesz, że alias to "egzemplarz" tabeli, a nie sama tabela. Bez aliasów `employees JOIN employees` byłoby niejednoznaczne. Umiejętność porównywania wierszy w obrębie jednej tabeli to sygnał dojrzałości w SQL.

> [!warning] Zawsze aliasuj
> Przy self-join aliasy (`e`, `m`) są **konieczne** — inaczej baza nie wie, do którego "egzemplarza" tabeli odnosi się kolumna. Każde odwołanie do kolumny prefiksuj aliasem.

## Połączenia
- [[JOIN — typy i co zwracają]] — self-join to zwykły JOIN, tylko ta sama tabela
- [[Klucz główny i obcy]] — `manager_id` to FK wskazujący na własny PK
