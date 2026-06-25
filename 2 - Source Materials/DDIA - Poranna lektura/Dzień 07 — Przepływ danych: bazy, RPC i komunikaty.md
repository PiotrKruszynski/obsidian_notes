# Dzień 07 — Rozdział 4 (2/2): Modes of Dataflow

**Fragment:** druga połowa rozdziału 4 *Designing Data-Intensive Applications* — sekcje „Dataflow Through Databases", „Dataflow Through Services: REST and RPC" oraz „Message-Passing Dataflow", plus podsumowanie rozdziału.

## O czym jest

Wczoraj był o tym, *jak* kodować dane (JSON, Thrift, Protobuf, Avro). Dzisiejszy fragment jest o tym, *gdzie* te zakodowane dane faktycznie płyną — i dlaczego kompatybilność wprzód i wstecz ma znaczenie w trzech zupełnie różnych scenariuszach.

Pierwszy to bazy danych. Proces, który zapisuje rekord, koduje dane; proces, który go czyta — często ta sama aplikacja, tylko nowsza wersja — dekoduje. Stąd słynne spostrzeżenie „dane przeżywają kod": baza może trzymać równolegle rekordy zapisane pięć lat temu i pięć minut temu, w różnych wersjach schematu, a baza ma udawać, że to jeden spójny schemat. Kleppmann zwraca uwagę na pułapkę: jeśli stary kod odczyta rekord z nowym, nieznanym mu polem, zaktualizuje go i zapisze z powrotem, to nieznane pole powinno przetrwać nieuszkodzone — to wymaga uwagi na poziomie aplikacji, nie tylko formatu kodowania.

Drugi scenariusz to komunikacja między usługami — REST i RPC. Autor przeciwstawia REST (filozofia projektowa budowana na HTTP, proste formaty, popularna w mikroserwisach) i SOAP (sztywny, XML-owy, z ciężkim ekosystemem WS-*, dziś już głównie w dużych firmach). Najciekawsza część to krytyka samej idei RPC: próba udawania, że wywołanie sieciowe to to samo co wywołanie lokalnej funkcji, jest z gruntu błędna — sieć gubi pakiety, ma zmienne opóźnienia, może zwrócić timeout bez informacji czy żądanie faktycznie się wykonało, a retry bez idempotentności grozi powtórzeniem akcji. Nowsze frameworki RPC (gRPC, Finagle, Rest.li) nie próbują już tego maskować — używają futures/promises i są szczere co do tego, że to wywołanie sieciowe.

Trzeci scenariusz to asynchroniczne przesyłanie komunikatów przez broker (RabbitMQ, Kafka i podobne) — coś pomiędzy RPC a bazą danych: broker przechowuje wiadomość tymczasowo, dostawa jest jednostronna (bez oczekiwania na odpowiedź), a sam broker zwykle nie wymusza żadnego konkretnego formatu danych. Rozdział kończy się krótkim omówieniem modelu aktorów (Akka, Orleans, Erlang OTP) jako wariantu message-passingu rozproszonego na wiele węzłów.

## Najważniejsze cytaty

> "Storing something in the database as sending a message to your future self."

Zapis do bazy to w istocie wysłanie wiadomości samemu sobie z przyszłości — stąd backward compatibility jest tu absolutnie konieczna.

> "Data outlives code."

Najbardziej zapadające w pamięć zdanie fragmentu: aplikację wymienisz w kilka minut, ale dane z niej zostają w bazie na lata, w oryginalnym, historycznym kodowaniu.

> "A network request is very different from a local function call... Network problems are common, so you have to anticipate them."

Jądro krytyki RPC — sieć nie jest lokalną pamięcią i udawanie inaczej prowadzi do błędów.

> "If you retry a failed network request, it could happen that the requests are actually getting through, and only the responses are getting lost... unless you build a mechanism for deduplication (idempotence) into the protocol."

Klasyczny problem rozproszonych systemów: nie wiesz, czy żądanie się wykonało, a retry bez idempotentności może wykonać akcję dwa razy.

> "[A message broker] logically decouples the sender from the recipient (the sender just publishes messages and doesn't care who consumes them)."

Główna zaleta message brokera względem RPC — odsprzęgnięcie nadawcy i odbiorcy w czasie i w przestrzeni.

## Myśl dnia

Kompatybilność kodowania danych nie jest abstrakcyjnym detalem formatu — to warunek, który umożliwia rolling upgrades: bazy danych wymagają forward i backward compatibility równocześnie, RPC/REST zwykle tylko backward na żądaniach i forward na odpowiedziach, a message brokery dają największą swobodę, bo nie wymuszają żadnego modelu danych.

**Jutro:** rozdział 5 (1/2) — replikacja: liderzy, naśladowcy i problemy replikacji synchronicznej vs asynchronicznej.
