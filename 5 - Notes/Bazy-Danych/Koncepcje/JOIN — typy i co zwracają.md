---
tags: ["sql"]
powiązane: ["[[Klucz główny i obcy]]", "[[NULL i logika trójwartościowa]]", "[[Agregacje i GROUP BY]]"]
---

# JOIN — typy i co zwracają

> [!summary] W jednym zdaniu
> JOIN łączy wiersze z dwóch tabel po warunku (zwykle PK=FK); typ JOIN-a decyduje, co zrobić z wierszami **bez dopasowania** — i to jest sedno pytań rozmowowych.

Dane przykładowe: `users` i `orders` powiązane przez `orders.user_id = users.id`.

| Typ | Co zwraca |
|-----|-----------|
| `INNER JOIN` | tylko pary, które się **dopasowały** w obu tabelach |
| `LEFT JOIN` | wszystkie wiersze z lewej + dopasowane z prawej; brak dopasowania → kolumny prawej jako [[NULL i logika trójwartościowa\|NULL]] |
| `RIGHT JOIN` | lustrzane odbicie LEFT (wszystkie z prawej) |
| `FULL JOIN` | wszystkie z obu; niedopasowane strony uzupełnione NULL-ami |
| `CROSS JOIN` | iloczyn kartezjański — każdy z każdym (bez warunku) |

```sql
SELECT u.name, o.amount
FROM users u
LEFT JOIN orders o ON o.user_id = u.id;
```
Tu użytkownik **bez** zamówień i tak pojawi się w wyniku — z `amount` równym NULL. Przy `INNER JOIN` zniknąłby.

> [!warning] LEFT JOIN + WHERE na prawej tabeli
> `LEFT JOIN ... WHERE o.amount > 100` po cichu zamienia się w INNER JOIN — bo warunek na NULL (dla niedopasowanych) daje UNKNOWN i odfiltrowuje je. Jeśli chcesz zachować lewe wiersze, warunek przenieś do `ON`, nie do `WHERE`.

> [!tip] Pytanie-klasyk
> "Różnica INNER vs LEFT?" — INNER odrzuca niedopasowane, LEFT zachowuje wszystkie lewe i wstawia NULL po prawej. "Kiedy LEFT JOIN daje duplikaty lewych wierszy?" — gdy jednemu lewemu odpowiada wiele prawych.

## Połączenia
- [[Self-join]] — JOIN tabeli z samą sobą
- [[Klucz główny i obcy]] — warunek JOIN-a to zwykle PK=FK
- [[NULL i logika trójwartościowa]] — skąd NULL-e przy LEFT JOIN
- [[Agregacje i GROUP BY]] — częsty następny krok po JOIN
