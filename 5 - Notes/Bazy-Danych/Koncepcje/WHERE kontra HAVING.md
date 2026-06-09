---
tags: ["sql"]
powiązane: ["[[Logiczna kolejność wykonania zapytania]]", "[[Agregacje i GROUP BY]]"]
---

# WHERE kontra HAVING

> [!summary] W jednym zdaniu
> WHERE filtruje **wiersze przed grupowaniem**, HAVING filtruje **grupy po grupowaniu** — różnica wynika wprost z [[Logiczna kolejność wykonania zapytania|kolejności wykonania]] i jest jednym z najczęstszych pytań.

```sql
SELECT country, COUNT(*) AS n
FROM users
WHERE active = TRUE      -- najpierw: tylko aktywni (pojedyncze wiersze)
GROUP BY country
HAVING COUNT(*) > 100;   -- potem: tylko grupy liczniejsze niż 100
```

- **WHERE** działa w kroku 2 — zanim powstaną grupy. Dlatego **nie** może używać agregatów (`COUNT`, `SUM` jeszcze nie istnieją).
- **HAVING** działa w kroku 4 — po `GROUP BY`. Dlatego **może** filtrować po agregatach.

Test myślowy: "odfiltruj kraje, które mają ponad 100 aktywnych użytkowników":
- `active = TRUE` dotyczy pojedynczego użytkownika → **WHERE**.
- `COUNT(*) > 100` dotyczy całej grupy → **HAVING**.

> [!warning] Częsty błąd kandydata
> Wrzucenie `COUNT(*) > 100` do WHERE → błąd składni ("aggregate not allowed here"). Albo odwrotnie: filtr na pojedynczym wierszu w HAVING — zadziała, ale jest nieefektywny (baza najpierw grupuje wszystko, potem odrzuca). Filtruj jak najwcześniej: pojedyncze wiersze w WHERE.

> [!tip] Jednozdaniowa odpowiedź
> "WHERE filtruje wiersze przed agregacją i nie zna agregatów; HAVING filtruje grupy po agregacji i może ich używać." Dorzuć "wynika to z kolejności wykonania" i masz komplet.

## Połączenia
- [[Logiczna kolejność wykonania zapytania]] — źródło różnicy
- [[Agregacje i GROUP BY]] — kontekst grupowania
