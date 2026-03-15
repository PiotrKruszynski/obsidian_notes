
#ssh #linux



`~/.ssh/config`

```bash
Host aws
  HostName 54.147.3.55
  User ubuntu
  IdentityFile ~/Downloads/labsuser.pem
```
od teraz:
`ssh aws`

agent
`eval "$(ssh-agent -s)"`
`ssh-add ~/.ssh/id_ed25519`

