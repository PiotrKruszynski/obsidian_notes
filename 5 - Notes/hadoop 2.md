---
sr_due: 2026-07-01
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---
![[Pasted image 20260613100423.png]]

docs
[https://tinyurl.com/pw-hadoop-03](https://tinyurl.com/pw-hadoop-03 "https://tinyurl.com/pw-hadoop-03")


hbase

|   |
|---|
|tworzymy plik: nano hbase-happybase-example.py<br><br>uruchamiamy: python3 hbase-happybase-example.py|
|import happybase<br><br>  <br><br>connection = happybase.Connection('localhost')<br><br>print('Wydruk tabel w HBase:')<br><br>print(connection.tables())<br><br>  <br><br>tablename = "python-table"<br><br>  <br><br>column_family_name = 'cf1'<br><br>connection.create_table(<br><br>   tablename,<br><br>   {<br><br>       column_family_name: dict()  # Use default options.<br><br>   })<br><br>  <br><br>print('Polacznie do bazy danych')<br><br>table = connection.table(tablename)<br><br>column_name = f'{column_family_name}:imiona'<br><br>data = [<br><br>   'Ala',<br><br>   'Michal',<br><br>   'Jurek',<br><br>]<br><br>  <br><br>print('Zapis do HBase.')<br><br>for i, value in enumerate(data):<br><br>   row_key = f'row-key{i}'<br><br>   table.put(<br><br>       row_key, {column_name.encode('utf-8'): value.encode('utf-8')}<br><br>   )<br><br>  <br><br>print('Pobieranie danych z HBase:')<br><br>key = 'row-key0'.encode('utf-8')<br><br>row = table.row(key)<br><br>print(f'\t{key}: {row[column_name.encode("utf-8")]}')<br><br>  <br><br>print('Scanning po wszystkie dane:')<br><br>  <br><br>for key, row in table.scan():<br><br>   print(f'\t{key}: {row[column_name.encode("utf-8")]}')|
Ten kod pokazuje pełny cykl pracy z **HBase przez bibliotekę HappyBase**:

1. połączenie z HBase,
2. utworzenie tabeli,
3. zapis danych,
4. odczyt jednego rekordu,
5. skanowanie wszystkich rekordów.

Przejdźmy linia po linii.

---

## 1. Import biblioteki

```
import happybase
```

Importuje klienta Pythona do komunikacji z HBase.

HappyBase korzysta pod spodem z **Thrift**, który jest warstwą komunikacyjną HBase.

---

## 2. Połączenie

```
connection = happybase.Connection('localhost')
```

Tworzysz połączenie do HBase działającego na lokalnej maszynie.

Schemat:

```
Python   ↓HappyBase   ↓Thrift   ↓HBase
```

---

## 3. Wyświetlenie istniejących tabel

```
print('Wydruk tabel w HBase:')print(connection.tables())
```

Metoda:

```
connection.tables()
```

zwraca listę wszystkich tabel.

Przykład:

```
[b'python-table', b'users']
```

Zwracane są bajty (`bytes`), nie stringi.

---

## 4. Nazwa tabeli

```
tablename = "python-table"
```

Tworzysz zmienną przechowującą nazwę tabeli.

---

## 5. Definicja rodziny kolumn

```
column_family_name = 'cf1'
```

W HBase najpierw definiujesz rodziny kolumn.

W relacyjnej bazie:

```
Tabela:usersid | name | city
```

W HBase:

```
userscf1:namecf1:city
```

gdzie:

```
cf1
```

to rodzina kolumn.

---

## 6. Tworzenie tabeli

```
connection.create_table(    tablename,    {        column_family_name: dict()    })
```

To tworzy tabelę:

```
python-table
```

z jedną rodziną kolumn:

```
cf1
```

Parametr:

```
dict()
```

oznacza:

```
{}
```

czyli użyj domyślnych ustawień HBase.

Efektywnie:

```
connection.create_table(    "python-table",    {        "cf1": {}    })
```

---

## 7. Uzyskanie uchwytu do tabeli

```
table = connection.table(tablename)
```

To jeszcze nie pobiera danych.

To tylko obiekt reprezentujący tabelę.

Możesz myśleć o tym jak:

```
cursor = connection.cursor()
```

w SQL.

---

## 8. Nazwa kolumny

```
column_name = f'{column_family_name}:imiona'
```

Powstaje:

```
'cf1:imiona'
```

W HBase kolumnę zapisujesz jako:

```
rodzina:nazwa
```

czyli:

```
cf1:imiona
```

---

## 9. Dane do zapisania

```
data = [    'Ala',    'Michal',    'Jurek',]
```

Lista trzech wartości.

---

# 10. enumerate()

Najciekawsza część.

```
for i, value in enumerate(data):
```

### Co robi enumerate?

Zwykła pętla:

```
for value in data:
```

dałaby:

```
AlaMichalJurek
```

Nie masz numeru elementu.

---

`enumerate()` dodaje indeks.

```
for i, value in enumerate(data):
```

zwraca kolejno:

```
(0, 'Ala')(1, 'Michal')(2, 'Jurek')
```

więc:

### Iteracja 1

```
i = 0value = 'Ala'
```

### Iteracja 2

```
i = 1value = 'Michal'
```

### Iteracja 3

```
i = 2value = 'Jurek'
```

To samo można zapisać bardziej jawnie:

```
for pair in enumerate(data):    print(pair)
```

wynik:

```
(0, 'Ala')(1, 'Michal')(2, 'Jurek')
```

---

## 11. Generowanie klucza rekordu

```
row_key = f'row-key{i}'
```

Powstają:

```
row-key0row-key1row-key2
```

Klucz wiersza jest odpowiednikiem PRIMARY KEY.

---

## 12. Zapis do HBase

```
table.put(    row_key,    {column_name.encode('utf-8'):     value.encode('utf-8')})
```

Po rozwinięciu pierwszej iteracji:

```
table.put(    'row-key0',    {        b'cf1:imiona': b'Ala'    })
```

Druga:

```
table.put(    'row-key1',    {        b'cf1:imiona': b'Michal'    })
```

---

### Dlaczego encode?

HBase przechowuje dane jako bajty.

Python:

```
'Ala'
```

to string.

HBase chce:

```
b'Ala'
```

więc:

```
'Ala'.encode('utf-8')
```

zamienia string na bytes.

---

## Jak wygląda tabela po zapisie?

Logicznie:

|row key|cf1:imiona|
|---|---|
|row-key0|Ala|
|row-key1|Michal|
|row-key2|Jurek|

---

# 13. Pobranie jednego rekordu

```
key = 'row-key0'.encode('utf-8')
```

Tworzysz klucz:

```
b'row-key0'
```

---

```
row = table.row(key)
```

Pobierasz cały rekord.

Wynik:

```
{    b'cf1:imiona': b'Ala'}
```

---

## Wyświetlenie

```
print(f'\t{key}: {row[column_name.encode("utf-8")]}')
```

Pobierasz wartość dla:

```
b'cf1:imiona'
```

czyli:

```
b'Ala'
```

---

# 14. Scan

```
for key, row in table.scan():
```

To odpowiednik:

```
SELECT * FROM table
```

HBase zwraca po kolei:

```
( b'row-key0', {b'cf1:imiona': b'Ala'})
```

potem:

```
( b'row-key1', {b'cf1:imiona': b'Michal'})
```

potem:

```
( b'row-key2', {b'cf1:imiona': b'Jurek'})
```

---

## Wyświetlenie każdego rekordu

```
print(f'\t{key}: {row[column_name.encode("utf-8")]}')
```

Wynik:

```
b'row-key0': b'Ala'b'row-key1': b'Michal'b'row-key2': b'Jurek'
```

---

## Co warto zapamiętać na egzamin

Najważniejsze pojęcia:

|Element|Odpowiednik SQL|
|---|---|
|table|tabela|
|row key|PRIMARY KEY|
|column family|grupa kolumn|
|put()|INSERT|
|row()|SELECT po kluczu|
|scan()|SELECT *|
|bytes|natywny format danych HBase|

O `enumerate()` często pytają:

```
for i, value in enumerate(lista):
```

- `i` → numer elementu (0,1,2...)
- `value` → wartość elementu

Przykład:

```
for i, x in enumerate(['A', 'B', 'C']):    print(i, x)
```

wynik:

```
0 A1 B2 C
```

To najczęstszy sposób generowania identyfikatorów (`row-key0`, `row-key1`, ...) podczas ładowania danych do HBase.