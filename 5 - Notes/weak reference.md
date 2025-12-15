nie są mocne

zwykła referencja `x = 356   istnieje dopóki istnieje x
słaba -> obiekt może przestać istnieć GC usuwa jak nie ma refki

zwykła referencja -> dopóki obiekt ją ma to GC ją nie usunie
słabe -> służą do śledzenia obiektów, żeby wiedzieć czy on jeszcze istnieje czy nie , nie blokują usunięcia obiektu

jeżeli obiekt istniał ma podpiętą słabą i przestał istnieć to słaba referencja  wskazuje na None 


robimy słabą referencję aby nie trzymać obiektów po ich zakończeniu działania

