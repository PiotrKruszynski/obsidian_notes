-- ============================================================
-- PRZYKŁADY DO SERII 4 — Window functions (Sakila, MySQL 8)
-- Odpalaj blok po bloku. Inne use case'y niż zadania serii.
-- ============================================================

-- ------------------------------------------------------------
-- 1. Okno bez PARTITION i ORDER = cała tabela jako kontekst
-- ------------------------------------------------------------
-- Use case: każdy film na tle całości — bez zwijania wierszy.
SELECT title, rental_rate,
       ROUND(AVG(rental_rate) OVER (), 2)              AS srednia_calosci,
       ROUND(rental_rate - AVG(rental_rate) OVER (), 2) AS odchylka
FROM film
LIMIT 10;
-- >> OVER () = okno obejmuje WSZYSTKIE wiersze. Każdy film dostaje
--    tę samą średnią obok siebie. GROUP BY zwinąłby to do 1 wiersza.

-- ------------------------------------------------------------
-- 2. Miesiąc do miesiąca (MoM) przez LAG — klasyka raportów
-- ------------------------------------------------------------
WITH miesiecznie AS (
  SELECT DATE_FORMAT(payment_date, '%Y-%m') AS miesiac,
         SUM(amount) AS przychod
  FROM payment
  GROUP BY DATE_FORMAT(payment_date, '%Y-%m')
)
SELECT miesiac, przychod,
       LAG(przychod) OVER (ORDER BY miesiac)             AS poprzedni,
       ROUND(przychod - LAG(przychod) OVER (ORDER BY miesiac), 2) AS zmiana
FROM miesiecznie;
-- >> LAG sięga do POPRZEDNIEGO wiersza wg ORDER BY w oknie. Pierwszy
--    miesiąc ma NULL (nie ma poprzednika) — i to poprawna odpowiedź.
-- >> Wzorzec: agregacja w CTE, okno na zagregowanym. Okno na surowych
--    wierszach payment liczyłoby co innego!

-- ------------------------------------------------------------
-- 3. Deduplikacja przez ROW_NUMBER — use case nr 1 w produkcji
-- ------------------------------------------------------------
-- Use case: OSTATNIA płatność każdego klienta (jeden wiersz na klienta).
WITH ponumerowane AS (
  SELECT customer_id, amount, payment_date,
         ROW_NUMBER() OVER (PARTITION BY customer_id
                            ORDER BY payment_date DESC) AS rn
  FROM payment
)
SELECT customer_id, amount, payment_date
FROM ponumerowane
WHERE rn = 1
LIMIT 10;
-- >> "Najnowszy/największy/pierwszy wiersz per grupa" = ROW_NUMBER + rn = 1.
--    Ten sam wzorzec usuwa duplikaty z brudnych danych (rn > 1 → do kasacji).

-- ------------------------------------------------------------
-- 4. Ramka okna (frame) — pułapka domyślności
-- ------------------------------------------------------------
-- Use case: średnia krocząca z 7 ostatnich dni przychodu.
WITH dziennie AS (
  SELECT DATE(payment_date) AS dzien, SUM(amount) AS przychod
  FROM payment
  GROUP BY DATE(payment_date)
)
SELECT dzien, przychod,
       ROUND(AVG(przychod) OVER (
         ORDER BY dzien
         ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
       ), 2) AS srednia_7dni
FROM dziennie
LIMIT 20;
-- >> ROWS BETWEEN ... definiuje RAMKĘ: które wiersze okna wchodzą do liczenia.
-- >> Pułapka: samo ORDER BY w OVER daje domyślną ramkę "od początku do
--    bieżącego" (running), a NIE całe okno. Stąd dziwne wyniki MAX/LAST_VALUE
--    z ORDER BY — zawsze pomyśl o ramce, gdy dodajesz ORDER BY do okna.

-- ------------------------------------------------------------
-- 5. NTILE — segmentacja klientów (mini-RFM)
-- ------------------------------------------------------------
-- Use case: podziel klientów na 4 segmenty wg wydatków (1 = top 25%).
WITH wydatki AS (
  SELECT customer_id, SUM(amount) AS suma
  FROM payment
  GROUP BY customer_id
)
SELECT customer_id, suma,
       NTILE(4) OVER (ORDER BY suma DESC) AS segment
FROM wydatki
ORDER BY suma DESC
LIMIT 20;
-- >> NTILE(4) tnie posortowane wiersze na 4 możliwie równe koszyki.
--    Marketingowe "podziel bazę na kwartyle" to dosłownie jedna funkcja.

-- ------------------------------------------------------------
-- 6. Named WINDOW — nie powtarzaj definicji okna
-- ------------------------------------------------------------
SELECT title, rating, rental_rate,
       RANK()       OVER w AS rnk,
       DENSE_RANK() OVER w AS drnk,
       ROW_NUMBER() OVER w AS rn
FROM film
WINDOW w AS (PARTITION BY rating ORDER BY rental_rate DESC)
LIMIT 15;
-- >> Trzy funkcje, jedna definicja okna (klauzula WINDOW po FROM/WHERE).
-- >> Przy okazji widać różnicę przy remisach: RANK robi dziury (1,2,2,4),
--    DENSE_RANK nie (1,2,2,3), ROW_NUMBER ignoruje remisy (1,2,3,4).

-- ------------------------------------------------------------
-- 7. Procent grupy bez podzapytań — okno w arytmetyce
-- ------------------------------------------------------------
-- Use case: udział każdego sklepu w przychodzie, jedna linijka logiki.
SELECT i.store_id,
       SUM(p.amount) AS przychod,
       ROUND(100 * SUM(p.amount) / SUM(SUM(p.amount)) OVER (), 1) AS procent
FROM payment p
JOIN rental r    ON r.rental_id = p.rental_id
JOIN inventory i ON i.inventory_id = r.inventory_id
GROUP BY i.store_id;
-- >> SUM(SUM(...)) OVER () wygląda dziwnie, ale jest legalne: wewnętrzny SUM
--    to agregat GROUP BY, zewnętrzny — okno PO agregacji (suma sum sklepów).
--    Kolejność: GROUP BY najpierw, okna potem (notatka: Logiczna kolejność wykonania zapytania).
