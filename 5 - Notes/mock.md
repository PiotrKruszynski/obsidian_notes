	tworzenie wirtualnych elementów
	to błędna nazwa na double !!

	 to obiekt weryfikujący zachowanie. Jego głównym celem nie jest „zwracanie czegoś” (to robi stub), ale sprawdzenie, czy został wywołany, jak został wywołany, z jakimi argumentami, ile razy itd.

	- Stub → _co ma zwrócić_ → służy do izolacji.
	    
	- Mock → _czy coś było wywołane_ → służy do weryfikacji.
	    
> 	Jeśli testujesz **czy coś się stało**, użyj **mocka**.
	
> 	Jeśli testujesz **co się zwróciło**, użyj **stuba**.

w Java powstała pierwsza biblioteka jUnit, z niej powstała Unittests ( Standard ) i ona ma klasę Mock, która może być mockiem, ale też stub, spy
Wszyscy nazywają Mock ale to nie prawda

🎭 Różnice: mock vs stub vs spy wg definicji  [**Martin Fowler**](https://martinfowler.com/articles/mocksArentStubs.html)

||**Co robi**|**Do czego służy**|**Python (**unittest.mock**)**|
|---|---|---|---|
|**Stub**|Zwraca przygotowaną wartość|Izolacja zależności|mock.return_value = ...|
|**Mock**|Sprawdza, czy coś zostało wywołane (i jak)|Weryfikacja zachowania|mock.assert_called_once_with(...)|
|**Spy**|Przepuszcza prawdziwą logikę, ale też zapamiętuje wywołania|Audyt|wraps=real_function|
|**Fake**|Wersja robocza implementacji (np. in-memory)|Testowanie logiki bez zasobów|Osobna klasa|
|**Dummy**|Nie robi nic, tylko wypełnia argument|Struktura|None, lambda: None|


## **🧠 Dlaczego ludzie** 

## **używają błędnie mocking**

## **?**

1. **Używają Mock() zawsze i wszędzie** – bez refleksji, że np. chcieli _stub_, a nie _mocka_.
    
2. **Testują implementację zamiast interfejsu** – np. robią assert_called_once_with(...), zamiast testować wynik logiki wywołującej.
    
3. **Nadużywają patch()** – przez co testy są trudne do zrozumienia, a kod staje się kruchy (np. patch('os.path.exists') → nie działa przy refaktorze importu).
    
4. **Nie używają spec=** – przez co Mock akceptuje dowolne metody, nawet takie, których nie ma w obiekcie bazowym.
    
5. **Brak intencji** – kod testu nie ujawnia, czy autor testował zachowanie (mock), izolację (stub), czy reakcję (spy).

błędny przykład
```python
from unittest.mock import Mock

def send_welcome_email(user):
    email = f"Welcome {user.name}"
    email_service = EmailService()
    email_service.send(email)

def test_send_welcome_email():
    user = Mock()
    user.name = "Piotr"

    email_service = Mock()
    send_welcome_email(user)

    # ❌ Nie testujemy czy email został wysłany – test niczego nie sprawdza
```

To jest **mock, który niczego nie testuje** – typowy błąd: _mocking without asserting or stubbing_.

---

## **✅ Lepsze podejście – test zachowania (mock) lub odpowiedzi (stub):**

  

### **Jako** 

### **stub**

###  **(izolacja):**

```python
email_service = Mock()
email_service.send.return_value = True
```

### **Jako** 

### **mock**

###  **(weryfikacja):**

```python email_service.send.assert_called_once_with("Welcome Piotr")
```

### **Jako** 

### **spy**

###  **(logika realna + śledzenie):**

```python
real_service = EmailService()
spy = Mock(wraps=real_service)
```

## **🧪 Ciekawostka –** 

## **Mock**

##  **w Pythonie to** 

## **klasa wszystkożerna**

## **:**

```python 
from unittest.mock import Mock

m = Mock()
print(m.anything_here(123).bla().foo.bar)  # działa, bo każdy atrybut to znów Mock()
```

To pozwala na elastyczność, ale też **prowadzi do pułapek, jeśli nie używamy spec=**:

```python
from unittest.mock import create_autospec
mocked_os = create_autospec(os)
mocked_os.pathexists("file.txt")  # ❌ AttributeError, bo `pathexists` nie istnieje
```

## **🧠 TL;DR**

- Mock ≠ mock w sensie wzorca – to **uniwersalne narzędzie**, ale trzeba **jasno zdefiniować intencję użycia**.
    
- Python nie rozróżnia nazw klas jak Java – Mock() może być używany jako **stub**, **spy**, **dummy** – zależnie od kontekstu.
    
- Brak rozróżniania prowadzi do **testów, które są kruche, bezużyteczne lub trudne w utrzymaniu**.
