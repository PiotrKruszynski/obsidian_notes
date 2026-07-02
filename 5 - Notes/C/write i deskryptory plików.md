---
tags: [c, koncepcja, wyjście, syscall]
powiązane: ["[[String i null terminator]]", "[[Arytmetyka ASCII]]"]
sr_due: 2026-07-15
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# write i deskryptory plików

- `ssize_t write(int fd, const void *buf, size_t count)` — syscall: wypisz `count` bajtów spod adresu `buf`
- `fd` (deskryptor): `0` stdin · `1` stdout (ekran) · `2` stderr
- `write` zna **tylko bajty** — nie stringi, nie liczby
- jeden znak: `write(1, &c, 1)` (adres!); string: znak po znaku do `\0` albo z podaną długością
- liczby: sam zamieniasz cyfry na znaki — [[Arytmetyka ASCII]]

## Połączenia

- [[Arytmetyka ASCII]] — liczba → wypisywalny znak
- [[String i null terminator]] — gdzie kończy się string
- [[Wskaźnik]] — `buf` to adres
