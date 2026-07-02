---
tags: ["sql"]
powiązane: ["[[Podzapytania (subqueries)]]", "[[Window functions]]"]
sr_due: 2026-07-15
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# CTE (WITH)

> [!summary] W jednym zdaniu
> CTE (Common Table Expression, klauzula `WITH`) to nazwane podzapytanie zdefiniowane na górze zapytania — poprawia czytelność i pozwala odwołać się do tego samego wyniku wielokrotnie; bywa też rekurencyjne.

```sql
WITH av_payment_per_customer AS (  
    SELECT customer_id,  
           AVG(amount) AS avg_payment  
    FROM payment  
    GROUP BY customer_id  
)  
SELECT c.first_name,  
       c.last_name,  
       COUNT(pt.amount)  
FROM payment pt  
INNER JOIN av_payment_per_customer avpc ON pt.customer_id = avpc.customer_id  
INNER JOIN customer c ON pt.customer_id = c.customer_id  
WHERE pt.amount > avpc.avg_payment  
GROUP BY c.customer_id  
LIMIT 500;
```
`av_payment_per_customer` to tymczasowa, nazwana "tabela" widoczna tylko w tym zapytaniu. Zamiast zagnieżdżać [[Podzapytania (subqueries)|podzapytanie]] w środku, definiujesz je raz na górze i odwołujesz po nazwie.

**Rekurencyjne CTE** — `WITH RECURSIVE` — przetwarza hierarchie (drzewo kategorii, struktura podwładnych): część bazowa + część odwołująca się do samej siebie, aż przestanie zwracać wiersze.

> [!tip] CTE vs podzapytanie na rozmowie
> "Po co CTE, skoro można podzapytaniem?" — czytelność (płaska struktura zamiast zagnieżdżeń), możliwość użycia tego samego wyniku wielokrotnie, oraz rekurencja dla hierarchii. Wydajność zwykle podobna; główny zysk to klarowność.

> [!warning] Zakres widoczności
> CTE żyje tylko w obrębie jednego zapytania, w którym je zdefiniowano. To nie jest [[Window functions|trwały]] obiekt jak widok (VIEW), który zostaje w bazie.

## Połączenia
- [[Podzapytania (subqueries)]] — CTE to czytelniejsza forma
- [[Window functions]] — częsty duet: CTE z oknem, potem filtr po wyniku
