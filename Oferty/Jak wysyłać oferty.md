# Jak wysyłać oferty (z Claude)

## Co tydzień — 3 kroki

1. **Przychodzi zapytanie na Gmail.** Otwierasz Cowork i piszesz np.:
   > Przygotuj ofertę dla Inter Grass — zapytanie w Gmailu od import@intergrass.pl. Badania: wysokość włókna 500, grubość 600, skład 950. Rabat 10%, termin 14 dni.
   
   Jeśli nie podasz szczegółów, Claude znajdzie wątek w Gmailu i zaproponuje zakres do potwierdzenia.

2. **Claude robi resztę:**
   - wypełnia szablon (badania albo ekspertyza), liczy sumę, rabat i kwotę słownie,
   - zapisuje DOCX + PDF w `Oferty/Wysłane/`,
   - dopisuje wiersz w rejestrze z kolejnym numerem oferty,
   - tworzy szkic odpowiedzi w Twoim Gmailu.

3. **Ty:** otwierasz szkic w Gmailu, **dołączasz PDF ręcznie** (konektor Gmail nie obsługuje jeszcze załączników w szkicach) i klikasz Wyślij. Potem napisz Claude „wysłana" — status w rejestrze się zaktualizuje.

## Pliki

| Co | Gdzie |
|---|---|
| Szablony (pola na żółto = do podmiany) | `Oferty/Szablony/` |
| Rejestr ofert + historia klientów | `Oferty/Rejestr ofert i klientów.xlsx` |
| Wysłane oferty | `Oferty/Wysłane/` |
| Przykład wypełnionej oferty | `Oferty/Przykład - wypełniona oferta (test).pdf` |

Numeracja ofert: `NNN/B/RRRR` (badania) lub `NNN/E/RRRR` (ekspertyza), np. `012/B/2026`.

## Szablon maila przewodniego

> Temat: Oferta nr [NR] – Unilab Centrum Badawcze
>
> Dzień dobry,
>
> w nawiązaniu do zapytania z dnia [DATA] przesyłam w załączeniu ofertę nr [NR] na [ZAKRES].
> Oferta ważna jest 30 dni. W razie pytań pozostaję do dyspozycji.
>
> Z poważaniem
> Piotr Kruszyński
> Unilab Centrum Badawcze Sp. z o.o. | tel. 502 500 391

## Na życzenie mogę też

- co tydzień sprawdzać oferty bez odpowiedzi po 14 dniach i przypominać (zadanie cykliczne),
- dokończyć import historii klientów (foldery / Gmail),
- prowadzić cennik badań, żeby ceny wstawiały się same.
