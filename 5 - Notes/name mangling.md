Created: 2026-01-04  16:07
___
Note:

**Name mangling** to mechanizm _kompilacyjny_ (na etapie tworzenia klasy), który **zmienia nazwę atrybutów/metod zaczynających się od __ i niekończących się __**.

Celem nie jest bezpieczeństwo, tylko **uniknięcie kolizji nazw w hierarchii dziedziczenia**.

```python
class X:
    __value = 42
```
interpreter zapisuje jako
```python
X._X__value == 42
```
i dlatego
```bash
X.__value        # AttributeError
X._X__value      # OK
```

### **Co to**  **nie** **jest**

- ❌ **Nie** jest to prywatność jak w Java/C++
- ❌ **Nie** blokuje dostępu — tylko **utrudnia przypadkowy**
- ❌ **Nie** działa dla nazw kończących się __ (__init__, __repr__)

### **Mentalny model (senior)**

- __name = _unikalna przestrzeń nazw klasy_
- To **mechanizm antykolizyjny**, nie enkapsulacja
- Python ufa programiście, nie wymusza barier

### **Techniki zapamiętywania**

- **Mnemonika**: __ → „_Rename me for this class_”
- **Asocjacja**: _ClassName__attr = „należy do tej klasy”
- **Wzorzec strukturalny**: _namespace isolation_, nie access control

___
Metadata:

```yaml
---
type: concept    # concept | tool | pattern
language: python # python | js | sql | etc.
---
```

Status: #pending
Tags: #empty
