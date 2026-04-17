#MIT 

MIT pokazuje podstawowy schemat:

$ht=tanh⁡(Whht−1+Wxxt+b)$
$y^t=Wyht+by$

Czyli:
- bierzesz poprzedni stan
- bierzesz nowe wejście
- łączysz je
- tworzysz nowy stan
To tworzy „łańcuch” w czasie.



![[Pasted image 20260415215412.png]]

> **Gradient mówi sieci neuronowej, w którą stronę i jak mocno powinna zmienić swoje wagi, żeby zmniejszyć błąd.**

![[Pasted image 20260417133151.png]]

## 🧠 2. Gradient w sieciach neuronowych

W sieciach neuronowych gradient mówi:

- jak zmienić **wagę** (parametr),
    
- żeby **zmniejszyć funkcję straty** (błąd).
    

Uczenie polega na:

wnowe=wstare−η⋅gradient

gdzie:

- w – waga
    
- η – learning rate
    
- gradient – kierunek i siła zmiany
    

## 🔄 3. Gradient a backpropagation

Gradient jest obliczany metodą **wstecznej propagacji błędu** (backpropagation):

1. Sieć robi predykcję
    
2. Liczymy błąd
    
3. Liczymy gradient błędu względem każdej wagi
    
4. Aktualizujemy wagi
    

Bez gradientu sieć nie mogłaby się uczyć.

## ⚠️ 4. Zanikający i eksplodujący gradient

To właśnie gradient powoduje problemy w zwykłych RNN:

- **zanikający gradient** → gradient robi się bliski 0 → sieć „zapomina”
    
- **eksplodujący gradient** → gradient robi się ogromny → uczenie się rozjeżdża
    

Dlatego powstały **LSTM i GRU**, które mają bramki regulujące przepływ gradientu.

> **LSTM to komórka pamięci z bramkami, które decydują, co zapamiętać, co zapomnieć i co wypuścić dalej.**

## 🧠 Dlaczego powstało LSTM?

Zwykłe RNN mają problem:

- gradient szybko znika → sieć „zapomina” informacje sprzed kilku kroków
    
- nie potrafią uczyć się długich zależności (np. w zdaniach, muzyce, time series)
    

LSTM rozwiązuje to, dodając **mechanizm pamięci długoterminowej**.

## 🔐 Jak działa LSTM? (intuicyjnie)

W środku LSTM są **trzy bramki**:

### 1) **Forget gate** – co zapomnieć

Decyduje, które informacje ze starego stanu pamięci wyrzucić.

### 2) **Input gate** – co zapisać

Decyduje, które nowe informacje dodać do pamięci.

### 3) **Output gate** – co wypuścić na wyjście

Decyduje, jaka część pamięci ma wpływać na kolejne kroki.

Wszystkie bramki używają sigmoida (0–1), więc działają jak krany:

- 0 → nic nie przepuszcza
    
- 1 → przepuszcza wszystko
    

## 📦 Co jest w środku komórki LSTM?

LSTM przechowuje dwa rodzaje informacji:

- **stan komórki (cell state)** – długoterminowa pamięć
    
- **stan ukryty (hidden state)** – krótkoterminowa informacja przekazywana dalej
    

Cell state płynie przez sieć prawie niezmieniony, dlatego gradient się nie rozpada.

## 🔄 Dlaczego LSTM działa tak dobrze?

- potrafi pamiętać informacje przez **setki kroków czasowych**
    
- świetnie radzi sobie z sekwencjami: tekst, audio, time series
    
- jest stabilny podczas uczenia
    
- nie ma problemu z zanikającym gradientem

![[Pasted image 20260417133506.png]]

## ⚠️ Ograniczenia zwykłych RNN (to, co masz wypisane z boku)

### 1) **Encoding bottleneck**

RNN musi „upchnąć” całą przeszłą informację w jednym wektorze ht. To jak próba streszczenia całej książki w jednym zdaniu.

### 2) **Slow, no parallelization**

RNN przetwarza dane **sekwencyjnie**, krok po kroku. Nie da się równolegle policzyć h5 zanim policzysz h4.

### 3) **Not long memory**

Największy problem: **zanikający gradient**. Im dalej w czasie, tym trudniej przekazać informację. RNN pamięta tylko krótkie zależności.

To właśnie ten punkt doprowadził do powstania LSTM.
## 🧠 Jak LSTM rozwiązuje te problemy?

LSTM dodaje:

- **cell state** – kanał pamięci, który płynie przez sieć prawie bez zmian
    
- **bramki** – mechanizmy kontrolujące przepływ informacji
    

Dzięki temu:

- gradient nie zanika tak szybko
    
- sieć może pamiętać **długie zależności**
    
- nie ma „encoding bottleneck”, bo pamięć jest aktualizowana selektywnie
    
- nadal jest sekwencyjna, ale dużo bardziej stabilna

![[Pasted image 20260417140702.png]]

Transformery **nie czytają sekwencji krok po kroku** jak RNN. Zamiast tego:

> **Wszystkie słowa są przetwarzane jednocześnie (równolegle).**

To daje ogromną szybkość, ale ma jedną konsekwencję:

### 🔥 Model nie wie, które słowo jest pierwsze, drugie, trzecie…

## 1) **Dodanie informacji o pozycji (positional encoding)**

Każde słowo ma:
- **embedding słowa** (co oznacza)
- **embedding pozycji** (gdzie leży w zdaniu)

Te dwa wektory są **dodawane**:

$inputt=xt+pt$

### 1. **Encode position**

Dodajemy pozycję do embeddingów.

### 2. **Query, Key, Value**

Każde słowo tworzy trzy wektory:
- Query → czego szukam
- Key → co oferuję
- Value → jaka informacja ma być przekazana

### 3. **Attention weighting**

Model liczy, które słowa są ważne dla siebie nawzajem.

### 4. **Weighted sum**

Każde słowo „zbiera” informacje z innych słów, ważone uwagą.

# 🎯 Co jest kluczowe?

> **Transformer nie potrzebuje pamięci jak LSTM.** **Zamiast tego każde słowo patrzy na wszystkie inne naraz.**

To jest powód, dla którego Transformery wygrały z LSTM:

- równoległość
    
- długie zależności
    
- skalowalność
    
- stabilność uczenia