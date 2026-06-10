---
title: "Setup Sakila (Docker)"
type: project
topic: bazy-danych
tags: ["sql", "sakila", "docker", "cwiczenia"]
created: 2026-06-10
status: done
źródło: "sesja LLM, Claude Fable 5 + github.com/sakiladb/mysql"
---

# Setup Sakila (Docker)

> [!summary]
> Sakila to przykładowa baza MySQL (wypożyczalnia DVD): ~16 tabel z realnymi relacjami M:N i łańcuchami kluczy obcych. Jedna komenda Dockera stawia gotową bazę do ćwiczeń SQL.

## Uruchomienie

W tym folderze leży `docker-compose.yml`. W terminalu:

```bash
cd ~/obsidian_notes/"5 - Notes"/Bazy-Danych/Cwiczenia-Sakila
docker compose up -d        # start (pierwszy raz pobierze obraz)
docker logs sakila          # czekaj na: "mysqld: ready for connections"
```

Dane dostępowe: baza `sakila`, user `sakila`, hasło `p_ssW0rd`, port `3306`.

## Łączenie się

Bez instalowania klienta MySQL na Macu — wejdź do kontenera:

```bash
docker exec -it sakila mysql -usakila -pp_ssW0rd sakila
```

Test, że żyje:

```sql
SELECT * FROM actor LIMIT 5;
SHOW TABLES;
```

Stop / start / kasowanie:

```bash
docker compose stop     # zatrzymaj (dane zostają)
docker compose start    # wznów
docker compose down     # usuń kontener (obraz zostaje, baza wróci świeża przy up)
```

> [!tip]
> Baza w kontenerze jest jednorazowa — jak coś zepsujesz (`DROP TABLE`...), `docker compose down && docker compose up -d` przywraca stan fabryczny. Eksperymentuj bez strachu.

## Mapa schematu (co z czym łączyć)

Rdzeń wypożyczalni:

- `film` — tytuły (rating, length, rental_rate, language_id)
- `actor` ↔ `film_actor` ↔ `film` — kto gra w czym (M:N)
- `category` ↔ `film_category` ↔ `film` — gatunki (M:N)
- `inventory` — fizyczne kopie filmu w sklepie (`film_id`, `store_id`)
- `rental` — wypożyczenie kopii (`inventory_id`, `customer_id`, `rental_date`, `return_date`)
- `payment` — płatność (`customer_id`, `rental_id`, `amount`, `payment_date`)
- `customer` → `address` → `city` → `country` — łańcuch adresowy
- `store`, `staff`, `language`

> [!warning]
> Film NIE łączy się z wypożyczeniem bezpośrednio: zawsze `film → inventory → rental`. Pominięcie `inventory` to najczęstszy błąd w zapytaniach na Sakili — wyniki wyglądają sensownie, ale są błędne.

## Jak ćwiczyć

Serie zadań leżą obok (Seria 1–4, od ★ do ★★★★). Zasady w [[AGENTS.md]] (operacja `ćwicz`): najpierw rozwiązujesz **sam** w kontenerze, dopiero potem agent sprawdza. Wnioski i błędy wracają do notatek koncepcji jako `[!warning]`/`[!tip]`.

## Połączenia

- [[00 — MOC SQL (zapytania)]] — koncepcje, które te ćwiczenia utrwalają
- [[Klucz główny i obcy]] — cały schemat Sakili to lekcja kluczy obcych w praktyce
- [[JOIN — typy i co zwracają]] — bez JOIN-ów w Sakili nie zrobisz nic sensownego
