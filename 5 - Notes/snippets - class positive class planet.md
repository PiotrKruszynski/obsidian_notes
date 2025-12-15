
![[Pasted image 20251206135205.png]]

```python
cass Positive: # obiekt przechwytuje odczyt, zapis i usuwanie atrybutów w innej klasie  
    def __init__(self):  
	    from weakref import WeakKeyDictionary
        self._instance_data = WeakKeyDictionary() # obiekt typu WeakKeyDictionary(), przechowuje pary {instancja_klasy → wartość_atrybutu}  
        # wpis jest słabą referencją. Stan jest inicjalizowany w WeakKeyDictionary()  
    def __get__(self, instance, owner): # przy Planet.radius_metres.__get__(earth, Planet)  
        return self._instance_data[instance]  
  
    def __set__(self, instance, value):  
        if value <= 0:  
            raise ValueError(f"Value {value} is not positive")  
        self._instance_data[instance] = value  
  
    def __delete__(self, instance):  
        raise AttributeError("cant delete attribute")  
  
class Planet:  
    def __init__(self, name, radius_metres, mass_kilograms, orbital_period_seconds, surface_temperature_kelvin):  
        self.name = name  
        self.radius_metres = radius_metres  
        self.mass_kilograms = mass_kilograms  
        self.orbital_period_seconds = orbital_period_seconds  
        self.surface_temperature_kelvin = surface_temperature_kelvin  
  
    @property  
    def name(self):  
        return self._name  
  
    @name.setter  
    def name(self, value):  
        if not value:  
            raise ValueError("cannot set empty name")  
        self._name = value  
  
    radius_metres = Positive() # moje deskryptory są atrybutami klasy współdzielonymi przez instacje Planet  
    mass_kilograms = Positive()  
    orbital_period_seconds = Positive()  
    surface_temperature_kelvin = Positive()  
  
pluto = Planet(  
    name="Pluto",  
    radius_metres=2284e3,  
    mass_kilograms=1.305e22,  
    orbital_period_seconds=781912992,  
    surface_temperature_kelvin = 55,  
)  
  
# print(pluto.radius_metres) #2284000.0  
# print(Positive.__get__(Planet.__dict__["radius_metres"], pluto, Planet)) #2284000.0  
# pluto.radius_metres = -1 # ValueError: Value -1 is not positive  
  
mars = Planet(  
    name="Mars",  
    radius_metres=3389e3,  
    mass_kilograms=6.4171e23,  
    orbital_period_seconds=59355072,  
    surface_temperature_kelvin=210,  
)  
  
earth = Planet(  
    name="Earth",  
    radius_metres=6371e3,  
    mass_kilograms=5.972e24,  
    orbital_period_seconds=31557600,  # 365.25 dnia  
    surface_temperature_kelvin=288,  
)  
  
  
  
print(mars.__class__) #<class '__main__.Planet'>
```
