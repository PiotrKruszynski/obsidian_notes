---
tags: ["sql", "dml", "views"]
---

# CREATE VIEW

## Definicja

**VIEW** (widok) to wirtualna tabela — zapisane zapytanie SELECT, które działa jak tabela. Gdy ktoś SELECT-uje z widoku, baza wykonuje przypisane mu zapytanie.

```sql
CREATE VIEW nazwa_widoku AS
SELECT kolumny FROM tabela WHERE warunek;
```

## Syntax podstawowy

```sql
-- Widok prosty
CREATE VIEW vw_pracownicy_aktywni AS
SELECT id, imie, nazwisko, pensja
FROM pracownicy
WHERE status = 'aktywny';

-- Widok ze złożonym zapytaniem (JOINy, agregacje)
CREATE VIEW vw_sprzedaz_miesieczna AS
SELECT 
    DATE_TRUNC('month', data_zamowienia) AS miesiac,
    COUNT(*) AS liczba_zamowien,
    SUM(kwota) AS przychod
FROM zamowienia
GROUP BY DATE_TRUNC('month', data_zamowienia);

-- Usunięcie widoku
DROP VIEW vw_pracownicy_aktywni;

-- Usunięcie jeśli istnieje (PostgreSQL, MySQL 5.7+)
DROP VIEW IF EXISTS vw_pracownicy_aktywni;
```

## Use-case-y

| Cel | Przykład |
|-----|----------|
| **Abstrakcja logiki biznesowej** | Komuś z biz potrzebny "raport sprzedaży" — tworzysz widok; on nigdy nie musi wiedzieć, które tabele JOIN-ować |
| **Uproszczenie powtarzających się zapytań** | Jeśli 5 raportów robić `WHERE status='aktywny' AND rok=2024`, utwórz widok, używaj go wszędzie |
| **Segurność** | Zamiast dać dostęp do `pracownicy` (z pensją!), dasz dostęp do widoku bez sensytywnych kolumn |
| **Kompatybilność** | Refaktoryzujesz schematę, ale widok pozostaje taki sam — aplikacja nie widzi zmian |

## Praktyczne przykłady

```sql
-- 1. Widok do raportowania (bez detali, tylko podsumowanie)
CREATE VIEW vw_klienci_zloci AS
SELECT 
    k.id, k.nazwa,
    COUNT(z.id) AS liczba_zamowien,
    SUM(z.kwota) AS laczna_wartosc
FROM klienci k
LEFT JOIN zamowienia z ON k.id = z.klient_id
WHERE z.kwota > 10000
GROUP BY k.id, k.nazwa;

-- 2. Widok bezpieczny (bez sensytywnych pól)
CREATE VIEW vw_pracownicy_publiczny AS
SELECT id, imie, nazwisko, stanowisko, dz_pracy
FROM pracownicy
-- pensja jest UKRYTA

-- 3. Query na widoku (widok działa jak normalna tabela!)
SELECT * FROM vw_klienci_zloci WHERE liczba_zamowien > 5;

-- 4. Złożony widok (widok na widoku = czasem OK, ale rób ostrożnie)
CREATE VIEW vw_top_klienci AS
SELECT * FROM vw_klienci_zloci WHERE laczna_wartosc > 50000;
```

## Pułapki

| Pułapka | Co się stało | Jak uniknąć |
|---------|-------------|-----------|
| **VIEW na starym schemacie** | Usunąłeś kolumnę z tabeli źródłowej → `SELECT *` w widoku pada | Wymieniaj kolumny jawnie, nie `SELECT *` |
| **Zamieszanie: UPDATE/DELETE na widoku** | Niektóre widoki SĄ updateable, inne nie (tylko proste). To Cię zdziwi. | Widoki głównie do READ. UPDATE/DELETE na bazowych tabelach. |
| **Performance: widok jako pułapka** | VIEW nie cachuje wyniku. Za każdym razem pełne zapytanie. Jeśli widok to JOINy + agregacje na 1M wierszy, będzie wolno. | Monitoruj `EXPLAIN` na widoku. Jak wynik duży + powtarzalny, rozważ **materialized view** lub cache w aplikacji. |
| **Widok na widoku na widoku** | 5 warstw zagnieżdżeń VIEW-ów = chaotyczne, trudne do debug-owania | Maks 2-3 poziomy. Inaczej tracisz kontrolę. |
| **DROP VIEW gdy zależy od niego inny widok** | `DROP VIEW vw_A` pada, jeśli `vw_B` zależy od `vw_A` | Użyj `DROP VIEW vw_A CASCADE` (PostgreSQL) do rekurencyjnego usunięcia, lub DROP IF EXISTS |

## Materialized View (PostgreSQL/Oracle)

Zamiast na każde zapytanie liczyć widok od nowa, możesz go "zamrozić":

```sql
-- PostgreSQL
CREATE MATERIALIZED VIEW mv_sprzedaz_cache AS
SELECT DATE_TRUNC('month', data)::DATE AS dzien, SUM(kwota) AS przychod
FROM zamowienia
GROUP BY DATE_TRUNC('month', data);

-- Odśwież (ręcznie lub w cronie)
REFRESH MATERIALIZED VIEW mv_sprzedaz_cache;

-- Query
SELECT * FROM mv_sprzedaz_cache WHERE dzien > '2024-01-01';
```

Tradeoff: szybsze SELECTy, ale stare dane (aż do `REFRESH`).

## Kiedy VIEW, kiedy nie

**Rób VIEW:**
- Logika biznesowa skomplikowana, powtarzalna
- Potrzebujesz abstrakcji (aplikacja nie powinna znać schemat)
- Segurność (ukryj sensytywne kolumny)

**Nie rób VIEW:**
- Zapytanie jednorazowe, proste
- Performance-critical: raport musi być szybki → lepiej podac na aplikacji lub use `MATERIALIZED VIEW`
- Widok ma zaledwie 1-2 kolumny ze źródła → zbyteczna abstrakcja
