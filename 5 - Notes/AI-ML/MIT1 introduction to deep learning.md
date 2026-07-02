---
title: "MIT1 introduction to deep learning"
type: concept
topic: ai-ml
tags: ["ai"]
created: 2026-06-09
status: draft
sr_due: 2026-07-15
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

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


![[Pasted image 20260415161049.png]]

PODSUMOWANIE
1. Definicje i hierarchia
- **Sztuczna Inteligencja (AI):** Praktyka budowania algorytmów przetwarzających informacje w celu podejmowania przyszłych decyzji.
- **Machine Learning (ML):** Podzbiór AI, który uczy się z danych bez bycia jawnie zaprogramowanym.
- **Deep Learning (DL):** Podzbiór ML skupiający się na wykorzystaniu **głębokich sieci neuronowych** do uczenia się hierarchicznych reprezentacji danych (od prostych linii po złożone obiekty).

2. Fundament: Pojedynczy Neuron (Perceptron)

To podstawowy element budulcowy, którego działanie opiera się na trzech krokach:

- **Iloczyn kropkowy (Dot product):** Każde wejście jest mnożone przez wagę i sumowane.
- **Dodanie biasu (Bias):** Pozwala na przesuwanie funkcji w celu lepszego dopasowania modelu.
- **Nieliniowość (Activation Function):** Zastosowanie funkcji aktywacji (np. Sigmoid, ReLU), co pozwala sieci rozwiązywać złożone, nieliniowe problemy, z którymi nie radzą sobie modele liniowe.

3. Budowa sieci i warstw

- Sieci powstają poprzez łączenie neuronów w **warstwy** (np. warstwy _Dense_ w TensorFlow), gdzie każdy neuron w warstwie ma własne wagi, ale te same wejścia.
- **Głębokie sieci neuronowe** to po prostu wiele takich warstw ułożonych jedna na drugiej (sekwencyjnie) z nieliniowościami pomiędzy nimi.

4. Proces trenowania

- **Funkcja straty (Loss Function):** Mierzy błąd między przewidywaniem modelu a rzeczywistą wartością (np. Cross Entropy dla klasyfikacji lub MSE dla regresji).
- **Gradient Descent (Spadek gradientu):** Algorytm optymalizacji, który aktualizuje wagi, robiąc małe kroki w kierunku przeciwnym do gradientu, aby zminimalizować stratę.
- **Backpropagation (Wsteczna propagacja):** Wykorzystanie reguły łańcuchowej (chain rule) do obliczenia, jak każda waga w sieci wpływa na końcowy błąd.

5. Praktyczne usprawnienia i optymalizacja

- **Learning Rate (Tempo uczenia):** Parametr określający wielkość kroku w optymalizacji. Zbyt mały spowalnia naukę, zbyt duży może uniemożliwić znalezienie minimum. Nowoczesne algorytmy (np. Adam) używają adaptacyjnego tempa uczenia.
- **Mini-batching:** Trenowanie na małych porcjach danych (zamiast na całym zbiorze naraz), co balansuje szybkość i stabilność obliczeń.
- **Regularyzacja:** Techniki zapobiegające **overfittingowi** (przeuczeniu), takie jak **Dropout** (losowe wyłączanie neuronów) oraz **Early Stopping** (zatrzymanie treningu, gdy błąd na danych testowych zaczyna rosnąć).
