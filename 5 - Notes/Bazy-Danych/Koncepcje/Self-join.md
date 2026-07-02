---
tags: ["sql"]
powiązane: ["[[JOIN — typy i co zwracają]]", "[[Klucz główny i obcy]]"]
sr_due: 2026-07-01
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# Self-join

> [!summary] W jednym zdaniu
> Self-join to [[JOIN — typy i co zwracają|JOIN]] tabeli **z samą sobą** — używasz dwóch aliasów tej samej tabeli, by porównywać wiersze między sobą; typowe dla hierarchii i par.

**Pary w obrębie jednej tabeli — aktorzy o tym samym nazwisku (Sakila):**
```sql
SELECT a1.first_name AS aktor_1, a2.first_name AS aktor_2, a1.last_name
FROM actor a1
JOIN actor a2 ON a1.last_name = a2.last_name
             AND a1.actor_id < a2.actor_id;
```
Ta sama tabela występuje dwa razy pod aliasami `a1` i `a2`. Warunek `a1.actor_id < a2.actor_id` załatwia dwa problemy naraz: wyklucza parowanie aktora z samym sobą i duplikaty par (A-B oraz B-A).

**Porównywanie wierszy między sobą — filmy o identycznej długości:**
```sql
SELECT f1.title, f2.title, f1.length
FROM film f1
JOIN film f2 ON f1.length = f2.length
            AND f1.film_id < f2.film_id;
```

Drugi kanon self-joina to hierarchia `employees(id, manager_id)` — FK wskazujący na własny PK ([[Klucz główny i obcy]]); pracownik i przełożony to wtedy dwa aliasy tej samej tabeli (`LEFT JOIN` zachowa prezesa bez szefa jako NULL). Sakila hierarchii nie ma, ale na rozmowie ten wariant pada najczęściej.

> [!tip] Dlaczego to pyta rozmówca
> Self-join sprawdza, czy rozumiesz, że alias to "egzemplarz" tabeli, a nie sama tabela. Bez aliasów `employees JOIN employees` byłoby niejednoznaczne. Umiejętność porównywania wierszy w obrębie jednej tabeli to sygnał dojrzałości w SQL.

> [!warning] Zawsze aliasuj
> Przy self-join aliasy (`e`, `m`) są **konieczne** — inaczej baza nie wie, do którego "egzemplarza" tabeli odnosi się kolumna. Każde odwołanie do kolumny prefiksuj aliasem.

## Połączenia
- [[JOIN — typy i co zwracają]] — self-join to zwykły JOIN, tylko ta sama tabela
- [[Klucz główny i obcy]] — `manager_id` to FK wskazujący na własny PK
