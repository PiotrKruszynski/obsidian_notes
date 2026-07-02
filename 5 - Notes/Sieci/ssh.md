---
title: "ssh"
type: concept
topic: networking
tags: ["networking"]
created: 2026-06-09
status: draft
sr_due: 2026-07-07
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

#ssh, #linux

> SSH to **zaszyfrowany transport TCP z wbudowaną możliwością uruchamiania zdalnych procesów**


SSH to w praktyce **3 funkcje w jednym protokole**:

1️⃣ **remote shell** → `ssh`  
2️⃣ **file transfer** → `scp / sftp`  
3️⃣ **TCP tunnel** → `-L / -R`
  
protokół do:  
- zdalnego logowania  
- kopiowania plików  
- tunelowania TCP  
- działa na port `22`  
# Jak działa
1️⃣ klient otwiera połączenie TCP  
Mac → server:22  
2️⃣ handshake kryptograficzny  
- negocjacja algorytmów  
- wymiana klucza sesji  
3️⃣ weryfikacja hosta  
fingerprint zapisuje się w:  
`~/.ssh/known_hosts`  
4️⃣ authentication  
- password  
- public key  
5️⃣ powstaje **encrypted session**  
# Host verification  
przy pierwszym połączeniu:  
The authenticity of host can't be established
SSH zapisuje fingerprint do:  
`~/.ssh/known_hosts`  
jeśli serwer się zmieni:  
REMOTE HOST IDENTIFICATION HAS CHANGED

naprawa:  
`ssh-keygen -R IP`  
  

# SSH Agent  
problem:  
hasło do klucza wpisywane wiele razy.  
rozwiązanie:  
**ssh-agent**  
klucze trzymane w pamięci RAM.  
eval "$(ssh-agent -s)"  
ssh-add ~/.ssh/id_ed25519

# SSH Tunelowanie  
SSH potrafi przekierować ruch TCP.  
schemat:  
LOCAL_PORT → REMOTE_HOST → REMOTE_PORT
przykład:  
`ssh -L 8888:localhost:8888 ubuntu@server`

Mac → localhost:8888    
↓    
SSH tunnel    
↓    
server localhost:8888  
# Reverse Tunnel  
gdy serwer musi połączyć się do twojego komputera.  
`ssh -R 8080:localhost:3000 server`
serwer → localhost:8080    
↓    
twój komputer localhost:3000  
 
# Bastion Host  
częsty pattern w AWS.  
Mac  
↓  
bastion  
↓  
private server

  
połączenie:  
ssh -J bastion private-server

# SSH Multiplexing  
jedno połączenie SSH używane przez wiele sesji.  
przyspiesza logowanie.  
config:  
ControlMaster auto  
ControlPath ~/.ssh/control-%r@%h:%p  
ControlPersist 10m

  
# Najważniejsze pliki SSH  

| plik | rola |  
|---|---|  
| ~/.ssh/id_ed25519 | private key |  
| ~/.ssh/id_ed25519.pub | public key |  
| ~/.ssh/authorized_keys | klucze użytkownika |  
| ~/.ssh/known_hosts | fingerprinty serwerów |  
| ~/.ssh/config | skróty połączeń |  

# Najważniejsze komendy  

`ssh user@host  `
`ssh -i key.pem user@host  `
`scp file user@host:/tmp  `
`ssh -L 8888:localhost:8888 user@host  `
`ssh -v user@host`
