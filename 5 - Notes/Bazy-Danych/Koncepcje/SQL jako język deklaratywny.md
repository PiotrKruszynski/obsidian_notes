# SQL jako język deklaratywny

> [!summary]
> SQL jest deklaratywny — opisujesz WYNIK, nie algorytm. Baza sama wybiera plan wykonania. To nie komfort składni, to fundamentalna architektura.

## Co to znaczy deklaratywny

**Imperatywny kod** (stary CODASYL, aplikacyjny kod):
```python
results = []
for user in users:
    if user.country == "PL":
        for order in get_orders(user.id):
            results.append(order)
```

**Deklaratywny SQL**:
```sql
SELECT * FROM orders WHERE user_country = 'PL';
```

W deklaratywnym: mówisz CO chcesz. Baza decyduje JAK.

## Dlaczego to ważne dla wydajności

> [!example]
> Masz tabelę `orders` z 10 mln wierszy. Dodajesz indeks na `user_country`.
> - Stare zapytanie SQL → automatycznie zacznie używać indeksu. Bez zmiany kodu.
> - Imperatywny kod aplikacji → musisz go przepisać, żeby korzystał z nowej struktury.

Optymalizator może też:
- zmienić kolejność JOINów
- wybrać między hash join, merge join, nested loop
- wykorzystać równoległe przetwarzanie (wiele rdzeni)

> [!warning]
> SQL gwarantuje wynik, nie kolejność operacji. Jeśli piszesz kod aplikacyjny zakładający konkretną kolejność zwracanych wierszy bez `ORDER BY` — to błąd. SQL nie obiecuje porządku bez jawnego `ORDER BY`.

## Równoległość jako bonus

Deklaratywne języki łatwiej zrównoleglić, bo nie ma narzuconych zależności między krokami. Imperatywny kod trudno zrównoleglić, bo krok 2 może zależeć od kroku 1.

## Połączenia
- [[Logiczna kolejność wykonania zapytania]] — jak SQL faktycznie przetwarza zapytanie

- [[Model Relacyjny — dlaczego wygrał]] — deklaratywność wynika z filozofii modelu relacyjnego
- [[Indeks — jak działa i kiedy pomaga|Indeks — koszt i korzyść]] — optymalizator automatycznie używa indeksów
- [[B-Tree — jak SQL przechowuje dane]] — query plan często opiera się na B-Tree
