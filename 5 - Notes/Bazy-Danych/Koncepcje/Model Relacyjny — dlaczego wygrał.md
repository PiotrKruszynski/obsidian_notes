# Model Relacyjny — dlaczego wygrał

> [!summary]
> Model relacyjny wygrał, bo ukrywa ścieżki dostępu za optymalizatorem — programista mówi CO chce, nie JAK tego szukać.

## Problem poprzedników

W latach 60-70. bazy hierarchiczne (IMS) i sieciowe (CODASYL) wymagały, żeby programista **ręcznie nawigował** po ścieżkach dostępu — jak chodzenie po labiryncie ze wskaźnikami.

> [!warning]
> W modelu sieciowym (CODASYL) jedyną drogą do rekordu był fizyczny `access path` — łańcuch wskaźników. Jeśli chciałeś zapytać o dane inną drogą niż zaplanowana przy projektowaniu schematu, musiałeś przepisać **cały kod aplikacji**. Zmiana schematu = miesiące pracy.

## Co zrobił model relacyjny

Relacja (tabela) to po prostu zbiór krotek (wierszy). Zero zagnieżdżonych struktur, zero ścieżek. Możesz czytać dowolne wiersze pasujące do warunku.

Kluczowy przełom: **query optimizer**. Zamiast ręcznego prowadzenia przez ścieżki — deklarujesz wynik, baza decyduje jak go osiągnąć.

> [!tip]
> Analogia: model sieciowy to GPS, który mówi "skręć w lewo, potem w prawo, 200m prosto" (imperatywne). SQL to nawigacja, której mówisz "chcę być na ul. Królewskiej 5" i ona sama planuje trasę (deklaratywne).

## Dlaczego to wygodne w praktyce

- Nowy indeks → stare zapytania automatycznie go używają (bez przepisywania kodu)
- Query optimizer budowany raz, korzystają wszyscy użytkownicy bazy
- Łatwo dodawać nowe kolumny i relacje bez psucia istniejących zapytań

## Połączenia
- [[Model relacyjny]] — praktyczne podstawy: tabele, wiersze, kolumny

- [[SQL jako język deklaratywny]] — deklaratywność to bezpośrednia konsekwencja tego modelu
- [[Indeks — jak działa i kiedy pomaga|Indeks — koszt i korzyść]] — właśnie dlatego można dodawać indeksy bez zmiany zapytań
- [[B-Tree — jak SQL przechowuje dane]] — fizyczna implementacja tabel i indeksów
- [[Kiedy SQL, kiedy NoSQL]] — historia pokazuje, że poprzednicy modelu relacyjnego mają nowych następców (dokumentowe bazy)
