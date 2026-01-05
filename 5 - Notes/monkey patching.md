	technika do podmiany kolaboranta, działa w runtime
	pytest --fixture info o wszystkich 

**Monkey patching** to **dynamiczna modyfikacja kodu w trakcie działania programu** (runtime), polegająca na **nadpisaniu metod, funkcji, klas lub atrybutów** w **istniejących obiektach lub modułach**, często z zewnętrznych bibliotek, **bez zmiany ich źródła**.

  

Mechanizm ten wykorzystuje **dynamiczną naturę Pythona** (obiekty są modyfikowalne, a przypisania są późno wiązane – _late binding_). Jest bardzo potężny, ale bywa **niebezpieczny**, jeśli używany bez pełnej kontroli – łamie zasady hermetyzacji i może wprowadzić błędy trudne do debugowania.

---

### **Przykład (syntaktyczna analiza)**
```python
import datetime

# Patchujemy metodę now() w datetime.datetime
original_now = datetime.datetime.now

def fake_now():
    return datetime.datetime(2000, 1, 1)

datetime.datetime.now = fake_now

print(datetime.datetime.now())  # → 2000-01-01 00:00:00
```

📘 **Co tu się dzieje na poziomie interpretera?**

1. import datetime – interpreter ładuje moduł datetime.
    
2. original_now = datetime.datetime.now – referencja do _oryginalnej funkcji_ now() zostaje zachowana.
    
3. def fake_now(): ... – tworzymy nową funkcję (typ: <function>).
    
4. datetime.datetime.now = fake_now – dynamiczne przypisanie: interpreter aktualizuje atrybut now klasy datetime.datetime do wskazania na nową funkcję fake_now.
    
5. print(...) – wywołanie datetime.datetime.now() tak naprawdę wywołuje fake_now().

---

### **Case study (Polski przykład z życia)**

  

**Patchowanie logowania w aplikacji Django:**

  

W testach chcemy **wyłączyć wysyłanie maili**, ale aplikacja korzysta z send_mail() z django.core.mail. Zamiast mockowania przez unittest.mock, robimy monkey patch:

```python
import django.core.mail

def silent_send_mail(*args, **kwargs):
    print("Mail suppressed.")

django.core.mail.send_mail = silent_send_mail
```

Efekt: każde send_mail(...) w systemie zostaje zastąpione naszą wersją – nie wysyła, tylko loguje.

---

### **Techniczne ciekawostki i pojęcia kluczowe:**

- **Late binding**: Przypisania atrybutów/metod są rozwiązywane w momencie wywołania, nie kompilacji.
    
- **Dynamic dispatch**: Interpreter sprawdza bieżącą wersję metody przy każdym wywołaniu (dlatego patch działa).
    
- **Global interpreter lock (GIL)**: Przy wielu wątkach monkey patching może być ryzykowny – **brak izolacji między wątkami**.
    
- **Duck typing**: Umożliwia podstawianie funkcji o tej samej sygnaturze bez dziedziczenia.
    
- **Test doubles**: Monkey patch może pełnić rolę mocka/stuba w testach bez potrzeby używania unittest.mock.
