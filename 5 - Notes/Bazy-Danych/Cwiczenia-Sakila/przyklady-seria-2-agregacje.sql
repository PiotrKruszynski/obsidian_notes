-- ============================================================
-- PRZYKŁADY DO SERII 2 — Agregacje i GROUP BY (Sakila, MySQL 8)
-- Odpalaj blok po bloku. Inne use case'y niż zadania serii.
-- ============================================================

-- ------------------------------------------------------------
-- 1. GROUP BY po dwóch kolumnach = grupy z kombinacji
-- ------------------------------------------------------------
-- Use case: ile filmów ma każdy sklep w każdym ratingu.
SELECT i.store_id, f.rating, COUNT(*) AS kopie
FROM inventory i
JOIN film f ON f.film_id = i.film_id
GROUP BY i.store_id, f.rating
ORDER BY i.store_id, kopie DESC;
-- >> Grupa = unikalna PARA (store_id, rating). Tyle wierszy wyniku,
--    ile realnie istniejących kombinacji — nie iloczyn wszystkich możliwych.

-- ------------------------------------------------------------
-- 2. Pivot przez conditional aggregation (CASE w środku SUM)
-- ------------------------------------------------------------
-- Use case: sklepy w wierszach, ratingi w KOLUMNACH (raport "szeroki").
SELECT i.store_id,
       SUM(CASE WHEN f.rating = 'G'     THEN 1 ELSE 0 END) AS rating_G,
       SUM(CASE WHEN f.rating = 'PG'    THEN 1 ELSE 0 END) AS rating_PG,
       SUM(CASE WHEN f.rating = 'PG-13' THEN 1 ELSE 0 END) AS rating_PG13,
       SUM(CASE WHEN f.rating = 'R'     THEN 1 ELSE 0 END) AS rating_R,
       SUM(CASE WHEN f.rating = 'NC-17' THEN 1 ELSE 0 END) AS rating_NC17
FROM inventory i
JOIN film f ON f.film_id = i.film_id
GROUP BY i.store_id;
-- >> MySQL nie ma operatora PIVOT — to standardowy zamiennik.
-- >> Jeden skan tabeli zamiast pięciu zapytań z WHERE rating = ...

-- ------------------------------------------------------------
-- 3. GROUP_CONCAT — agregat, który skleja tekst (specjalność MySQL)
-- ------------------------------------------------------------
-- Use case: obsada filmu w JEDNEJ kolumnie, zamiast wiersza na aktora.
SELECT f.title,
       GROUP_CONCAT(a.last_name ORDER BY a.last_name SEPARATOR ', ') AS obsada
FROM film f
JOIN film_actor fa ON fa.film_id = f.film_id
JOIN actor a       ON a.actor_id = fa.actor_id
GROUP BY f.title
LIMIT 10;
-- >> Świetne do raportów i debugowania relacji M:N.
-- >> Uwaga: domyślny limit długości (group_concat_max_len = 1024 bajty) —
--    przy długich listach wynik się utnie PO CICHU.

-- ------------------------------------------------------------
-- 4. WITH ROLLUP — sumy częściowe i suma całkowita gratis
-- ------------------------------------------------------------
-- Use case: przychód per sklep per rok + podsumowania.
SELECT i.store_id, YEAR(p.payment_date) AS rok, SUM(p.amount) AS przychod
FROM payment p
JOIN rental r    ON r.rental_id = p.rental_id
JOIN inventory i ON i.inventory_id = r.inventory_id
GROUP BY i.store_id, YEAR(p.payment_date) WITH ROLLUP;
-- >> Wiersze z NULL w kolumnach grupujących to PODSUMOWANIA (subtotale
--    i total na końcu), nie brakujące dane. Rozpoznasz je po NULL-ach.

-- ------------------------------------------------------------
-- 5. COUNT(DISTINCT ...) — liczenie "ilu różnych"
-- ------------------------------------------------------------
-- Use case: ilu RÓŻNYCH klientów obsłużył każdy pracownik.
SELECT s.staff_id, s.first_name,
       COUNT(*)                   AS wypozyczen,
       COUNT(DISTINCT r.customer_id) AS roznych_klientow
FROM staff s
JOIN rental r ON r.staff_id = s.staff_id
GROUP BY s.staff_id, s.first_name;
-- >> COUNT(*) liczy transakcje, COUNT(DISTINCT customer_id) — unikalnych ludzi.
--    Te dwie liczby odpowiadają na zupełnie różne pytania biznesowe.

-- ------------------------------------------------------------
-- 6. Agregacja po WYRAŻENIU, nie po kolumnie
-- ------------------------------------------------------------
-- Use case: o których godzinach dnia kasa najbardziej "chodzi".
SELECT HOUR(p.payment_date) AS godzina,
       COUNT(*)             AS platnosci,
       ROUND(SUM(p.amount)) AS przychod
FROM payment p
GROUP BY HOUR(p.payment_date)
ORDER BY przychod DESC;
-- >> Grupować można po dowolnym wyrażeniu (funkcji na kolumnie).
-- >> Pamiętaj: w SELECT albo to samo wyrażenie, albo agregat — nic "luzem".

-- ------------------------------------------------------------
-- 7. Średnia ze średnich ≠ średnia (klasyczna pułapka raportowa)
-- ------------------------------------------------------------
-- Średnia płatność per klient, a potem średnia z tych średnich:
SELECT AVG(avg_klienta) AS srednia_srednich
FROM (
  SELECT customer_id, AVG(amount) AS avg_klienta
  FROM payment
  GROUP BY customer_id
) t;

-- ...kontra zwykła średnia wszystkich płatności:
SELECT AVG(amount) AS srednia_globalna FROM payment;
-- >> Wyniki się RÓŻNIĄ, bo klienci mają różną liczbę płatności (wagi!).
--    "Średnia ze średnich" nadaje każdemu klientowi tę samą wagę.
--    Na rozmowie i w raportach: zawsze pytaj, KTÓRĄ średnią ktoś chce.
