programowanie zorientowane bitowo - low level

bits - binary digits 0 1

bytes()
bytesarray()
memoryview()

# bitwise operator

|**Operator**|**Nazwa**|**Opis**|**Przykład**|**Wynik**|
|---|---|---|---|---|
|&|AND|1 jeśli oba bity = 1|0b1100 & 0b1010|0b1000|
|`|`|OR|1 jeśli którykolwiek bit = 1|`0b1100|
|^|XOR (caret)|1 jeśli bity różne|0b1100 ^ 0b1010|0b0110|
|~|NOT (complement)|negacja bitów (two’s complement)|~0b00001111|-16|
|<<|Left Shift|przesunięcie w lewo (× 2ⁿ)|0b0001 << 3|0b1000|
|>>|Right Shift|przesunięcie w prawo (÷ 2ⁿ)|0b1000 >> 3|0b0001|