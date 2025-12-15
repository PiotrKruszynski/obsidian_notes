iterator

tworzony przez yield expression

zatrzymuje i wznawia swój stan (execution frame + wszystkie lokalne zmienne + wskaźnik instruction pointer)

- **yield** – zwraca wartość i zawiesza stan funkcji. Interpreter przy kolejnym wywołaniu .send() lub next() wznawia działanie od miejsca zawieszenia.

- **Generator object** – obiekt, który implementuje protokół **iteratora**: posiada metody __iter__() i __next__().

- **send(value)** – wstrzykuje wartość do generatora, zastępując wynik wyrażenia yield.
    
- **throw()** – pozwala “wrzucić” wyjątek do generatora w miejscu, gdzie jest yield.
    
- **close()** – kończy generator, podnosząc GeneratorExit.
