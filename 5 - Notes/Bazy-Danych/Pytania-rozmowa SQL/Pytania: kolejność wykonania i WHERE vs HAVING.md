---
tags: [sql, rozmowa, pytania]
status: do-powtórki
---

# Pytania: kolejność wykonania i WHERE vs HAVING

> [!abstract] Po co ten zestaw
> Najczęstszy "filtr na zrozumienie" na rozmowach SQL. Jeśli umiesz wyprowadzić odpowiedzi z [[Logiczna kolejność wykonania zapytania|kolejności wykonania]], pokrywasz całą rodzinę pytań naraz.

## Q: W jakiej kolejności SQL wykonuje klauzule?
FROM/JOIN → WHERE → GROUP BY → HAVING → SELECT → DISTINCT → ORDER BY → LIMIT. Pełne wyjaśnienie: [[Logiczna kolejność wykonania zapytania]].

## Q: Różnica WHERE a HAVING?
WHERE filtruje pojedyncze wiersze przed grupowaniem i nie zna agregatów; HAVING filtruje grupy po grupowaniu i może używać `COUNT`/`SUM` itd. → [[WHERE kontra HAVING]].

## Q: Czemu nie mogę użyć aliasu z SELECT w WHERE?
Bo WHERE wykonuje się przed SELECT — alias jeszcze nie istnieje. W ORDER BY już można, bo sortowanie jest po SELECT.

## Q: Mam odfiltrować klientów z ponad 5 zamówieniami i tylko aktywnych. Co gdzie?
`active = TRUE` → WHERE (pojedynczy wiersz). `COUNT(*) > 5` → HAVING (agregat grupy).

> [!warning] Częsty błąd kandydata
> Wrzucenie agregatu do WHERE (`WHERE COUNT(*) > 5`) → błąd. Albo filtr pojedynczego wiersza w HAVING — zadziała, ale grupuje wszystko niepotrzebnie. Reguła: filtruj jak najwcześniej.
