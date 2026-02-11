Created: 2026-02-11  10:34
___
Note:

>[! Important]
>**Amazon RDS Custom** to wyspecjalizowana usługa bazodanowa przeznaczona dla silników:
>- **Oracle** 
>- **Microsoft SQL Server**, 
>
>która łączy zalety zarządzanej usługi RDS z możliwością głębokiej personalizacji.

Oto kluczowe informacje na temat tej usługi:

1. Pełna kontrola nad systemem (Full Control)

 **pełny dostęp administracyjny do warstwy OS oraz bazy danych**. 

Dzięki temu możesz:
• **Konfigurować specyficzne ustawienia** systemu operacyjnego i bazy danych.
• **Instalować własne łatki (patches)** i oprogramowanie firm trzecich.
• **Włączać natywne funkcje** bazy danych, które nie są wspierane w standardowym modelu RDS.

2. Sposoby dostępu

RDS Custom to jedyny wariant usługi RDS, który pozwala na bezpośredni dostęp do infrastruktury pod spodem. Możesz połączyć się z powiązaną instancją EC2 za pomocą:

• **Protokołu SSH**.
• **AWS Systems Manager (SSM) Session Manager**.

3. Zarządzanie i Automatyzacja

Mimo większej swobody, AWS wciąż automatyzuje konfigurację, operacje i skalowanie bazy danych.

• **Tryb automatyzacji (Automation Mode):** Aby przeprowadzić własne modyfikacje, należy **tymczasowo wyłączyć tryb automatyzacji**. AWS zaleca wykonanie migawki (snapshot) bazy danych przed przystąpieniem do wprowadzania zmian.

• **Model współdzielonej odpowiedzialności:** W RDS Custom użytkownik przejmuje większą odpowiedzialność za stabilność systemu po wprowadzeniu własnych zmian w systemie operacyjnym.

4. Porównanie: RDS vs RDS Custom

• **Standardowy RDS:** AWS zarządza całą bazą danych i systemem operacyjnym; użytkownik nie ma dostępu do warstwy OS ani SSH.

• **RDS Custom:** Użytkownik ma pełne uprawnienia administratora do OS i bazy danych, co pozwala na dostosowanie środowiska pod specyficzne wymagania aplikacji.

**Główny przypadek użycia:** RDS Custom jest idealnym rozwiązaniem dla aplikacji, które wymagają **specyficznych modyfikacji systemu operacyjnego** lub korzystają z funkcji bazodanowych wymagających uprawnień roota/administratora, a jednocześnie chcą korzystać z częściowej automatyzacji oferowanej przez Amazon RDS.

![[Pasted image 20260211104014.png]]

___
Metadata:

```yaml
---
type: tool    # concept | service | comparison
language: aws
---
```

Status: #pending
Tags: #aws #rds
