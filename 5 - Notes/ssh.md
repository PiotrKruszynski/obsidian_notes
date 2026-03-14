#linux 

`man ssh-keygen` -> instrukcja

AWS daje tylko private bo public leci od razu na serwer

| **Opcja**  | **Co robi**                | **Kiedy używać**            |
| ---------- | -------------------------- | --------------------------- |
| -t         | typ klucza                 | tworzenie klucza            |
| -f         | plik klucza                | _wskazanie pliku_           |
| -C         | komentarz                  | opis klucza                 |
| -y         | _public key z private key_ | gdy masz tylko .pem         |
| -p         | zmiana hasła klucza        | dodanie / zmiana passphrase |
| -l         | fingerprint klucza         | weryfikacja                 |
| -R         | usuwa host z known_hosts   | gdy zmienił się serwer      |
| -t ed25519 | najlepszy typ klucza       | standard today              |

| **Komenda** | **Do czego służy**           | **Przykład**                  |
| ----------- | ---------------------------- | ----------------------------- |
| ssh         | logowanie na serwer          | ssh user@server               |
| scp         | kopiowanie plików            | scp file.txt user@server:/tmp |
| ssh-keygen  | _tworzenie kluczy_           | ssh-keygen -t ed25519         |
| ssh-agent   | przechowuje klucze w pamięci | eval "$(ssh-agent -s)"        |
| ssh-add     | dodaje klucz do agenta       | ssh-add ~/.ssh/id_ed25519     |

generowanie klucza
`ssh-keygen -t ed25519`
powstaje:
	`~/.ssh/id_ed25519`
	`~/.ssh/id_ed25519.pub`

generowanie klucza z nazwą
`ssh-keygen -t ed25519 -f mykey -C "aws-key"`

wyciągnięcie public key z private key
`ssh-keygen -y -f labsuser.pem`

Sprawdzam czy plik istnieje:
`ls ~/Downloads | grep labsuser`

Change mode zmienia uprawnienia  żeby nie za szeroko
`chmod 400 ~/Downloads/labsuser.pem`

Tunelowanie . Otwieram TCP connection 
	Mac → TCP port 22 → EC2
	Handshake TCP

Tunelowanie, przykład dla jupyther
`ssh -i LOKALIZACJA KLUCZA ubuntu@PUBLIC_IP -L 8888:127.0.0.1:8888`
`ssh -i ~/Downloads/labsuser.pem ubuntu@PUBLIC_IP`

Po połączeniu na wejściu najlepiej :
`[ec2-user@ip-172-31-22-143 ~]$ sudo su`
`[root@ip-172-31-22-143 ec2-user]# yum update`

konfiguracja:
`~/.ssh/config` -> do niego dopisać
```bash
Host aws
    HostName 54.147.3.55
    User ubuntu
    IdentityFile ~/Downloads/labsuser.pem
```
od teraz `ssh aws`
