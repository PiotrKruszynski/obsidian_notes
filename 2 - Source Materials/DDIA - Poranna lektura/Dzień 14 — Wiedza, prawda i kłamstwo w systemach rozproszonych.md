# Dzień 14 — Rozdział 8 (2/2): Wiedza, prawda i kłamstwo w systemach rozproszonych

**Źródło:** Martin Kleppmann, *Designing Data-Intensive Applications* (2017), rozdz. 8, druga połowa (od sekcji „Process Pauses" do końca rozdziału)

---

## O czym jest ten fragment

Druga połowa rozdziału 8 zaczyna się od trzeciego wielkiego źródła niepewności w systemach rozproszonych: **pauz procesów**. Kleppmann pokazuje to na przykładzie leasingu (lease) — mechanizmu, który ma zapewnić, że tylko jeden węzeł jest liderem partycji. Kod wygląda niewinnie: węzeł sprawdza, czy jego leasing jeszcze ważny, i jeśli tak — przetwarza żądanie. Problem w tym, że między sprawdzeniem a przetworzeniem żądania może minąć dowolnie dużo czasu — z powodu pauzy garbage collectora, zawieszenia maszyny wirtualnej, swapowania, wywłaszczenia wątku przez system operacyjny czy nawet zamknięcia klapy laptopa. Węzeł, który myśli, że wciąż jest liderem, może w rzeczywistości od dawna nim nie być — bo inne węzły uznały go za martwego i wybrały nowego lidera. To dokładnie ten sam problem co przy niesynchronizowanych zegarach: węzeł nie może ufać własnemu poczuciu czasu.

Stąd Kleppmann przechodzi do sedna rozdziału — sekcji **„Knowledge, Truth, and Lies"**. Skoro węzeł nie może ufać nawet sobie, to jak system rozproszony w ogóle ustala, co jest prawdą? Odpowiedź: **prawdę definiuje większość (kworum)**, nie pojedynczy węzeł. Kleppmann ilustruje to trzema mrocznymi scenariuszami — węzeł, który nie może wysyłać odpowiedzi (ale je odbiera), węzeł po długiej pauzie GC, który „budzi się" i nie wie, że został uznany za martwego. Morał: pojedynczy węzeł nie może być wyrocznią, więc decyzje (w tym „kto żyje, a kto nie") zapadają przez głosowanie większościowe, bo w systemie może istnieć tylko jedna większość naraz — nie dwie sprzeczne.

Z tego wynika praktyczny problem: **blokady i leasingi**. Węzeł może wierzyć, że jest „wybrańcem" (liderem, posiadaczem locka), a większość już dawno zdecydowała inaczej. Rozwiązaniem jest **fencing token** — rosnąca liczba wydawana przy każdym przyznaniu locka, którą trzeba dołączać do każdego zapisu. Magazyn danych odrzuca zapisy z niższym tokenem niż już przetworzony, więc nawet „ożywiony zombie" nie zdąży nic zepsuć.

Dalej Kleppmann wprowadza rozróżnienie na **błędy bizantyjskie** (węzły, które aktywnie kłamią lub są złośliwe) kontra węzły, które są tylko wolne lub martwe, ale uczciwe. W typowych systemach data center zakładamy brak błędów bizantyjskich (wszystkie węzły kontroluje jedna organizacja), ale w sieciach blockchain czy systemach lotniczych — trzeba je tolerować. Rozdział kończy się formalizacją: **modele systemowe** (synchroniczny, częściowo synchroniczny, asynchroniczny) i **modele awarii węzłów** (crash-stop, crash-recovery, bizantyjski), a także rozróżnieniem między właściwościami **bezpieczeństwa (safety)** — „nic złego się nie dzieje", niepodważalnymi — a **żywotności (liveness)** — „coś dobrego w końcu się wydarzy", które można okraszyć zastrzeżeniami.

---

## Najważniejsze cytaty

> *"A node in the network cannot know anything for sure—it can only make guesses based on the messages it receives (or doesn't receive) via the network."*

**Po polsku:** To centralna teza rozdziału — węzeł nie ma dostępu do obiektywnej prawdy o stanie systemu, tylko do poszlak z komunikacji sieciowej.

---

> *"A distributed system cannot exclusively rely on a single node, because a node may fail at any time, potentially leaving the system stuck and unable to recover. Instead, many distributed algorithms rely on a quorum."*

**Po polsku:** Dlatego decyzje (np. „kto jest liderem") zapadają głosowaniem większościowym, a nie przez zaufanie jednemu węzłowi.

---

> *"If the node continues acting as the chosen one, even though the majority of nodes have declared it dead, it could cause problems in a system that is not carefully designed."*

**Po polsku:** To jest dokładnie problem, który rozwiązuje fencing token — węzeł-zombie może dalej myśleć, że jest liderem, ale system musi go zignorować.

---

> *"In this book we assume that nodes are unreliable but honest... Such behavior is known as a Byzantine fault."*

**Po polsku:** Ważne rozróżnienie: większość baz danych zakłada węzły uczciwe (mogą tylko zawieść), a nie złośliwe. Błędy bizantyjskie to inna, znacznie trudniejsza liga problemów (np. blockchain).

---

> *"Safety is often informally defined as nothing bad happens, and liveness as something good eventually happens."*

**Po polsku:** Prosta, ale kluczowa heurystyka do klasyfikowania właściwości algorytmów rozproszonych — bezpieczeństwo nie może być nigdy naruszone, żywotność może poczekać.

---

## Myśl dnia

W systemie rozproszonym żaden pojedynczy węzeł nie zna prawdy — prawdę ustala tylko głosowanie większości, a mechanizmy takie jak fencing tokens chronią system przed węzłami, które błędnie wierzą, że wciąż są „wybrańcem".

---

**Jutro (Dzień 15):** Rozdział 9 (1/3) — konsystencja i konsensus: gwarancje transakcyjne, linearizability i modele spójności.
