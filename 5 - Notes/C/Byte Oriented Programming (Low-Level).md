---
title: "Byte Oriented Programming (Low-Level)"
type: concept
topic: c
tags: []
created: 2026-06-09
status: draft
---

programowanie zorientowane bitowo - low level

bits - binary digits 0 1

bytes()
bytesarray()
memoryview()

# bitwise operator

|**Nazwa operacji**|**Symbol**|**Odpowiednik logiczny**|**Przykład**|**Wyjaśnienie**|
|---|---|---|---|---|
|Bitwise AND|&|and|5 & 3  → 1|101 & 011 = 001|
|Bitwise OR|\||or|5 \| 3 → 7|101 \| 011 = 111|
|Bitwise XOR|^|!= (exclusive OR)|5 ^ 3 → 6|101 ^ 011 = 110|
|Bitwise NOT (complement)|~|not|~5 → -6|Odwraca wszystkie bity (2’s complement)|
|Left shift|<<|—|5 << 1 → 10|101 << 1 = 1010|
|Right shift|>>|—|5 >> 1 → 2|101 >> 1 = 10|