źródło: sesja LLM, model nieznany, 2026-06-12

Rutyna (raz na miesiąc-dwa)
zshuv self update        # aktualizuje samo uv
uv python upgrade     # podnosi wszystkie zainstalowane Pythony do najnowszych łatek
uv python upgrade działa w obrębie linii: 3.14.6 → 3.14.7 → 3.14.8 itd. To łatki bezpieczeństwa i bugfixy — zawsze bezpieczne, nic nie psują.
Nowa linia (raz w roku, w październiku)
Python wydaje nową wersję główną co roku — 3.15 wyjdzie w październiku 2026. Nowa linia to świadoma decyzja, nie automat:
zshuv python install 3.15
Stara zostaje obok — projekty na 3.14 dalej działają. Globalny default zmieniasz, kiedy chcesz:
zshuv python install 3.15 --default --preview
W projektach
Wersję projektu pinuje plik .python-version (tworzy go uv init). Chcesz podnieść projekt na nowszą linię:
zshcd projekt
uv python pin 3.15
uv sync               # przebuduje venv na nowej wersji
# odpal testy — jak zielone, commitujesz
Czego NIE robić

❌ Instalator z python.org — nigdy więcej (wiesz już dlaczego)
❌ brew install python — brew może go sam dociągnąć jako zależność innej paczki, to ok, ale Ty go nie używasz
❌ Aktualizować /usr/bin/python3 — Apple sam, przy aktualizacjach macOS