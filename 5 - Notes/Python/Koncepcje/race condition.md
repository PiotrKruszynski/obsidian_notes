---
title: "race condition"
type: concept
topic: python
tags: ["python"]
created: 2026-06-09
status: draft
---

### **🔧** 

### **Analogia (koparka i wywrotka)**

  

Wyobraź sobie, że:

- **Koparka** (task 1) ma za zadanie zrzucać piasek.
    
- **Wywrotka** (task 2) ma odebrać piasek i go wywieźć.
    

  

#### **Idealna sytuacja (brak race condition):**

- Wywrotka zawsze stoi gotowa zanim koparka zrzuci piasek.
    
- Synchronizacja działa: **koparka czeka, aż wywrotka jest gotowa**.
    

---

### **💥 Race condition:**

  

#### **Co się dzieje?**

- Koparka działa szybciej lub niezależnie od wywrotki.
    
- Zdarza się, że **koparka zrzuca piasek na ziemię, zanim podjedzie wywrotka**.
    
- Efekt? ❌ Piasek ląduje na ziemi — **utrata danych**, czyli błąd w programie.



```python
import asyncio

piasek_na_ziemi = 0

async def koparka():
    global piasek_na_ziemi
    await asyncio.sleep(0.1)  # koparka startuje
    print("🚜 Koparka: zrzucam piasek...")
    piasek_na_ziemi += 1      # ❗zrzuca bez sprawdzenia czy wywrotka jest

async def wywrotka():
    await asyncio.sleep(0.3)  # wywrotka się spóźnia
    print("🚛 Wywrotka: przyjechałem!")

async def main():
    await asyncio.gather(koparka(), wywrotka())
    print(f"❌ Piasek na ziemi: {piasek_na_ziemi}")

asyncio.run(main())
```

📌 **Race condition**: brak koordynacji → wywrotka nie odebrała ładunku.


### **✅ Rozwiązanie:** 

### **Synchronizacja z asyncio.Lock**

```python
import asyncio

piasek_na_ziemi = 0
lock = asyncio.Lock()

async def koparka():
    global piasek_na_ziemi
    async with lock:
        print("🚜 Koparka: czekam na wywrotkę...")
        await asyncio.sleep(0.1)
        print("🚜 Koparka: zrzucam piasek")
        piasek_na_ziemi += 1

async def wywrotka():
    async with lock:
        print("🚛 Wywrotka: jestem gotowa!")
        await asyncio.sleep(0.3)

async def main():
    await asyncio.gather(koparka(), wywrotka())
    print(f"✅ Piasek na ziemi: {piasek_na_ziemi}")

asyncio.run(main())
```

📌 Teraz koparka **nie zacznie pracy**, dopóki wywrotka **nie jest gotowa** – **brak race condition**.
