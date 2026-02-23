Created: 2026-02-23  10:19
___
Note:

>[!tip]
>A fully managed service used to decouple (rozsprzęganie) applications

**Decoupling** → services communicate asynchronously to improve scalability and fault isolation

You can decouple your applications, 
• using SQS: queue model 
• using SNS: pub/sub model 
• using Kinesis: real-time streaming model

![[Pasted image 20260223110148.png]]

• **Standard Queue:**
    ◦ Unlimited throughput (MB/s) and unlimited messages in the queue.
    ◦ **Retention:** Default 4 days, maximum 14 days.
    ◦ **Message size:** Maximum 256 KB per message.
    ◦ **Delivery:** "At-least-once delivery" (occasionally duplicates may occur). BE PREPARE
    ◦ **Ordering:** "Best-effort ordering" (messages might arrive out of order). BE PREPARE

![[Pasted image 20260223144830.png]]

```python
import boto3

sqs = boto3.client('sqs')

response = sqs.send_message(
    QueueUrl='https://sqs.eu-west-1.amazonaws.com/123456789/moja-kolejka',
    MessageBody='{"user_id": 42, "action": "resize"}',
    DelaySeconds=0
)

print(response['MessageId'])
```

**Co się dzieje pod spodem:**
```
boto3 → HTTP POST → SQS endpoint → wiadomość w kolejce
```

boto3 sam podpisuje request, dobiera endpoint, obsługuje błędy.

**Najważniejsze parametry:**
- `MessageBody` — treść, max 256KB
- `DelaySeconds` — opóźnij dostarczenie (0-900 sek)
- `MessageGroupId` — tylko FIFO, grupuje wiadomości
- `MessageDeduplicationId` — tylko FIFO, zapobiega duplikatom

To tyle — jedna funkcja, wiadomość leci do kolejki.

**SDK** = Software Development Kit = biblioteka którą instalujesz w kodzie żeby gadać z AWS bez pisania HTTP requestów ręcznie.

![[Pasted image 20260223145209.png]]

• **FIFO Queue (First-In-First-Out):**
    ◦ Guarantees strict ordering and exactly-once send capability.
    ◦ Limited throughput: 300 msg/s without batching, 3000 msg/s with batching.

![[Pasted image 20260223152556.png]]

**Batching** = wysyłaj/odbieraj wiele wiadomości na raz zamiast jedna po jednej.

If the load is too big, some transactions may be lost
![[Pasted image 20260223153317.png]]
	**Enqueue** = wrzuć wiadomość do kolejki = `send_message`
	**Dequeue** = wyciągnij wiadomość z kolejki = `receive_message` + `delete_message`
	`Producer  →  enqueue  →  [A, B, C]  →  dequeue  →  Consumer`
	

• **Key Mechanisms:**
    ◦ **Visibility Timeout:** After being polled, a message becomes invisible to others for 30 seconds (default). If not deleted after processing, it becomes visible again.
    ◦ **Long Polling:** A consumer "waits" for messages to arrive (up to 20s), which decreases API calls and costs.
    ◦ **Auto Scaling:** You can scale an Auto Scaling Group (ASG) based on the `ApproximateNumberOfMessages` metric in CloudWatch

![[Pasted image 20260223145420.png]]

SQS to decouple between application tiers
![[Pasted image 20260223145444.png]]

# Szyfrowanie SQS SNS:
Krótko: IAM kontroluje kto, Queue Policy kontroluje co z zewnątrz, KMS szyfruje dane, VPC Endpoint izoluje sieć.

- w spoczynku (at rest): SSE (Server Side Encryption) — AWS KMS szyfruje wiadomości na dysku
- w tranzycie (in flight): HTTPS zawsze

---

**Kto może wysyłać/czytać — IAM:**

json

```json
{
  "Effect": "Allow",
  "Action": ["sqs:SendMessage", "sqs:ReceiveMessage", "sqs:DeleteMessage"],
  "Resource": "arn:aws:sqs:eu-west-1:123456789:moja-kolejka"
}
```

Dajesz tylko te uprawnienia które potrzebne — zasada least privilege.

---

**SQS Queue Access Policy** — kto z zewnątrz może pisać do kolejki (np. inny account AWS, SNS):

json

```json
{
  "Effect": "Allow",
  "Principal": {"Service": "sns.amazonaws.com"},
  "Action": "sqs:SendMessage",
  "Resource": "arn:aws:sqs:...:moja-kolejka"
}
```

>[!tip]
>**resource-based policy** przypięta do zasobu.
>>```
Queue Policy    → przyczepiasz do SQS kolejki
Bucket Policy   → przyczepiasz do S3 bucketa
Key Policy      → przyczepiasz do KMS klucza

---

**VPC Endpoint** — ruch między EC2 a SQS nie wychodzi do internetu, zostaje w sieci AWS.




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
