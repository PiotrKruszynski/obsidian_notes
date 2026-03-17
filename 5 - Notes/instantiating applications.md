Created: 2026-02-14  21:44
___
Note:

>[! Important]
>Uruchamianie pełnego stosu technologicznego (EC2, EBS, RDS) tradycyjnymi metodami może być czasochłonne ze względu na potrzebę instalacji oprogramowania, konfigurację zasobów oraz wprowadzanie danych początkowych. AWS oferuje kilka strategii przyspieszających ten proces:


**Instantiating applications quickly**:

• **[[Golden AMI]] (Złoty Obraz):** Polega na stworzeniu własnego obrazu AMI z zainstalowanymi wcześniej aplikacjami, zależnościami systemowymi i konfiguracją. Zapewnia to **najszybszy czas rozruchu**, ponieważ maszyna nie musi instalować niczego przy starcie.
• **[[Bootstrapping (User Data)]]:** Wykorzystanie skryptów User Data do dynamicznej konfiguracji przy pierwszym uruchomieniu. Jest to rozwiązanie elastyczne, ale wolniejsze niż Golden AMI.
• **Podejście hybrydowe:** Łączenie Golden AMI (dla stałych elementów) oraz skryptów User Data (dla zmiennych parametrów).
• [[Amazon RDS]] Zamiast ręcznej konfiguracji, można **przywrócić bazę danych z migawki (snapshot)**, co sprawia, że schematy i dane są gotowe od razu po uruchomieniu instancji.
• [[Amazon EBS Volume]] Przywrócenie wolumenu EBS z migawki pozwala na natychmiastowe uzyskanie sformatowanego dysku z kompletem danych.

**3. Zarządzane usługi do wdrażania aplikacji**

• **[[Elastic Beanstalk]]:** Usługa zorientowana na programistów, która automatycznie obsługuje **prowizjonowanie pojemności, równoważenie obciążenia (load balancing), skalowanie oraz monitorowanie stanu aplikacji**. Programista odpowiada jedynie za kod aplikacji.

• **[[AWS App Runner]]:** W pełni zarządzana usługa do szybkiego wdrażania aplikacji webowych i API na dużą skalę, startując bezpośrednio z kodu źródłowego lub obrazu kontenera. Nie wymaga doświadczenia w zarządzaniu infrastrukturą.

**4. Infrastruktura jako kod (IaC)**

• **[[AWS CloudFormation]]:** Deklaratywny sposób opisywania infrastruktury w plikach tekstowych (JSON/YAML). Pozwala na **powtarzalne i uporządkowane tworzenie całych środowisk** (testowych, produkcyjnych) bez ręcznej ingerencji w konsolę.

• **[[AWS CDK (Cloud Development Kit)]]:** Umożliwia definiowanie zasobów chmurowych przy użyciu popularnych języków programowania, co jest następnie konwertowane na szablony CloudFormation.

**Podsumowanie kluczowych technologii:**

• **EC2 Image Builder:** Narzędzie do automatyzacji tworzenia i aktualizacji „bezpiecznych i utwardzonych” obrazów AMI.

• **AWS App2Container (A2C):** Narzędzie CLI do modernizacji aplikacji Java i .NET poprzez ich konteneryzację i wdrożenie na ECS, EKS lub App Runner.

• **Serverless (Lambda/Fargate):** Pozwala na uruchamianie kodu lub kontenerów bez konieczności zarządzania serwerami, co drastycznie skraca czas potrzebny na wdrożenie

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
