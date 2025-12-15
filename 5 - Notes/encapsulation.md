ograniczenie dostępu

Najczęściej za pomocą access modifiers:
1 private -> ==`__name`== (w dok. jest napisane aby nie używać z powodu name mangling)
2 protected -> `_name` ograniczenie do klasy i klas dziedziczących
3 public -> `name` tylko ten można używać w python
4 read only -> `NAME`

==Czy to dobrze?==
Tak, jeżeli chodzi o szybkość pisania, łatwy próg wejścia, nie trzeba o tym myśleć. 
W zaawansowanym użyciu powoduje to możliwość nieświadomego użycia czegoś czego nie powinien. Jedna metoda potrzebuje być wywoływana przez inną metodę, aby setowała odpowiedni stan.

==Czy można powiedzieć, że w pythonie nie ma hermetyzacji?==
Class sama w sobie ogranicza dostęp. 
Tak samo jest z plikiem (jawny import w przypadku chęci)
CO w pythonie ogranicza dostęp
namespace




przykład enkapsulacji w python
![[Pasted image 20250716225728.png]]