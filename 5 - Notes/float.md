double, IEE754 , Bankers Rounting
nie reprezentuje rzeczywistej wartości, tylko aproksymacje ( pracuje na reprezentacji )

	```python
	a = 0.1 + 0.7 # bo binarnie ta liczba nie jest reprezentowana idealnie, chodzi o wydajność
	print(a)
	```
	
	zaokrąglenie - jak potrzebujesz to pewnie decimal 
	```python
	from decimal import Decimal, getcontext, ROUND_HALF_UP
	
	getcontext().rounding = ROUND_HALF_UP # ta linijka ustawia do końca programu
	
	a = round(Decimal(2.5555555555), ndigits=2 )
	print(a)
	```

precyzja double -> 64bity

11 + 1 + 53 ; 53 * log10(2)
