-- ============================================================
-- PRZYKŁADY DO SERII 3 — Podzapytania i CTE (Sakila, MySQL 8)
-- Odpalaj blok po bloku. Inne use case'y niż zadania serii.
-- ============================================================

-- ------------------------------------------------------------
-- 1. Podzapytanie w SELECT (skalarne per wiersz)
-- ------------------------------------------------------------
-- Use case: każdy film + ile ma kopii w magazynach.
SELECT f.title,
       (SELECT COUNT(*) FROM inventory i WHERE i.film_id = f.film_id) AS kopii
FROM film f
LIMIT 10;
-- >> Czytelne, ale to podzapytanie SKORELOWANE — wykonuje się dla każdego
--    wiersza film. Na 1000 filmów ujdzie; na milionach przepisz na
--    LEFT JOIN + GROUP BY. Sprawdź EXPLAIN na obu wersjach.

-- ------------------------------------------------------------
-- 2. Podzapytanie w FROM (derived table) — "tabela w locie"
-- ------------------------------------------------------------
-- Use case: średnia z sum — najpierw policz sumy per klient, potem średnią.
SELECT ROUND(AVG(suma), 2) AS srednie_wydatki_klienta
FROM (
  SELECT customer_id, SUM(amount) AS suma
  FROM payment
  GROUP BY customer_id
) wydatki;
-- >> Derived table MUSI mieć alias (tu: wydatki) — inaczej błąd składni.
-- >> Dwa poziomy agregacji nie mieszczą się w jednym SELECT — stąd ten wzorzec.

-- ------------------------------------------------------------
-- 3. To samo jako CTE — porównaj czytelność
-- ------------------------------------------------------------
WITH wydatki AS (
  SELECT customer_id, SUM(amount) AS suma
  FROM payment
  GROUP BY customer_id
)
SELECT ROUND(AVG(suma), 2) AS srednie_wydatki_klienta
FROM wydatki;
-- >> Logika identyczna, ale czyta się Z GÓRY NA DÓŁ jak przepis,
--    a nie od środka jak cebulę. Przy 2+ poziomach CTE wygrywa zawsze.

-- ------------------------------------------------------------
-- 4. Lejek z kilku CTE — krok po kroku jak pipeline
-- ------------------------------------------------------------
-- Use case: znajdź "weekendowych kinomaniaków" — klientów, którzy
-- wypożyczają głównie w sobotę/niedzielę.
WITH wypozyczenia AS (
  SELECT customer_id,
         SUM(DAYOFWEEK(rental_date) IN (1, 7)) AS weekendowe,  -- 1=Nd, 7=Sob
         COUNT(*)                              AS wszystkie
  FROM rental
  GROUP BY customer_id
),
profil AS (
  SELECT customer_id,
         weekendowe / wszystkie AS udzial_weekendu
  FROM wypozyczenia
  WHERE wszystkie >= 20            -- odsiej przypadkowych
)
SELECT c.first_name, c.last_name,
       ROUND(p.udzial_weekendu * 100) AS procent_weekend
FROM profil p
JOIN customer c ON c.customer_id = p.customer_id
ORDER BY p.udzial_weekendu DESC
LIMIT 10;
-- >> Każde CTE = jeden krok myślowy z nazwą. Debugujesz krokami:
--    podmień końcowy SELECT na SELECT * FROM wypozyczenia i patrz.
-- >> Bonus MySQL: SUM(warunek) liczy TRUE jako 1 — skrót na COUNT warunkowy.

-- ------------------------------------------------------------
-- 5. EXISTS jako półzłącze (semi-join): "czy ma chociaż jeden"
-- ------------------------------------------------------------
-- Use case: kategorie, w których jest przynajmniej jeden film 3h+.
SELECT c.name
FROM category c
WHERE EXISTS (
  SELECT 1
  FROM film_category fc
  JOIN film f ON f.film_id = fc.film_id
  WHERE fc.category_id = c.category_id
    AND f.length >= 180
);
-- >> EXISTS zwraca kategorię RAZ, niezależnie ile filmów spełnia warunek.
--    JOIN dałby duplikaty do odsiania DISTINCT-em. "Czy istnieje" → EXISTS.

-- ------------------------------------------------------------
-- 6. WITH RECURSIVE — generator, którego nie ma w danych
-- ------------------------------------------------------------
-- Use case: liczby 1..12 bez żadnej tabeli (MySQL nie ma generate_series).
WITH RECURSIVE liczby AS (
  SELECT 1 AS n                 -- baza rekurencji
  UNION ALL
  SELECT n + 1 FROM liczby      -- krok: poprzedni wynik + 1
  WHERE n < 12                  -- warunek stopu — BEZ niego pętla!
)
SELECT n FROM liczby;
-- >> Schemat zawsze ten sam: baza UNION ALL krok WHERE stop.
-- >> Tak samo generuje się daty (DATE_ADD w kroku) — przyda Ci się w Z7.

-- ------------------------------------------------------------
-- 7. ANY / ALL — porównania ze zbiorem (rzadziej znane)
-- ------------------------------------------------------------
-- Filmy droższe niż KAŻDY film z kategorii 'Classics' (czyli > MAX z niej):
SELECT f.title, f.rental_rate
FROM film f
WHERE f.rental_rate > ALL (
  SELECT f2.rental_rate
  FROM film f2
  JOIN film_category fc ON fc.film_id = f2.film_id
  JOIN category c       ON c.category_id = fc.category_id
  WHERE c.name = 'Classics'
)
LIMIT 10;
-- >> x > ALL(zbiór) ≈ x > MAX(zbiór); x > ANY(zbiór) ≈ x > MIN(zbiór).
--    Czytelniejsze bywa jawne MAX/MIN — ale ANY/ALL pada na testach.
-- >> Pułapka: jeśli zbiór zawiera NULL, ALL może dać UNKNOWN — znowu NULL-e!
