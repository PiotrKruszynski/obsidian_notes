---
tags: ["sql"]
powiązane: ["[[Klucz główny i obcy]]", "[[Normalizacja (1NF, 2NF, 3NF)]]"]
---

# Model relacyjny

> [!summary] W jednym zdaniu
> Baza relacyjna to zbiór **tabel** (relacji), gdzie wiersz to jeden rekord, kolumna to jeden atrybut, a powiązania między tabelami realizują **klucze** — nie zagnieżdżenie.

Trzy pojęcia, na których stoi wszystko inne:
- **Tabela (relacja)** — zbiór wierszy o tym samym zestawie kolumn. Np. `users(id, name, email)`.
- **Wiersz (rekord/krotka)** — jeden konkretny byt: jeden użytkownik.
- **Kolumna (atrybut)** — jedna cecha o ustalonym typie: `email` to tekst, `id` to liczba.

Kluczowa idea modelu relacyjnego: dane są **płaskie i połączone przez wartości**, nie przez zagnieżdżanie. Zamiast trzymać zamówienia "wewnątrz" użytkownika (jak w dokumencie JSON), masz osobną tabelę `orders` z kolumną `user_id`, która wskazuje na `users.id`. To powiązanie realizuje [[Klucz główny i obcy|klucz obcy]], a łączysz je w zapytaniu przez [[JOIN — typy i co zwracają|JOIN]].

> [!tip] Czemu to ważne na rozmowie
> Pytania typu "czym różni się baza relacyjna od NoSQL" sprowadzają się do tego: relacyjna wymusza schemat (kolumny, typy) i łączy dane przez klucze/JOIN-y, dając spójność kosztem sztywności. To punkt wyjścia do [[Normalizacja (1NF, 2NF, 3NF)|normalizacji]].

## Połączenia
- [[Model Relacyjny — dlaczego wygrał]] — perspektywa historyczna (DDIA)
- [[Kiedy SQL, kiedy NoSQL]] — kiedy model relacyjny przestaje pasować
- [[Impedance Mismatch — SQL a obiekty]] — tarcie między tabelami a obiektami
- [[Klucz główny i obcy]] — jak tabele się wiążą
- [[Normalizacja (1NF, 2NF, 3NF)]] — jak rozkładać dane na tabele
