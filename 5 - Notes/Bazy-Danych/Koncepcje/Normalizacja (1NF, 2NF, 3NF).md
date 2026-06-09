---
tags: ["design-patterns", "sql"]
powiązane: ["[[Model relacyjny]]", "[[Klucz główny i obcy]]"]
---

# Normalizacja (1NF, 2NF, 3NF)

> [!summary] W jednym zdaniu
> Normalizacja to rozkładanie danych na tabele tak, by każdy fakt był zapisany **raz** — eliminuje powtarzanie i anomalie aktualizacji, kosztem większej liczby [[JOIN — typy i co zwracają|JOIN]]-ów.

Trzy postaci, które warto umieć opisać po ludzku (nie formalnie):

- **1NF** — każda komórka trzyma jedną, atomową wartość; żadnych list w polu. Zamiast `phones = "111, 222"` → osobne wiersze/tabela telefonów.
- **2NF** — 1NF + każda kolumna niekluczowa zależy od **całego** klucza głównego, nie od jego części (dotyczy kluczy złożonych). Jeśli `(order_id, product_id)` to klucz, a `product_name` zależy tylko od `product_id` — wydziel produkty do osobnej tabeli.
- **3NF** — 2NF + brak zależności **przechodnich**: kolumna niekluczowa nie zależy od innej niekluczowej. Jeśli `zip_code` wyznacza `city`, to `city` nie powinno wisieć w tabeli zamówień — wydziel.

Cel wszystkich trzech ten sam: **jeden fakt w jednym miejscu**. Dzięki temu zmiana nazwy produktu to jeden UPDATE, a nie tysiąc.

> [!tip] Normalizacja vs denormalizacja na rozmowie
> "Normalizujesz, by uniknąć powtórzeń i anomalii; **denormalizujesz** celowo (np. w hurtowniach/analityce), by uniknąć kosztownych JOIN-ów i przyspieszyć odczyt." Ta para to częste pytanie — pokazuje, że rozumiesz kompromis, a nie tylko regułkę.

> [!warning] Nie recytuj definicji formalnych
> Rozmówca zwykle chce zrozumienia, nie formalnej definicji zależności funkcyjnych. Powiedz "1NF: atomowe wartości; 2NF/3NF: każda kolumna zależy od całego klucza i tylko od klucza" + przykład anomalii.

## Połączenia
- [[Normalizacja vs Denormalizacja]] — kompromis wydajnościowy (DDIA)
- [[Model relacyjny]] — po co w ogóle dzielić na tabele
- [[Klucz główny i obcy]] — normalizacja kręci się wokół kluczy
