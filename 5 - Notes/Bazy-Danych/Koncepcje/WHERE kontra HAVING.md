---
tags: ["sql"]
powiązane: ["[[Logiczna kolejność wykonania zapytania]]", "[[Agregacje i GROUP BY]]"]
sr_due: 2026-07-16
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# WHERE kontra HAVING

> [!summary] W jednym zdaniu
> WHERE filtruje **wiersze przed grupowaniem**, HAVING filtruje **grupy po grupowaniu** — różnica wynika wprost z [[Logiczna kolejność wykonania zapytania|kolejności wykonania]] i jest jednym z najczęstszych pytań.

```sql
SELECT rating, COUNT(*) AS n
FROM film
WHERE length > 90        -- najpierw: tylko filmy dłuższe niż 90 min (pojedyncze wiersze)
GROUP BY rating
HAVING COUNT(*) > 120;   -- potem: tylko ratingi z ponad 120 takimi filmami
```

- **WHERE** działa w kroku 2 — zanim powstaną grupy. Dlatego **nie** może używać agregatów (`COUNT`, `SUM` jeszcze nie istnieją).
- **HAVING** działa w kroku 4 — po `GROUP BY`. Dlatego **może** filtrować po agregatach.

Test myślowy: "odfiltruj ratingi, które mają ponad 120 filmów dłuższych niż 90 minut":
- `length > 90` dotyczy pojedynczego filmu → **WHERE**.
- `COUNT(*) > 120` dotyczy całej grupy → **HAVING**.

> [!warning] Częsty błąd kandydata
> Wrzucenie `COUNT(*) > 100` do WHERE → błąd składni ("aggregate not allowed here"). Albo odwrotnie: filtr na pojedynczym wierszu w HAVING — zadziała, ale jest nieefektywny (baza najpierw grupuje wszystko, potem odrzuca). Filtruj jak najwcześniej: pojedyncze wiersze w WHERE.

> [!tip] Jednozdaniowa odpowiedź
> "WHERE filtruje wiersze przed agregacją i nie zna agregatów; HAVING filtruje grupy po agregacji i może ich używać." Dorzuć "wynika to z kolejności wykonania" i masz komplet.

## Połączenia
- [[Logiczna kolejność wykonania zapytania]] — źródło różnicy
- [[Agregacje i GROUP BY]] — kontekst grupowania
