---
title: "IP multicast"
type: concept
topic: networking
tags: ["aws"]
created: 2026-06-09
status: draft
---

>[!tip]
>_IP multicast_ to metoda przesyłania pakietów IP do wielu odbiorców jednocześnie. 
>Zamiast wysyłać osobną kopię do każdego odbiorcy (jak w unicast), nadawca wysyła pakiet na specjalny adres grupy multicastowej. Tylko hosty, które dołączą do tej grupy, otrzymają dane. W ten sposób oszczędza się przepustowość, bo sieć rozprowadza pakiety tylko tam, gdzie są potrzebne.

IP Multicast jest wspierana przez [[Transit Gateway]]
