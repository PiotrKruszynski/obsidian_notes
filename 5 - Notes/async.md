przez race condition nie może działać domyślnie. race condition rozumiem jak koparka wywrotka. 

Race condition to **błąd współbieżności**, który występuje, gdy **wynik programu zależy od nieprzewidywalnego przeplotu (interleaving)** instrukcji wykonywanych współbieżnie przez różne “wątki” kontroli. W Pythonie może to dotyczyć:

- _threading (wątki)_
    
- _asyncio (zadania asynchroniczne)_
    
- _multiprocessing (procesy)_

[[event loop]] - mechanizm (generator nieskończony), aby mógł przenosić na [[call stack]], korzyta z [[queue]]
