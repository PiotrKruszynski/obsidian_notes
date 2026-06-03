# JOIN — siła relacyjnego modelu

> [!summary]
> JOIN przeniesiony do bazy to główna przewaga modelu relacyjnego nad dokumentowym (NoSQL). Kleppmann: w modelu dokumentowym powiązania many-to-one i many-to-many są słabe — musisz emulować JOIN w kodzie aplikacji, co jest wolniejsze i bardziej podatne na błędy.

## Na czym polega przewaga

W modelu relacyjnym mówisz „połącz te tabele po kluczu", a **optymalizator** decyduje, jak to zrobić ([[SQL jako język deklaratywny]]). W modelu dokumentowym (np. baza dokumentów JSON) nie ma natywnego JOIN-a — masz dwie drogi, obie gorsze:

- **JOIN w kodzie aplikacji** — pobierasz dokument, czytasz z niego ID, robisz kolejne zapytanie, sklejasz w pamięci. Wiele round-tripów, ręczna robota, łatwo o błąd.
- **Denormalizacja** — wklejasz powiązane dane do dokumentu. Szybki odczyt, ale powtarzasz fakty i masz problem z aktualizacją ([[Normalizacja vs Denormalizacja]]).

## Dlaczego to ważne przy typach relacji

- **many-to-one** (wiele zamówień → jeden użytkownik): w relacyjnym to zwykły [[Klucz główny i obcy|FK]] + JOIN. W dokumentowym — albo duplikujesz dane użytkownika w każdym zamówieniu, albo łączysz w aplikacji.
- **many-to-many** (studenci ↔ kursy): w relacyjnym tabela łącząca + dwa JOIN-y. W dokumentowym — bardzo niewygodne; to klasyczny moment, w którym ludzie wracają do baz relacyjnych.

> [!example]
> Aplikacja z CV: doświadczenie zawodowe, wykształcenie, kontakty. Dokument (jeden JSON na osobę) świetnie pasuje do danych czytanych razem — to **locality**. Ale gdy dochodzą rekomendacje („kto polecił kogo") czyli many-to-many — model dokumentowy zaczyna się sypać, a relacyjny robi to jednym JOIN-em.

> [!warning]
> „NoSQL nie ma JOIN-ów" bywa podawane jako zaleta (prostota), ale to przerzucenie kosztu na aplikację. Gdy dane mają dużo powiązań, brak JOIN-a w bazie staje się wadą — stąd renesans relacyjnych i baz „NewSQL".

## Połączenia

- [[JOIN — typy i co zwracają]] — jak JOIN wygląda w praktyce (składnia, INNER/LEFT)
- [[Kiedy SQL, kiedy NoSQL]] — relacje to częsty argument za SQL
- [[Normalizacja vs Denormalizacja]] — alternatywa dla JOIN-a: wklejanie danych
- [[SQL jako język deklaratywny]] — optymalizator decyduje, jak wykonać JOIN
- [[Model Relacyjny — dlaczego wygrał]] — szerszy kontekst przewagi modelu
