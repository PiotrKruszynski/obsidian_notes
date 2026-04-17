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
![[Pasted image 20260417145344.png]]

neuron
![[Pasted image 20260417145400.png]]

![[Pasted image 20260417145503.png]]

![[Pasted image 20260417145521.png]]

![[Pasted image 20260417145649.png]]

![[Pasted image 20260415215412.png]]

![[Pasted image 20260417145631.png]]

> **Gradient mówi sieci neuronowej, w którą stronę i jak mocno powinna zmienić swoje wagi, żeby zmniejszyć błąd.**

![[Pasted image 20260417133151.png]]

![[Pasted image 20260417133506.png]]

![[Pasted image 20260417145751.png]]

![[Pasted image 20260417140702.png]]


> **Transformer nie potrzebuje pamięci jak LSTM.** **Zamiast tego każde słowo patrzy na wszystkie inne naraz.**

![[Pasted image 20260417145829.png]]

encoding position information
![[Pasted image 20260417150328.png]]
extract query, key, value for search
![[Pasted image 20260417150403.png]]
compute attention weighting
![[Pasted image 20260417150449.png]]
![[Pasted image 20260417151459.png]]
extract features with high attention
![[Pasted image 20260417151524.png]]

![[Pasted image 20260417151931.png]]
attention head -> Pojedynczy blok self-attention operujący na Q, K, V.
![[Pasted image 20260417151955.png]]
ten pipeline (Q, K, V → attention → weighted sum) to **jeden moduł zwany _self-attention head_**, który jest **budulcem większej sieci (Transformera)**.
![[Pasted image 20260417152609.png]]

![[Pasted image 20260417152900.png]]
# 🧠 Sequence Models – definicje

## 🔹 RNN (Recurrent Neural Network)
Model sekwencyjny przetwarzający dane krok po kroku w czasie.

h_t = tanh(W_h h_{t-1} + W_x x_t + b)
y_t = W_y h_t + b_y

---

## 🔹 Hidden state (h_t)
Stan ukryty reprezentujący informację z poprzednich kroków.

---

## 🔹 Input (x_t)
Wejście w kroku czasowym t.

---

## 🔹 Output (y_t)
Wyjście modelu w kroku czasowym t.

---

## 🔹 Sequence modeling
Modelowanie zależności w danych uporządkowanych w czasie.

---

## 🔹 Gradient
Pochodna funkcji straty względem parametrów.

∇_w L

---

## 🔹 Gradient descent
Algorytm optymalizacji minimalizujący funkcję straty.

w_new = w_old - η ∇_w L

---

## 🔹 Learning rate (η)
Współczynnik skali aktualizacji wag.

---

## 🔹 Loss function (L)
Funkcja mierząca błąd predykcji modelu.

---

## 🔹 Backpropagation
Algorytm obliczania gradientów przez propagację wsteczną.

---

## 🔹 Backpropagation Through Time (BPTT)
Backpropagation rozwinięty wzdłuż osi czasu w RNN.

---

## 🔹 Vanishing gradient
Zanik gradientu przy propagacji przez wiele kroków.

---

## 🔹 Exploding gradient
Eksplozja gradientu do bardzo dużych wartości.

---

## 🔹 Encoding bottleneck
Kompresja całej informacji sekwencji w jednym wektorze h_t.

---

## 🔹 LSTM (Long Short-Term Memory)
RNN z mechanizmem pamięci i bramkami.

---

## 🔹 Cell state (c_t)
Stan pamięci długoterminowej.

---

## 🔹 Hidden state (h_t) – LSTM
Stan krótkoterminowy przekazywany dalej.

---

## 🔹 Forget gate
Bramka kontrolująca usuwanie informacji.

f_t = σ(W_f [h_{t-1}, x_t] + b_f)

---

## 🔹 Input gate
Bramka kontrolująca zapisywanie informacji.

i_t = σ(W_i [h_{t-1}, x_t] + b_i)

---

## 🔹 Candidate state
Nowa kandydatowa informacja do zapisania.

c̃_t = tanh(W_c [h_{t-1}, x_t] + b_c)

---

## 🔹 Cell state update
Aktualizacja pamięci.

c_t = f_t ⊙ c_{t-1} + i_t ⊙ c̃_t

---

## 🔹 Output gate
Bramka kontrolująca wyjście.

o_t = σ(W_o [h_{t-1}, x_t] + b_o)

---

## 🔹 Hidden state update (LSTM)
h_t = o_t ⊙ tanh(c_t)

---

## 🔹 GRU (Gated Recurrent Unit)
Uproszczona wersja LSTM z mniejszą liczbą bramek.

---

## 🔹 Sequential processing
Przetwarzanie krok po kroku bez równoległości.

---

## 🔹 Transformer
Model sekwencyjny oparty na mechanizmie attention.

---

## 🔹 Embedding
Reprezentacja tokena jako wektor w przestrzeni ciągłej.

x ∈ ℝ^d

---

## 🔹 Positional encoding
Reprezentacja pozycji elementu w sekwencji.

input_t = x_t + p_t

---

## 🔹 Query (Q)
Wektor zapytania.

Q = X W_Q

---

## 🔹 Key (K)
Wektor klucza.

K = X W_K

---

## 🔹 Value (V)
Wektor wartości.

V = X W_V

---

## 🔹 Scaled dot-product attention
Mechanizm uwagi oparty na iloczynie skalarnym.

Attention(Q, K, V) = softmax(Q K^T / √d_k) V

---

## 🔹 Attention weights
Wagi określające istotność elementów sekwencji.

---

## 🔹 Self-attention
Mechanizm, w którym elementy sekwencji odnoszą się do siebie nawzajem.

---

## 🔹 Multi-head attention
Wiele równoległych mechanizmów attention.

---

## 🔹 Parallelization
Możliwość przetwarzania wszystkich elementów jednocześnie.

---

## 🔹 Long-range dependencies
Zależności między odległymi elementami sekwencji.

---

## 🔹 Token
Podstawowa jednostka wejściowa modelu.

---

## 🔹 Context
Informacja z innych tokenów używana do interpretacji danego tokena.



