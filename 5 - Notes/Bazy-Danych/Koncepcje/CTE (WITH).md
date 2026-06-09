---
tags: ["sql"]
powiązane: ["[[Podzapytania (subqueries)]]", "[[Window functions]]"]
---

# CTE (WITH)

> [!summary] W jednym zdaniu
> CTE (Common Table Expression, klauzula `WITH`) to nazwane podzapytanie zdefiniowane na górze zapytania — poprawia czytelność i pozwala odwołać się do tego samego wyniku wielokrotnie; bywa też rekurencyjne.

```sql
WITH dept_avg AS (
    SELECT department, AVG(salary) AS avg_sal
    FROM employees
    GROUP BY department
)
SELECT e.name, e.salary, d.avg_sal
FROM employees e
JOIN dept_avg d ON d.department = e.department
WHERE e.salary > d.avg_sal;
```
`dept_avg` to tymczasowa, nazwana "tabela" widoczna tylko w tym zapytaniu. Zamiast zagnieżdżać [[Podzapytania (subqueries)|podzapytanie]] w środku, definiujesz je raz na górze i odwołujesz po nazwie.

**Rekurencyjne CTE** — `WITH RECURSIVE` — przetwarza hierarchie (drzewo kategorii, struktura podwładnych): część bazowa + część odwołująca się do samej siebie, aż przestanie zwracać wiersze.

> [!tip] CTE vs podzapytanie na rozmowie
> "Po co CTE, skoro można podzapytaniem?" — czytelność (płaska struktura zamiast zagnieżdżeń), możliwość użycia tego samego wyniku wielokrotnie, oraz rekurencja dla hierarchii. Wydajność zwykle podobna; główny zysk to klarowność.

> [!warning] Zakres widoczności
> CTE żyje tylko w obrębie jednego zapytania, w którym je zdefiniowano. To nie jest [[Window functions|trwały]] obiekt jak widok (VIEW), który zostaje w bazie.

## Połączenia
- [[Podzapytania (subqueries)]] — CTE to czytelniejsza forma
- [[Window functions]] — częsty duet: CTE z oknem, potem filtr po wyniku
