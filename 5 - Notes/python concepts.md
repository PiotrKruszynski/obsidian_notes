  
----------------------------------------------------------------------------------  
  
1. **interpreted** + just in time compilation 
  
jak nie wiadomo o co chodzi, to chodzi o wydajność
  
----------------------------------------------------------------------------------  
2. **dynamic typing** [[duck typing]] - działa na podstawie protokołów  

nie wymaga podania typu zmiennej x = 42
TYPINGS -> Gentelman Agreement  
  
x: int = 42  
x = "tekst"  # ✅ Działa  
  
----------------------------------------------------------------------------------  
  
3. **Strong typing**  
  
[[variable]] = nazwana referencja do obiektu w pamięci  

python nie wykonuje coercion (niejawnej konwersji) między niekompatybilnymi typami.
  
Jest tak, że :
w [[strong typing ]]niemożliwe jest nadpisywanie typów.  

W pythonie jest to możliwe ponieważ zmienna to identyfikator do miejsca w pamięci RAM  
  
----------------------------------------------------------------------------------  
4. **Wszystko jest obiektem**  
  
Obiekt = ma właściwości i funkcjonalności  
  
Plik.py = moduł (obiekt klasy moduł)  
  
---------------------------------------------------------------------------------------------  
  
5. **Synchroniczny**     +    **Asynchroniczny**  
        |                       |  
process + thread         process + thread  
                            IOBound  
                            programowanie w czasie  
  
Opowieść o 1 palniku i 2 garnkach  
Ide do sklepu | Kupuje ziemniaki | Wracam | Wstawiam wode | kroje | gotuje wode | jem | roomba odkurzam  
Ide do sklepu | Kupuje ziemniaki | wracam | WStawiam wode | gotuje / kroje / roomba odkurza  
  
Domyślnie pracujemy synchronicznie  
  
Czym się różni programowanie asynchroniczne od multithredingu  
  
W programowaniu asynchronicznym istnieje coś takiego co się nazywa PĘTLA ZDARZEN -> działa na jednym thread i jednym procesie , to generator nieskończony, aby mógł przenosić na callstack to korzysta z KOLEJKI (struktura danych np. stos FILO, kolejna FIFO)  
  
W multithreadingu możemy manimulować kolejkami tak by przełączać je ręcznie.  
  
----------------------------------------------------------------------------------  
6. Single thread + multithreading  
  
By default działamy w jednym wątku, w obrębie jednego procesu. Proces = jeden rdzeń CPU  
  
[[GIL]] - global interpreter lock globalna blokada interpretera  
  
multithreading do operacji IOBound (http, pliki, sieć, db). Podczas oczekiwania na I/O GIL jest zwalniany  
  
Od Python 3.13 można wyłączyć GIL (PEP 703)  
Przez GIL multithreading i async są bardzo podobne  
  
Singlethread jest wykorzystywany w ramach jednego procesu  
Jeden proces = operacja na jednym rdzeniu procesora  
  
----------------------------------------------------------------------------------  
  
7. **Single process** + **multiprocessing**  
        |                   |  
                            'crown' CPUBound  
  
Multiprocessing zahacza o C/C++  


7. Domyślnie python jest eager [[materialized object]]
  
----------------------------------------------------------------------------------  
 PIP = instalator paczek  w python
  
  
----------------------------------------------------------------------------------  

Python jest znany jako butter included -> zawiera wszystkie co niezbędne.  
  
W pythonie zamiast bibliotek używa się słowa package.  


==Aplikacje w Pythonie   składają się z 3 rzeczy==

[[package]] -> katalog z plikami (wyspecjalizowany moduł)
[[module]] - > pliki ! w momencie importu moduły są [[single tone]]
[[namespace]]

W python mamy wbudowany pakiet venv -> python -m venv  
-m oznacza ze to po lewej chce odpalić to po prawej.  
  
Wirtualne środowisko tworzymy przez  
  
1. venv  
co robi?  
        - tworzy lokalne środowisko pythona  
        - własny python, własne pip, własny site-packages  
 czego nie robi?  
         - nie zapisuje jakie paczki zainstalowałem  
         - nie zapisuje wersji tych paczek  
         - środowisko tworzone jest wewnątrz projektu  
2. pipenv  
         - była sexy  
3. poetry  
4. anaconda  
  
Nie implementuje TCO [[tail call optimization]]

- **Tail call** = „wywołaj i natychmiast przekaż jego wynik dalej”.
- - W językach z TCO (Scheme, Haskell, OCaml) kompilator zamienia taki przypadek w zwykłą pętlę → stos się nie powiększa.

```python
def sum_acc(n, acc=0):
    if n == 0:
        return acc
    return sum_acc(n-1, acc+n)

print(sum_acc(1000))        # działa
print(sum_acc(10000))       # RecursionError
```

poprawiona

```python 
def sum_iter(n):
    acc = 0
    while n > 0:
        acc += n
        n -= 1
    return acc
```

można też oszukać stos trampoliną 

```python
  
def tramp(gen, *arg, **kwarg):  
    g = gen(*arg, **kwarg)  
  
    while isinstance(g, types.GeneratorType):  
        g = next(g)  
  
    return g
```

g = next(g) - wyciąga kolejne pietro rekurencji
dopóki zwraca generatory trampolina je rozpakowuje.
Gdy zwykła wartość (np int), pętla się kończy i zwraca wynik


  %% md  
PROMPT: Analogia Kucharska - Python Concurrency  
Cześć! Chcę wrócić do naszej szczegółowej analogii kucharskiej, która wyjaśnia paradygmaty współbieżności w Pythonie.  
Opowiedz mi ponownie o różnicach między:  
Podstawowe koncepty:  
  
Synchroniczny vs Asynchroniczny (jeden kucharz - czeka vs sprytny)  
Single Thread vs Multithreading (jeden vs klonowany kucharz + GIL)  
Single Process vs Multiprocessing (jedna vs wiele kuchni)  
I/O Tasks vs CPU Tasks (czekanie na dostawy vs intensywna praca rękami)  
GIL (Global Interpreter Lock) (magiczna zasada - tylko jeden może używać rąk)  
  
Scenariusze do omówienia:  
  
Single Process, Single Thread, Synchroniczny - Kucharz Janek (robi wszystko po kolei, czeka bezczynnie)  
Single Process, Single Thread, Asynchroniczny - Kucharz Michał (sprytny, wykorzystuje czas oczekiwania)  
Single Process, Multithreading + GIL - Tomek + Klon (świetne do I/O, CPU tasks wciąż po kolei)  
Multiprocessing - Wiele kuchni z osobnymi kucharzami (prawdziwa równoległość)  
Multiprocessing + Asynchroniczny - Wiele sprytnych kucharzy (maksymalna wydajność)  
  
Złote zasady:  
  
I/O Tasks (czekanie) → Threading/Async wystarczy  
CPU Tasks (praca) → Multiprocessing konieczny  
GIL = tylko jeden może "gotować" naraz w tej samej kuchni  
Multiprocessing = każda kuchnia ma własny GIL  
  
Styl odpowiedzi: Używaj szczegółowych analogii kucharskich z emoji, konkretnych przykładów kodu, czasów wykonania i praktycznych wskazówek "kiedy co stosować".  
  
Opcjonalnie możesz też rozwinąć dodatkowe pojęcia jak: Event Loop, Coroutines, Thread Pool, Queue, Lock/Mutex, Semaphore, Race Condition, Deadlock, Context Manager, Generator, Memory Management, Blocking vs Non-blocking, Buffering, Thread Safety.