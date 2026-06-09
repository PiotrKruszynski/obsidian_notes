---
title: "AWS Organizations"
type: service
topic: aws
tags: ["aws"]
created: 2026-06-09
status: draft
---

>[!important]  
>**AWS Organizations** to control plane dla multi-account AWS → zamiast jednego konta robisz **isolation + governance** przez wiele kont, a Organizations spina to w jedną strukturę. Działa jak organizacyjny "policy + billing + account factory layer" nad wszystkimi kontami.

---

## Core facts

- **Global service** (nie regionalny)
- Struktura:
  - `Root`
  - `OU (Organizational Units)` → logiczne grupowanie (np. prod / dev / security)
  - `Accounts`
- Typy kont:
  - **Management account** → kontroluje całą org, **NIE jest ograniczany przez SCP**
  - **Member accounts** → zależne od management account
- Account może należeć tylko do **jednej organizacji**

---

## SCP (Service Control Policies)

- Działają na poziomie OU / account
- Definiują **maksymalne uprawnienia** — guardrail, nie grant
- **SCP nie nadaje uprawnień** → tylko ogranicza (to robi IAM)
- Deny w SCP = **hard deny** (nie obejdziesz przez IAM)

### Dwie strategie:
| Strategia | Jak działa |
|---|---|
| **Deny list** (domyślna) | FullAWSAccess SCP aktywny, dodajesz Deny na co chcesz zablokować |
| **Allow list** | Usuwasz FullAWSAccess, zezwalasz tylko na konkretne akcje |

### Dziedziczenie:
```

Root SCP └── OU: Production └── Konto: prod-app

```
Konto dostaje **iloczyn** wszystkich SCP po drodze. Blokada wyżej = blokada wszędzie niżej.

---

## Billing

- **Consolidated Billing** → jedna metoda płatności dla całej org
- **Aggregated usage** → volume discounts (EC2, S3, etc.)
- **Shared Reserved Instances & Savings Plans** między kontami
  - ⚠️ RI sharing działa tylko jeśli **nie jest wyłączone** w billing preferences (firmy czasem wyłączają dla precyzyjnego chargeback per-konto)

---

## Kiedy używać

- **Multi-account strategy** (AWS recommended):
  - isolation: prod / dev / test / security / logging
  - blast radius reduction — oddzielne konta = awaria nie przechodzi dalej
- **Central governance** → enforce policies przez SCP
- **Cost optimization** → shared RI / Savings Plans
- **Enterprise / compliance** → różne teamy, BU, workloady

---

## Trade-offs

| + | - |
|---|---|
| Izolacja (security, fault isolation) | Większa złożoność operacyjna (IAM, networking, CI/CD cross-account) |
| Governance na poziomie org | SCP może zablokować dostęp (debug trudniejszy niż IAM policy) |
| Cost optimization przez agregację | Management account = single point of control (high risk) |

---

## Powiązane usługi

| Usługa | Rola |
|---|---|
| **SCP vs IAM policy** | SCP = guardrail (max permissions), IAM = actual permissions |
| **AWS Control Tower** | Opinionated setup dla Organizations (landing zone) |
| **IAM Identity Center (SSO)** | Central access management dla wielu kont |
| **AWS Cost Explorer** | Korzysta z consolidated billing |
| **Service Quotas / tagging** | Governance + cost allocation |

---

## Exam traps (SAA-C03)

- ❌ SCP nie nadaje uprawnień → tylko ogranicza
- ❌ Deny w SCP = hard deny, nie obejdziesz przez IAM
- ❌ Management account **nie jest ograniczany** przez SCP → krytyczne z perspektywy bezpieczeństwa
- ❌ Volume discount działa tylko przy consolidated billing
- ❌ Account nie może być w wielu Organizations
- ❌ RI sharing między kontami można wyłączyć w billing preferences
