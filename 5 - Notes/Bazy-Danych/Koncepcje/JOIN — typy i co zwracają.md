---
tags: ["sql"]
powiązane: ["[[Klucz główny i obcy]]", "[[NULL i logika trójwartościowa]]", "[[Agregacje i GROUP BY]]"]
sr_due: 2026-07-20
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# JOIN — typy i co zwracają

> [!summary] W jednym zdaniu
> JOIN łączy wiersze z dwóch tabel po warunku (zwykle PK=FK); typ JOIN-a decyduje, co zrobić z wierszami **bez dopasowania** — i to jest sedno pytań rozmowowych.

Dane przykładowe (Sakila): `customer` i `rental` powiązane przez `rental.customer_id = customer.customer_id`.

| Typ | Co zwraca |
|-----|-----------|
| `INNER JOIN` | tylko pary, które się **dopasowały** w obu tabelach |
| `LEFT JOIN` | wszystkie wiersze z lewej + dopasowane z prawej; brak dopasowania → kolumny prawej jako [[NULL i logika trójwartościowa\|NULL]] |
| `RIGHT JOIN` | lustrzane odbicie LEFT (wszystkie z prawej) |
| `FULL JOIN` | wszystkie z obu; niedopasowane strony uzupełnione NULL-ami |
| `CROSS JOIN` | iloczyn kartezjański — każdy z każdym (bez warunku) |

```sql
SELECT c.first_name, r.rental_date
FROM customer c
LEFT JOIN rental r ON r.customer_id = c.customer_id;
```
Tu klient **bez** wypożyczeń i tak pojawi się w wyniku — z `rental_date` równym NULL. Przy `INNER JOIN` zniknąłby.

> [!warning] LEFT JOIN + WHERE na prawej tabeli
> `LEFT JOIN ... WHERE r.rental_date > '2005-08-01'` po cichu zamienia się w INNER JOIN — bo warunek na NULL (dla niedopasowanych) daje UNKNOWN i odfiltrowuje je. Jeśli chcesz zachować lewe wiersze, warunek przenieś do `ON`, nie do `WHERE`.

> [!tip] Pytanie-klasyk
> "Różnica INNER vs LEFT?" — INNER odrzuca niedopasowane, LEFT zachowuje wszystkie lewe i wstawia NULL po prawej. "Kiedy LEFT JOIN daje duplikaty lewych wierszy?" — gdy jednemu lewemu odpowiada wiele prawych.

## Połączenia
- [[Self-join]] — JOIN tabeli z samą sobą
- [[Klucz główny i obcy]] — warunek JOIN-a to zwykle PK=FK
- [[NULL i logika trójwartościowa]] — skąd NULL-e przy LEFT JOIN
- [[Agregacje i GROUP BY]] — częsty następny krok po JOIN
