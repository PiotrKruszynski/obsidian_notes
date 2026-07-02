---
title: "ssh commands"
type: concept
topic: networking
tags: ["linux", "ssh"]
created: 2026-06-09
status: draft
sr_due: 2026-07-17
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

| Komenda                      | Co robi                                             | Kiedy używać                          |
| ---------------------------- | --------------------------------------------------- | ------------------------------------- |
| `ssh user@server`            | loguje na serwer                                    | gdy używasz domyślnego klucza / hasła |
| `ssh -i key.pem user@server` | loguje na serwer wskazanym kluczem                  | gdy masz konkretny plik klucza        |
| `scp file user@server:/tmp`  | kopiuje plik na serwer                              | szybki transfer plików                |
| `ssh-copy-id user@server`    | kopiuje public key do `authorized_keys` na serwerze | gdy chcesz logować się bez hasła      |
| `ssh -v user@server`         | pokazuje debug połączenia SSH                       | gdy coś nie działa                    |
