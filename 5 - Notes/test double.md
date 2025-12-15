

**collaborator** doubles- „bierni pomocnicy”

 Służą do **dostarczania danych**, ale **nie interesuje nas, co się z nimi działo**. Nie analizujemy interakcji z nimi.
 
	 np mamy db ale nie mamy db.
	 

1. ==dummy object== - najczęściej none
2. ==test stub== - spreparowane dane, bardziej ograniczony np jak mamy get(id=1) to wtedy na sztywno get(Jarosław)
3. ==fake object== - – działa, ale nie „prawdziwie” (np. baza w pamięci)

📌 **Cel**: dać coś na wejście, żeby test mógł działać

📌 **Nie interesuje nas**, czy coś zostało na nich wywołane


**interactions** doubles - aktywni podsłuchiwacze

interakcja pomiędzy obiektami, np. czy fn sie wywołała, albo w jakiej kolejności się wywołuje. 

4. ==mock object== - - bada interakcje, jak Spy, ale robi też **test sam w sobie** (ma wbudowane oczekiwania)
5.  ==test spy== -- podsłuchuje wywołania




 **📚** **Typy Test Doubles (wg klasyfikacji Gerarda Meszaroza)**

| **yp**    | **Co robi?**                                                                                                                         | **Przykład użycia**                                                                     |
| --------- | ------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------- |
| **Dummy** | Używany tylko po to, by **zapełnić argumenty/metody**, ale **nigdy nie jest wykorzystywany**                                         | None, pusta klasa, np. przekazanie obiektu User() jako argument, który nie jest używany |
| **Fake**  | Ma **działającą implementację**, ale **uprośczoną**. Działa, ale nie nadaje się na produkcję                                         | Własna klasa InMemoryDatabase zamiast prawdziwego SQL                                   |
| **Stub**  | Zwraca **z góry ustalone wartości** dla metod — **pasuje do testu**                                                                  | Stub metody get_user() zwraca User("Jan") bez logiki                                    |
| **Spy**   | **Zapamiętuje**, co się wydarzyło — np. **czy metoda została wywołana**, z jakimi argumentami                                        | Można sprawdzić np. spy.send_email.called                                               |
| **Mock**  | **Jak Spy, ale dodatkowo z asercjami** – sprawdza **czy zostało coś wywołane i jak często**, **test może się nie powieść jeśli nie** | mock.assert_called_once_with(...)                                                       |

## **🔁 Memotechnika**

  
Wyobraź sobie aktorów w teatrze:

- Dummy: statysta, który stoi na scenie i nic nie robi
    
- Fake: aktor, który zna tekst, ale gra z kartki
    
- Stub: aktor, który zawsze mówi to samo
    
- Spy: aktor z podsłuchem – wszystko notuje
    
- Mock: reżyser, który mówi „ma być powiedziane dokładnie tak, albo test nie przejdzie”




[[tests]]