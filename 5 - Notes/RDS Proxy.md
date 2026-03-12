Created: 2026-02-11  11:37
___
Note:

**Amazon RDS Proxy** to w pełni zarządzany proxy bazodanowy, który umożliwia aplikacjom tworzenie puli (pooling) oraz współdzielenie połączeń nawiązanych z bazą danych. Dzięki temu rozwiązaniu zwiększa się wydajność bazy danych poprzez zmniejszenie obciążenia jej kluczowych zasobów, takich jak procesor (CPU) i pamięć (RAM), a także minimalizuje się liczbę otwartych połączeń i ryzyko wystąpienia timeoutów.

Oto kluczowe aspekty tej usługi:
• **Skalowalność i dostępność:** RDS Proxy jest usługą typu **serverless**, która automatycznie się skaluje i charakteryzuje się wysoką dostępnością (Multi-AZ).
• **Szybszy Failover:** Usługa potrafi skrócić czas przełączania awaryjnego (failover) dla baz RDS i Aurora nawet o **66%**, zachowując przy tym istniejące połączenia.
• **Obsługiwane silniki:** Proxy wspiera bazy RDS (MySQL, PostgreSQL, MariaDB, MS SQL Server) oraz Amazon Aurora (MySQL, PostgreSQL).
• **Bezpieczeństwo:** RDS Proxy wymusza **uwierzytelnianie IAM** dla bazy danych i integruje się z **AWS Secrets Manager** w celu bezpiecznego przechowywania poświadczeń. Co istotne, proxy nigdy nie jest dostępne publicznie i musi być uzyskiwane z poziomu **VPC**.
• **Współpraca z AWS Lambda:** Jest to rozwiązanie szczególnie zalecane dla aplikacji korzystających z funkcji Lambda, które przy wysokim obciążeniu mogą otwierać zbyt wiele bezpośrednich połączeń z bazą. Proxy zarządza tymi połączeniami w sposób efektywny, poprawiając skalowalność całego systemu.
• **Brak zmian w kodzie:** Dla większości aplikacji wdrożenie RDS Proxy nie wymaga modyfikacji kodu źródłowego.
• **Monitorowanie:** Informacje o stanie i zdarzeniach RDS Proxy można monitorować poprzez **RDS Event Notifications**.

W architekturze rozwiązań AWS, RDS Proxy stanowi warstwę pośredniczącą, która pozwala oddzielić logikę aplikacji od fizycznych połączeń z instancją bazy danych, co jest kluczowe w projektowaniu wysoce dostępnych i wydajnych systemów.
# Amazon RDS Proxy – Overview

• **Fully managed** database proxy for RDS.
• Allows apps to **pool and share DB connections** (pula i współdzielenie połączeń).
• **Improving efficiency:** Reduces stress on CPU/RAM and minimizes open connections and timeouts.
• **Serverless**, autoscaling, and **highly available** (Multi-AZ).
• **Reduced failover time:** Skraca czas przełączania awaryjnego dla RDS & Aurora o **66%**.
• **Supported Engines:** RDS (MySQL, PostgreSQL, MariaDB, MS SQL Server) oraz Aurora (MySQL, PostgreSQL).
# Amazon RDS Proxy – Security & Access

• **No code changes** required for most applications.
• Enforce **IAM Authentication** for DB (wymusza uwierzytelnianie IAM).
• Securely store credentials in **AWS Secrets Manager**.
• **Not publicly accessible:** Proxy nigdy nie jest dostępne publicznie; must be accessed from **VPC**.
# Lambda with RDS Proxy
• **Problem:** Jeśli funkcje Lambda bezpośrednio uzyskują dostęp do bazy, mogą otworzyć zbyt wiele połączeń pod wysokim obciążeniem (high load).
• **Solution:** RDS Proxy improves **scalability** by pooling and sharing connections.
• **Deployment:** Lambda must be deployed in your **VPC**, ponieważ RDS Proxy nie jest dostępne publicznie

![[Pasted image 20260211113825.png]]


___
Metadata:

```yaml
---
type: tool    # concept | service | comparison
language: aws
---
```

Status: #pending
Tags: #aws
