---
title: "stack"
type: concept
topic: algorithms
tags: []
created: 2026-06-09
status: draft
---

## 🔹 Stack to struktura danych typu **LIFO (Last In, First Out)**

W kontekście **pamięci programu**, **stack (stos)** to specjalny obszar w **RAM-ie**, który służy do przechowywania:

- ramek wywołań funkcji (tzw. stack frames),
    
- zmiennych lokalnych,
    
- adresów powrotu z funkcji,
    
- kontekstu działania programu.

## 🗂 Skład ramki stosu (stack frame):

- **Adres powrotu** – gdzie wrócić po zakończeniu funkcji
    
- **Parametry funkcji** – przekazane przy wywołaniu
    
- **Zmienne lokalne** – np. `a` w funkcji `f()`
    
- **Referencje do obiektów** – ale same obiekty są w stercie

## 🔄 Stack to dynamiczny, ale **ograniczony** zasób

- Stack **powiększa się i zmniejsza** wraz z wywołaniami funkcji.
    
- Ale jego rozmiar jest ograniczony — np. 1 MB – 8 MB dla wątku.
    
- Gdy przekroczysz limit (np. przez nieskończoną rekurencję), dostajesz:
    
    `RecursionError: maximum recursion depth exceeded`

[[data structure]]
