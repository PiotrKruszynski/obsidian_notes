Created: 2026-03-01  16:32
___
Note:

>[!tip]
>**VPC (Virtual Private Cloud):** A private network within AWS
>- **Limits:** Max 5 VPCs per region (soft limit)
>• Min. size is /28 (16 IP addresses) 
>• Max. size is /16 (65536 IP addresses)
>

**Understanding [[CIDR]] – IPv4**

- **Classless Inter-Domain Routing:** A method for allocating IP addresses used in Security Groups rules and AWS networking in general.
- **IP Address Range Definition:**
    - `WW.XX.YY.ZZ/32` => Represents a single fixed IP address.
    - `0.0.0.0/0` => Represents all possible IP addresses.
    - **Example:** `192.168.0.0/26` defines a range from `192.168.0.0` to `192.168.0.63` (64 IP addresses).

**Public vs. Private IP (IPv4)**

- **IANA (Internet Assigned Numbers Authority):** Established specific blocks of IPv4 addresses for private (LAN) and public (Internet) use.
- **Private IP Ranges:**
    - `10.0.0.0 – 10.255.255.255 (10.0.0.0/8)` – Used in large networks.
    - `172.16.0.0 – 172.31.255.255 (172.16.0.0/12)` – Default AWS VPC range.
    - `192.168.0.0 – 192.168.255.255 (192.168.0.0/16)` – Commonly used in home networks.
- **Public IPs:** All other addresses not in the private ranges are considered Public.

**Default VPC Walkthrough**

- All new AWS accounts come with a **default VPC**.
- New EC2 instances are launched into the default VPC if no specific subnet is chosen.
- Characteristics: Has Internet connectivity, and all instances receive public IPv4 addresses and both public/private DNS names.

**VPC in AWS – IPv4**

- **VPC (Virtual Private Cloud):** A private network within AWS.
- **Limits:** Max 5 VPCs per region (soft limit).
- **CIDR Configuration:**
    - Max 5 CIDRs per VPC.
    - **Min size:** `/28` (16 IP addresses).
    - **Max size:** `/16` (65,536 IP addresses).
- **Restriction:** VPC CIDRs should NOT overlap with other connected networks (like corporate data centers).

**VPC – Subnet (IPv4)**

- **AWS Reserved IPs:** AWS reserves **5 IP addresses** (the first 4 and the last 1) in every subnet.
    - `.0`: Network Address.
    - `.1`: Reserved for the VPC router.
    - `.2`: Reserved for mapping to Amazon-provided DNS.
    - `.3`: Reserved for future use.
    - `.255`: Network Broadcast Address (broadcast is not supported in VPC).
- **Exam Tip:** If you need 29 addresses, a `/27` (32 IPs) is not enough because `32 - 5 = 27`, which is less than 29. You would need a `/26`.
# VPC – Peering vs Sharing  
  
> [!tip]  
> **Mental model:**  
> Peering = "połącz  2sieci VPC“  
> Sharing = "współdziel jedną sieć"  
  
---  
  
## 🔁 VPC Peering (connectivity)  
  
- połączenie **2 VPC**  
- ruch prywatny (AWS network)  
- wymaga:  
- non-overlapping CIDR  
- route tables update  
  
### ❗ Ograniczenia  
- ❌ brak transitive routing (A↔B, B↔C ≠ A↔C)  
- ❌ słabo się skaluje (mesh problem)  
  
> [!exam]  
> Peering = point-to-point network link  
  
---  

## 🏢 VPC Sharing (AWS RAM)
- **You do NOT share the entire VPC**
- **You share selected SUBNETS from the VPC**
- Other AWS accounts (in the same AWS Organization) can deploy resources into these subnets

> [!tip]
> VPC = owned by one account  
> Subnets = shared with other accounts  

> [!exam]
> VPC Sharing = sharing subnets, not the VPC itself

---  
  
## ⚖️ Kluczowe różnice  
  
| Feature | VPC Peering | VPC Sharing |  
|--------|-------------|------------|  
| Model | 2 VPC | 1 VPC |  
| Cel | komunikacja | współdzielenie |  
| Routing | wymagany | nie |  
| Skalowanie | słabe | dobre (org) |  
  
---  
  
## 🔥 Decision rules  
  
- masz **2 istniejące VPC i chcesz komunikację** → **Peering**  
- masz **multi-account i chcesz jedną sieć** → **Sharing**  
  
---  
  
## 🧠 Minimal context (dlaczego to działa)  
  
- VPC = boundary routingu  
- Peering → łączy **dwa boundary**  
- Sharing → usuwa problem, bo jest **jedno boundary**

___
Metadata:

```yaml
---
type: tool    # concept | service | comparison
language: aws
---
```

Status: #pending
Tags: #aws #vpc
