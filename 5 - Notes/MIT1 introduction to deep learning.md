#MIT

iloczyn kropkowy
![[Pasted image 20260415144919.png]]

przykład funkcji aktywacyjnej
![[Pasted image 20260415145149.png]]
inne funkcje aktywacyjne
![[Pasted image 20260415145241.png]]


Neuron przyjmuje zestaw sygnałów wejściowych (X1​ do XM​).
Każde z tych wejść jest mnożone przez odpowiadającą mu **wagę** (w1​,w2​,...)
Wagi te określają, jak istotny jest dany sygnał wejściowy dla ostatecznego wyniku.
Wyniki mnożenia wejść przez wagi są sumowane

Do tej sumy dodawany jest tzw. **wyraz wolny lub obciążenie (bias)**, oznaczany często jako w0
Bias pozwala na przesuwanie funkcji aktywacji w górę lub w dół, co daje modelowi większą elastyczność w dopasowywaniu się do danych

Matematycznie cały ten proces można zapisać jako **iloczyn kropkowy** wektorów wag i wejść z dodanym biasem i nieliniowością

- **Funkcja aktywacji:** Otrzymany wynik (pojedyncza liczba) przechodzi przez **nieliniową funkcję aktywacji** (G). Jest to kluczowy etap, ponieważ:
    - Wprowadza on **nieliniowość** do modelu, co pozwala sieciom neuronowym na rozwiązywanie złożonych, rzeczywistych problemów, których nie da się opisać prostymi liniami.
    - Przekształca on wynik w nową wartość. Przykładem jest funkcja **sigmoid**, która mapuje dowolną liczbę na zakres od 0 do 1, co jest często wykorzystywane do reprezentowania prawdopodobieństwa.
    - Inne funkcje, jak np. ReLU, mogą zwracać wartości od 0 do dodatniej nieskończoności, wprowadzając ograniczenia nieujemności.

### trenowanie neuronu
polega na dopasowywaniu jego wag i biasu w taki sposób, aby minimalizować błąd (stratę) między przewidywanym wynikiem a rzeczywistą wartością.

tutaj mamy już sieć z 2 neuronów. z1 i z2 jeszcze przed dodaniem nieliniowości opisane sa wzorem.
![[Pasted image 20260415152255.png]]

to samo w TensorFlow
![[Pasted image 20260415153008.png|500]]

to samo w PyTorch
![[Pasted image 20260415153056.png|500]]


