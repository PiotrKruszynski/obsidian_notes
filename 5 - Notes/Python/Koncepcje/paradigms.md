---
title: "paradigms"
type: concept
topic: python
tags: ["python"]
created: 2026-06-09
status: draft
---

### **1.** **Imperative Programming**
[[imperative programming]]
  

> Focus: _How_ to do things step by step.

  

- Uses statements and control flow (for, if, etc.)
    
- Most Python code falls into this category by default.
    
- Example: writing loops to iterate and mutate variables.
    

---

### **2.**  **Procedural Programming** **(subset of imperative)**
  [[procedural programming]]
  

> Focus: organizing code into procedures (functions).

  

- Code is split into reusable function blocks.
    
- Avoids repetition, improves readability.
    
- Often used for scripts and automation.
    

---

### **3.** **Object-Oriented Programming (OOP)**
[[oop]]
  

> Focus: _Encapsulating state and behavior_ in objects.

  

- Classes define templates for objects (state = attributes, behavior = methods).
    
- Core principles: encapsulation, inheritance, polymorphism.
    
- Python supports OOP with class, self, etc.
    

  

✅ Great for: modeling complex systems with interacting entities.

🧠 Tip: Use OOP when managing _mutable state_ and behavior tightly coupled to data.

---

### **4.** **Functional Programming (FP)**
[[functional programming]]
  

> Focus: _Separating state from behavior_, emphasizing pure functions.

  

- Core ideas: immutability, first-class functions, no side effects.
    
- Uses functions like map, filter, reduce, recursion.
    
- Python is _not a purely functional language_, but supports functional features.
    

  

✅ Use FP for: transforming data, stateless computations, testability.

---

### **5.**  **Declarative Programming** **(less common in core Python)**
[[declarative programming]]
  

> Focus: _What_ should happen, not _how_.

  

- Examples: list comprehensions, generator expressions.
    
- SQL-like DSLs, regex, and some libraries (e.g., pandas.query, dataclasses) follow this style.
