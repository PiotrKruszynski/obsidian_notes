wzorzec dopasowania

używamy do walidacji danych


do pythona 3.10 mielismy
- sprawdzanie warunków ręczne if /else
- słownik dla konkretnych bez np. większe niż
- ternary operations zagnieżdżone w sobie

`value_if_true *if* condition *else* value_if_false`

```python
# simple match  
def ex_1():  
    while True:        command = input('Enter command: \n')  
        match command:  
            case "add todo":  
                print(f'Todo added!')  
            case "show todos":  
                print(f'Yours todos')  
            case "bye":  
                print(f'Bye bye!')  
                break  
            case _:  
                print('Invalid command!')  
  
  
# match on different types  
def ex_2():  
    for x in 1, "two", 3.14, Exception('yolo'), lambda data: data +42:  
        match x:  
            case int():  
                print(f"{x} is an integer")  
            case str():  
                print(f"{x} is a string")  
            case float():  
                print(f"{x} is a number")  
            case Exception():  
                print(f"{x} is an exception")  
            case y:  
                print(f"unknown: {y}")  
  
ex_2()  
  
# guarded matching  
def ex_3():  
    for i in range(5):  
        match i:  
            case 1 | 3 | 5 if i < 4:  
                print(f"{i} is odd and less than 4")  
            case 1 | 3 | 5 if i > 4:  
                print(f"{i} is even and greater than 4")  
            case 2 | 4:  
                print(f"{i} is even")  
  
ex_3()  
  
  
def ex_4():  
    for colls in [1, 2, 3], (4, 5, 6), {"a": 42}:  
        match colls:  
            case [1, 2, 3] as my_list:  
                print(f"list: {my_list}")  
  
            case (_, 5 as my_int, _) as my_tuple:  
                print(f"tuple: {my_tuple} with {my_int}")  
  
            case {"a": 42} as my_dict:  
                print(f"dict: {my_dict}")  
  
            case _:  
                print("unknown")  
  
ex_4()  
  
#walrus operator  
def ex_5():  
    match the_answer := 2 * 1 * 3 * 7:  
        case _:  
            print(f"The answer is {the_answer}")
            
```


