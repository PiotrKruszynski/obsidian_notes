od python 3.5 PEP 484

	 pozwala osiągnąc virtual static typing
	 nie działa w runtime 🚫
	 przypadkowe błędy
	 intelisense w Pycharm
	 pisanie docs
	 jakość kodu

[[type inference]] 

[[mypy]] - tam istnieje ściąga, która mówi nam co jak zapisać
[[Pyright]]

zmienne
	x: str = "a"
	można też tak:
	x: str
	x = "a"
fn
	def name ( a: str, b: int) -> str:

y: callable[ [ int ], int  ] = lambda x: x

x: Sequence[int]
x[1:2]

yolo: Iterbale[int]             # bo pętle zwracają tylko iterable
for x in yolo:

T = TyperVar("T", intm str ) # ale mogą być wszystkie z __add__

def magic(a: T  ,  b: T ) -> T
	return a  +  b

