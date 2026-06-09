---
title: "main - c"
type: concept
topic: c
tags: []
created: 2026-06-09
status: draft
---

# argc, argv i sortowanie argumentów programu w C

## Cel zakresu

Ten zakres dotyczy pracy z argumentami przekazywanymi do programu z linii komend:

```bash
./program arg1 arg2 arg3
```

W C argumenty te są dostępne przez parametry funkcji `main`:

```c
int	main(int argc, char **argv)
```

To fundament pisania prostych programów CLI: czytanie argumentów, iterowanie po nich, wypisywanie ich oraz sortowanie jako tekstów.

---

## `argc`

`argc` oznacza liczbę argumentów przekazanych do programu.

Wlicza się w to również nazwę programu:

```bash
./program hello world
```

Daje:

```c
argc == 3
```

Bo:

```txt
argv[0] = "./program"
argv[1] = "hello"
argv[2] = "world"
```

Zasada:

```txt
liczba realnych argumentów użytkownika = argc - 1
```

---

## `argv`

`argv` to tablica stringów.

```c
char **argv
```

Można to czytać jako:

```txt
argv -> tablica wskaźników
argv[i] -> pojedynczy string
argv[i][j] -> pojedynczy znak w stringu
```

Przykład:

```bash
./program abc def
```

Pamięć logicznie:

```txt
argv[0] -> "./program"
argv[1] -> "abc"
argv[2] -> "def"
argv[3] -> NULL
```

Dostęp do znaku:

```c
argv[1][0] == 'a'
argv[1][1] == 'b'
argv[1][2] == 'c'
argv[1][3] == '\0'
```

---

## Pomijanie `argv[0]`

`argv[0]` to nazwa programu, nie argument użytkownika.

Dlatego iterację po argumentach użytkownika zwykle zaczyna się od:

```c
i = 1;
```

a kończy przed:

```c
i < argc
```

Przykład:

```c
i = 1;
while (i < argc)
{
	/* argv[i] */
	i++;
}
```

---

## Wypisywanie stringa przez `write`

`write` nie zna stringów. Dostaje adres i liczbę bajtów.

Sygnatura:

```c
write(int fd, const void *buf, size_t count);
```

Dla wypisywania jednego znaku:

```c
write(1, &str[i], 1);
```

Dla wypisywania stringa bez `strlen` trzeba iterować do `'\0'`:

```c
void	ft_putstr(char *str)
{
	int	i;

	i = 0;
	while (str[i])
	{
		write(1, &str[i], 1);
		i++;
	}
}
```

Nowa linia:

```c
write(1, "\n", 1);
```

---

## Iteracja po argumentach w kolejności normalnej

Schemat:

```c
int	i;

i = 1;
while (i < argc)
{
	ft_putstr(argv[i]);
	write(1, "\n", 1);
	i++;
}
```

To przechodzi po:

```txt
argv[1], argv[2], ..., argv[argc - 1]
```

---

## Iteracja po argumentach w kolejności odwrotnej

Ostatni argument ma indeks:

```c
argc - 1
```

Schemat:

```c
int	i;

i = argc - 1;
while (i > 0)
{
	ft_putstr(argv[i]);
	write(1, "\n", 1);
	i--;
}
```

Warunek:

```c
i > 0
```

celowo pomija `argv[0]`.

---

## Porównywanie stringów ASCII

Sortowanie tekstów wymaga funkcji porównującej dwa stringi.

Klasyczny model `strcmp`:

```c
int	ft_strcmp(char *s1, char *s2)
{
	int	i;

	i = 0;
	while (s1[i] && s1[i] == s2[i])
		i++;
	return (s1[i] - s2[i]);
}
```

Interpretacja wyniku:

```txt
< 0  -> s1 jest przed s2
== 0 -> s1 i s2 są równe
> 0  -> s1 jest po s2
```

Przykład:

```c
ft_strcmp("abc", "abd") < 0
```

bo:

```txt
'c' - 'd' < 0
```

ASCII order oznacza porządek według kodów znaków, nie według „ludzkiego alfabetu”.

Przykładowo:

```txt
'0'..'9' < 'A'..'Z' < 'a'..'z'
```

---

## Sortowanie tablicy `argv`

Argumenty można sortować przez zamianę wskaźników, nie przez kopiowanie tekstu.

To jest ważne: `argv[i]` jest typu `char *`.

Zamiana:

```c
char	*tmp;

tmp = argv[i];
argv[i] = argv[j];
argv[j] = tmp;
```

Nie ruszasz zawartości stringów. Przestawiasz tylko wskaźniki.

---

## Prosty schemat sortowania

Najprostszy wariant: porównuj każdy element z każdym następnym i zamieniaj, jeśli są w złej kolejności.

```c
int		i;
int		j;
char	*tmp;

i = 1;
while (i < argc - 1)
{
	j = i + 1;
	while (j < argc)
	{
		if (ft_strcmp(argv[i], argv[j]) > 0)
		{
			tmp = argv[i];
			argv[i] = argv[j];
			argv[j] = tmp;
		}
		j++;
	}
	i++;
}
```

Po tej operacji zakres:

```txt
argv[1] ... argv[argc - 1]
```

jest posortowany rosnąco według ASCII.

---

## Minimalny zestaw helperów

Do tego zakresu zwykle wystarczą:

```c
void	ft_putstr(char *str);
int		ft_strcmp(char *s1, char *s2);
```

`ft_putstr` odpowiada za wypisanie stringa.

`ft_strcmp` odpowiada za porządek sortowania.

---

## Typowe błędy

### Mylenie `argv` i `argv[i]`

```c
argv
```

to cała tablica argumentów.

```c
argv[i]
```

to jeden argument jako string.

```c
argv[i][j]
```

to jeden znak.

---

### Wypisywanie od `argv[0]`

Jeśli celem są argumenty użytkownika, zaczynasz od:

```c
i = 1;
```

Nie od:

```c
i = 0;
```

---

### Zły warunek końca

Poprawnie:

```c
while (i < argc)
```

bo ostatni poprawny indeks to:

```c
argc - 1
```

---

### Porównanie wskaźników zamiast stringów

Błąd:

```c
if (argv[i] > argv[j])
```

To porównuje adresy w pamięci, nie tekst.

Poprawnie:

```c
if (ft_strcmp(argv[i], argv[j]) > 0)
```

---

### Próba kopiowania stringów zamiast wskaźników

Nie trzeba robić ręcznej kopii znak po znaku.

Wystarczy zamienić:

```c
argv[i]
```

z:

```c
argv[j]
```

bo to są wskaźniki.

---

### Brak nowej linii

Każdy wypisany argument powinien być zakończony:

```c
write(1, "\n", 1);
```

---

## Mental model

```txt
argc mówi ile jest stringów w argv.
argv jest tablicą stringów.
argv[0] to program.
argv[1..argc-1] to dane wejściowe użytkownika.
String kończy się na '\0'.
write wypisuje bajty, nie stringi.
Sortowanie argv to zamiana wskaźników char *, nie kopiowanie tekstu.
```
