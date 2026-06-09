---
tags: ["sql"]
powiązane: ["[[SELECT i filtrowanie (WHERE)]]", "[[WHERE kontra HAVING]]", "[[Agregacje i GROUP BY]]"]
---

# Logiczna kolejność wykonania zapytania

> [!summary] W jednym zdaniu
> SQL wykonuje klauzule w innej kolejności, niż je piszesz: najpierw FROM, na końcu SELECT i ORDER BY — co tłumaczy większość "dziwnych" zachowań pytanych na rozmowach.

Piszesz `SELECT ... FROM ... WHERE ... GROUP BY ...`, ale **logiczna** kolejność jest taka:

```
1. FROM / JOIN     ← weź i połącz tabele
2. WHERE           ← odfiltruj wiersze (przed grupowaniem!)
3. GROUP BY        ← pogrupuj
4. HAVING          ← odfiltruj grupy (po grupowaniu)
5. SELECT          ← policz wyrażenia, aliasy powstają TUTAJ
6. DISTINCT
7. ORDER BY        ← posortuj wynik
8. LIMIT / OFFSET  ← utnij
```

Ta kolejność wyjaśnia rzeczy, które inaczej wyglądają jak kaprys bazy:

- **Czemu nie mogę użyć aliasu z SELECT w WHERE?** Bo WHERE (krok 2) działa, zanim SELECT (krok 5) stworzy alias. Alias jeszcze nie istnieje.
- **Czemu filtr po agregacie idzie do HAVING, nie WHERE?** Bo WHERE działa przed GROUP BY (agregaty jeszcze nie policzone), a HAVING po — patrz [[WHERE kontra HAVING]].
- **Czemu ORDER BY może używać aliasu z SELECT?** Bo sortowanie (krok 7) jest po SELECT (krok 5) — alias już istnieje.

> [!tip] To jeden z najczęstszych "aha" tematów na rozmowach
> Jeśli umiesz wyrecytować tę kolejność i wyprowadzić z niej WHERE-vs-HAVING oraz problem aliasów, pokazujesz, że rozumiesz SQL, a nie tylko go klepiesz.

## Połączenia
- [[SQL jako język deklaratywny]] — czemu mówisz „co”, nie „jak”, i co robi optymalizator
- [[SELECT i filtrowanie (WHERE)]] — krok 2
- [[WHERE kontra HAVING]] — wprost wynika z tej kolejności
- [[Agregacje i GROUP BY]] — kroki 3–4
