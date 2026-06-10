-- ============================================================
-- PRZYKŁADY DO SERII 1 — SELECT i JOINy (baza: Sakila, MySQL 8)
-- Odpalaj blok po bloku w DataGrip (zaznacz + Ctrl/Cmd+Enter).
-- To NIE są rozwiązania zadań — inne use case'y, te same techniki.
-- ============================================================

-- ------------------------------------------------------------
-- 1. INNER vs LEFT na żywym przykładzie: film i jego kategoria
-- ------------------------------------------------------------
-- INNER: tylko filmy, które MAJĄ kategorię
SELECT f.title, c.name AS kategoria
FROM film f
INNER JOIN film_category fc ON fc.film_id = f.film_id
INNER JOIN category c       ON c.category_id = fc.category_id
LIMIT 10;
-- >> W Sakili każdy film ma kategorię, więc INNER i LEFT dadzą tyle samo.
-- >> Wniosek praktyczny: różnicę INNER/LEFT widać dopiero, gdy dane mają dziury.
--    Zanim wybierzesz typ JOINa, zapytaj: "czy lewa strona może nie mieć pary?"

-- ------------------------------------------------------------
-- 2. Łańcuch JOINów = "paragon" wypożyczenia
-- ------------------------------------------------------------
-- Kto, co, kiedy wypożyczył i ile zapłacił — 5 tabel w jednym zapytaniu.
SELECT c.first_name, c.last_name,
       f.title,
       r.rental_date,
       p.amount
FROM rental r
JOIN customer  c ON c.customer_id  = r.customer_id
JOIN inventory i ON i.inventory_id = r.inventory_id   -- bez inventory ani rusz!
JOIN film      f ON f.film_id      = i.film_id
JOIN payment   p ON p.rental_id    = r.rental_id
ORDER BY r.rental_date
LIMIT 20;
-- >> Zwróć uwagę: film NIGDY nie łączy się z rental bezpośrednio.
-- >> Czytaj łańcuch jak trasę po ERD: rental→inventory→film. Jak się zgubisz,
--    otwórz diagram w DataGrip (prawy klik na schemat → Diagrams).

-- ------------------------------------------------------------
-- 3. Warunek w ON vs w WHERE — to nie to samo przy LEFT JOIN
-- ------------------------------------------------------------
-- Use case: WSZYSCY klienci + ich wypożyczenia, ale tylko z maja 2005.
-- Wersja A: warunek w ON — klienci bez wypożyczeń majowych zostają (z NULL).
SELECT c.customer_id, c.last_name, r.rental_id
FROM customer c
LEFT JOIN rental r ON r.customer_id = c.customer_id
                  AND r.rental_date < '2005-06-01'
LIMIT 20;

-- Wersja B: ten sam warunek w WHERE — klienci bez majowych wypożyczeń ZNIKAJĄ.
SELECT c.customer_id, c.last_name, r.rental_id
FROM customer c
LEFT JOIN rental r ON r.customer_id = c.customer_id
WHERE r.rental_date < '2005-06-01'
LIMIT 20;
-- >> W wersji B NULL < '2005-06-01' daje UNKNOWN → wiersz wypada → LEFT
--    po cichu stał się INNER-em. Najczęstszy bug LEFT JOINów w ogóle.

-- ------------------------------------------------------------
-- 4. CROSS JOIN, który ma sens: szkielet raportu
-- ------------------------------------------------------------
-- Use case: macierz "każdy sklep × każda kategoria", nawet gdy kombinacja
-- nie ma jeszcze żadnych danych (do raportów z zerami).
SELECT s.store_id, c.name AS kategoria
FROM store s
CROSS JOIN category c
ORDER BY s.store_id, c.name;
-- >> 2 sklepy × 16 kategorii = 32 wiersze. CROSS JOIN zwykle jest błędem
--    (zapomniany warunek ON), ale do generowania kombinacji — celowy.

-- ------------------------------------------------------------
-- 5. Fan-out: skąd "duplikaty" po JOINie 1:N
-- ------------------------------------------------------------
SELECT f.title, COUNT(*) AS wierszy_po_joinie
FROM film f
JOIN inventory i ON i.film_id = f.film_id
WHERE f.title = 'ACADEMY DINOSAUR'
GROUP BY f.title;
-- >> Jeden film, wiele kopii w inventory → tyle wierszy, ile kopii.
--    To nie "duplikaty" — to poprawny wynik. Jak chcesz 1 wiersz na film:
--    DISTINCT, GROUP BY albo EXISTS, zależnie od pytania.

-- ------------------------------------------------------------
-- 6. RIGHT JOIN? Przepisz na LEFT i nie cierp
-- ------------------------------------------------------------
-- Te dwa zapytania są równoważne:
SELECT c.name, f.title
FROM film f
RIGHT JOIN film_category fc ON fc.film_id = f.film_id
RIGHT JOIN category c       ON c.category_id = fc.category_id
LIMIT 5;

SELECT c.name, f.title
FROM category c
LEFT JOIN film_category fc ON fc.category_id = c.category_id
LEFT JOIN film f           ON f.film_id = fc.film_id
LIMIT 5;
-- >> Konwencja zawodowa: tabela "która ma zostać w całości" stoi z LEWEJ.
--    RIGHT JOIN czyta się od tyłu — prawie nikt go nie używa w produkcji.
