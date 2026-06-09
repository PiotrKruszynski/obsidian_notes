---
title: "function C"
type: concept
topic: c
tags: []
created: 2026-06-09
status: draft
---

main:  #c
Status: #pending 

Created: 2026-05-06  10:21
___


> [!NOTE]
> Zbiór instrukcji zamknięty pod identyfikatorem. 
**Cel:** re-używalność kodu, 



_function that displays the character passed as a parameter
```c
#include <unistd.h> // biblioteka pod write

void ft_putchar(char c) // deklaracja
{
    write(1, &c, 1);
}

int main(void) // wywołanie
{
    ft_putchar('a');        
    return (0);      
}
```

_function that displays the character passed as a parameter
```c
#include <unistd.h>

// Wskaźnik char *str pozwala przyjąć "ab"
void ft_put2char(char *znaki)
{
    write(1, znaki, 2);
}

int main(void)
{
*char = “ffffff”; tego stringa nie mozna nadpisac
char[] = {‘a’, ‘b’, ‘c’, ‘\0’}; to string ktory mozna nadpisac, to faktyczna tabela char
    ft_put2char("ab"); // Przekazujemy napis
    return 0;
}
```


_new line
```C
#include <unistd.h>

void ft_put_newline(void)
{
	char nl;
	nl = ‘\n’;
	write(1, &nl, 1);
}

int main(void)
{
	ft_put_newline();
	return (0);
}
```

_wypisanie całego alfabetu od 'a' do 'z'
```c
#include <unistd.h>

void ft_alphabet(char c)
{
	write(1,&c, 1);
}

int main(void)
{
	char first_letter;
	first_letter = ‘a’;
	
	while (first_letter <= ‘z’) {
		ft_alphabet(first_letter);
		first_letter++;
	}
	
	ft_alphabet(‘\n’);
}
```

_Wypisanie całego alfabetu od 'a' do 'z'
```c
#include <unistd.h>

void ft_alphabet(void)
{
	char *alphabet;
	alphabet = “abcdefghijklmnopqrstuvwxyz"
	write(1, alphabet, 26);
}

int main(void)
{
	ft_alphabet();
	return (0);
}

```

_super_
```c
#include <unistd.h>

void ft_putstr(char *str)
{
	int len;
	
	len = 0;
	while (str[len] != '\0')
	{
		len++;
	}
	
	write(1, str, len);
}

int main(void)
{
	ft_putstr("Cześć!");
	return (0);
}
```

_TO SAMO ZNAK O ZNAKU_

```c
void ft_putstr(char *str)
{
	int i;
	
	i = 0;
	while (str[i] != '\0')
	{
		write(1, &str[i], 1);  // Napisz jeden znak
		i++;
	}
}
```

```c
int ft_strlen(char *str)
{
	int len;
	
	len = 0;
	while (str[len])
		len++;
	
	return (len);
}
```




---

### Porównanie z Pythonem :

| **Cecha**                      | **Python**             | **C**                                |
| ------------------------------ | ---------------------- | ------------------------------------ |
| **Typowanie**                  | Dynamiczne             | Statyczne (jawne)                    |
| **Argumenty domyślne**         | Tak                    | Nie                                  |
| **Argumenty nazwane**          | Tak                    | Nie                                  |
| **Wiele wartości zwracanych**  | Tak (jako krotka)      | Nie (wymaga struktur lub wskaźników) |
| **Przeciążanie (overloading)** | Nie (ale jest `*args`) | Nie (wymaga różnych nazw lub C++)    |








___
Metadata:

Tags: #c #functions
