---
title: "tmux"
type: tool
topic: docker
tags: []
created: 2026-06-09
status: draft
---

Created: 2026-03-14  13:35
___
Note:


| Klawisz | Znaczenie |
|---|---|
| `Ctrl + b` | prefix – wszystkie komendy tmux zaczynają się od tego |
# 1. Sesje

| Komenda | Co robi |
|---|---|
| `tmux` | uruchamia nową sesję |
| `tmux new -s dev` | tworzy nazwaną sesję `dev` |
| `tmux ls` | lista sesji |
| `tmux attach -t dev` | powrót do sesji |
| `tmux kill-session -t dev` | usuwa sesję |
| `Ctrl + b` `d` | odłącza od sesji (sesja dalej działa) |
# 2. Okna (windows – jak karty)

| Skrót | Co robi |
|---|---|
| `Ctrl + b` `c` | nowe okno |
| `Ctrl + b` `n` | następne okno |
| `Ctrl + b` `p` | poprzednie okno |
| `Ctrl + b` `w` | lista okien |
| `Ctrl + b` `,` | zmiana nazwy okna |
| `Ctrl + b` `0–9` | przejście do konkretnego okna |
# 3. Panele (pane – podział ekranu)

| Skrót                | Co robi                      |
| -------------------- | ---------------------------- |
| `Ctrl + b` `%`       | podział pionowy              |
| `Ctrl + b` `"`       | podział poziomy              |
| `Ctrl + b` `← ↑ → ↓` | przełączanie między panelami |
| `exit`               | zamyka panel                 |
# 4. Scroll i inne

| Skrót          | Co robi                |
| -------------- | ---------------------- |
| `Ctrl + b` `[` | tryb scrollowania      |
| `q`            | wyjście z trybu scroll |
| `Ctrl + b` `:` | command mode           |
# Typowy workflow na serwerze

| Krok         | Komenda                |
| ------------ | ---------------------- |
| start sesji  | `tmux new -s dev`      |
| nowe zadanie | `Ctrl + b` `c`         |
| logi obok    | `Ctrl + b` `%` lub `"` |
| odłączenie   | `Ctrl + b` `d`         |
| powrót       | `tmux attach -t dev`   |


___
Metadata:

```yaml
---
type: tool    # concept | tool | pattern
language: linux  # tmux
---
```

Status: #pending
Tags: #tmux  #linux
