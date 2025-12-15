oto pseudo kod jak działa look up w pythonie ( bo oryginał napisany w C)


## **1)** 

## **__getattribute__**

##  **— zawsze jako pierwszy krok**


## **2) Sprawdzanie atrybutów instancji**

## **3) Szukanie w klasie**

## **4) MRO — przeszukiwanie wzdłuż hierarchii dziedziczenia**


## **5) Deskriptory — specjalny przypadek w lookup**

Jeśli znaleziony atrybut jest obiektem z metodami:

- __get__
    
- __set__
    

  

Python traktuje go jako **descriptor**.

  

To obejmuje:

- property
    
- metody
    
- metody statyczne / klasowe
    
- pola pydantic/dataclass
    
- descriptors niestandardowe

## **6)** 

## **__getattr__**

##  **— tylko gdy lookup zawiedzie**

  

Wywoływana **na samym końcu**, tylko jeśli:

- atrybutu nie ma w instancji
    
- nie ma w klasie
    
- nie ma w MRO
    
- nie ma deskriptora

## **7) Jeśli nic nie znaleziono —** 

## **AttributeError**



## **Cały algorytm w skrócie**

1. obj.__getattribute__(name)
    
2. instancja obj.__dict__
    
3. klasa type(obj).__dict__
    
4. MRO — klasy bazowe
    
5. deskriptory (__get__, __set__)
    
6. obj.__getattr__(name) tylko gdy wszystko inne zawiodło
    
7. AttributeError
    

---

## **Najważniejsze różnice**

  

### **__getattribute__**

- wywoływane **zawsze**
    
- przechwytuje cały dostęp
    
- łatwo zrobić rekurencję
    

  

### **__getattr__**

- wywoływane **tylko na końcu**
    
- działa **tylko dla nieistniejących atrybutów**


```python
class Object:  
  
    def __getattribute__(self, name): # look up jezeli potrzebujemy pobrac jakas wartość  
        cls = type(self) # ściąga klasę żeby móc szukać dalej  
  
        # Pierwszy if. Szuka w vars(self) -> w __dict__ obiektu        if name in vars(self):  # vars(self) daje __dict__ obiektu  
            return vars(self)[name]  
        # dlaczego tu mamy ask for permision? bo bardzo czesto się zdaża że tego tam nie ma  
  
        # Następnie sprawdzamy w klasie. Czy jest        if hasattr(cls, name): # w klasie słownik jest nadpisany przez mapping proxy, czyli jest opakowany po to aby atrybuty były tylko do odczytu  
            return getattr(cls, name)  
  
        # Teraz w klasie szuka __getattr__ -> dlatego wywołuje się na końcu  
        if hasattr(cls, "__getattr__"):  
            return cls.__getattr__(self, name)  
  
        raise AttributeError(f"{cls.__name__} has no attribute {name}")

```