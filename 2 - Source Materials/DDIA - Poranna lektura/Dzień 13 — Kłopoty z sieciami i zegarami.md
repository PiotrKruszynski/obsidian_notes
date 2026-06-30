# Dzień 13 — Rozdział 8 (1/2): Kłopoty z systemami rozproszonymi — sieci i zegary

**Źródło:** Martin Kleppmann, *Designing Data-Intensive Applications* (2017), rozdz. 8, pierwsza połowa (do sekcji „Process Pauses")

---

## O czym jest ten fragment

Kleppmann zaczyna rozdział 8 od brutalnej szczerości: poprzednie rozdziały były za optymistyczne. Teraz „przestawiamy pesymizm na maksimum" i zakładamy, że wszystko co może pójść źle — pójdzie. To nie jest przesada, to inżynierska mądrość.

**Częściowe awarie (partial failures)** są fundamentalną różnicą między systemem jednomaczynowym a rozproszonym. Na pojedynczym komputerze program albo działa, albo nie — zachowanie jest deterministyczne. W systemie rozproszonym część węzłów może być zepsuta, a inne działają normalnie. Co gorsza, awarie są *niedeterministyczne*: ta sama operacja raz się uda, raz nie, i często nie wiemy nawet, czy się powiodła czy nie.

Kleppmann porównuje dwa podejścia do skali: superkomputery (HPC) i chmura. Superkomputery traktują awarię jak na laptopie — crashują cały klaster i restartują od punktu kontrolnego. To działa, bo HPC jest offline (np. symulacja pogody). Serwisy internetowe muszą być dostępne ciągłe, więc muszą *tolerować* awarie, nie uciekać od nich.

**Sieć jest zawodna** — i to nie jest wypadek, tylko wynik świadomych decyzji projektowych. Internet i sieci datacenter używają *packet switching* (Ethernet, IP), który celowo nie rezerwuje pasma. Dzięki temu maksymalizuje się wykorzystanie łącza i jest taniej. Cena: brak gwarancji opóźnień. Kiedy wysyłamy pakiet, może on:
- dotrzeć normalnie,
- czekać w kolejce i dotrzeć późno,
- zaginąć po drodze,
- dotrzeć, ale odpowiedź zaginie,
- nie dotrzeć nigdy.

Jedynym mechanizmem wykrywania awarii jest **timeout** — i tu pojawia się klasyczny dylemat: zbyt krótki timeout fałszywie ogłasza węzeł martwym i dokłada pracy innym węzłom (kaskadowa awaria), zbyt długi spowalnia cały system. Nie ma jednej właściwej wartości — trzeba mierzyć empirycznie i dostosowywać dynamicznie (np. Phi Accrual failure detector w Cassandrze i Akka).

**Zegary** to drugi wielki problem. Każdy węzeł ma własny zegar kwarcowy, który dryfuje. NTP go synchronizuje, ale nie idealnie — dokładność w internecie to dziesiątki milisekund. Kleppmann rozróżnia dwa rodzaje zegarów:
- *Time-of-day clock* (np. `System.currentTimeMillis()`) — podaje datę i godzinę, może cofnąć się w czasie po synchronizacji NTP. **Nie nadaje się do mierzenia interwałów.**
- *Monotonic clock* (np. `System.nanoTime()`) — zawsze rośnie, dobry do mierzenia czasu trwania operacji, ale jego wartość absolutna jest bez znaczenia i nie wolno porównywać go między maszynami.

Szczególnie niebezpieczne jest używanie timestampów do ustalania kolejności zdarzeń. Strategia *Last Write Wins* (LWW) — używana m.in. w Cassandrze i Riak — opiera się właśnie na timestampach. Problem: jeśli zegar jednego węzła wyprzedza inny o 3 ms, *wcześniejszy* zapis może mieć *późniejszy* timestamp. Efekt: dane po cichu giną, bez żadnego błędu.

Google rozwiązał to w Spannerze za pomocą API *TrueTime*, które zamiast punktu w czasie zwraca *przedział* `[najwcześniej, najpóźniej]`. Spanner czeka na koniec przedziału przed zatwierdzeniem transakcji, gwarantując kauzalność. Wymaga to GPS-ów lub zegarów atomowych w każdym datacenter — kosztowne, ale poprawne.

---

## Najważniejsze cytaty

> *"We will now turn our pessimism to the maximum and assume that anything that **can** go wrong **will** go wrong."*

**Po polsku:** Nie zakładaj, że awaria się nie zdarzy. Projektuj zakładając, że się zdarzy.

---

> *"In a distributed system, there may well be some parts of the system that are broken in some unpredictable way, even though other parts of the system are working fine. This is known as a **partial failure**. The difficulty is that partial failures are **nondeterministic**."*

**Po polsku:** To kluczowe spostrzeżenie: rozproszony system nie jest ani „działa" ani „nie działa" — może być w nieokreślonym stanie pośrednim.

---

> *"If you send a request to another node and don't receive a response, it is **impossible** to tell why."*

**Po polsku:** Brak odpowiedzi nie mówi nam nic — węzeł może być martwy, sieć może być zerwana, albo odpowiedź po prostu jeszcze nie dotarła.

---

> *"Variable delays in networks are not a law of nature, but simply the result of a cost/benefit trade-off."*

**Po polsku:** Moglibyśmy mieć sieci z gwarantowanymi opóźnieniami (jak ISDN w telefonii), ale byłoby to droższe i mniej wydajne. Wybraliśmy taniość i pojemność kosztem przewidywalności.

---

> *"If some piece of software is relying on an accurately synchronized clock, the result is more likely to be **silent and subtle data loss** than a dramatic crash."*

**Po polsku:** Złe zegary są podstępne — nie powodują spektakularnych awarii, po cichu tracą dane. Dlatego trzeba monitorować dryft zegarów we wszystkich węzłach.

---

## Myśl dnia

Programowanie rozproszone to życie w świecie bez gwarancji: sieć może zawieść w dowolnym momencie i z dowolnego powodu, a zegary są kłamcami z milisekund różnicy. Dobry inżynier systemów rozproszonych nie pyta „czy coś pójdzie źle", ale „jak mój system się zachowa, kiedy coś pójdzie źle".

---

**Jutro (Dzień 14):** Rozdział 8, druga połowa — Process Pauses, prawda i kłamstwo w systemach rozproszonych, modele systemów i fencing tokens.
