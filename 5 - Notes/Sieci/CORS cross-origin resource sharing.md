---
title: "CORS cross-origin resource sharing"
type: concept
topic: networking
tags: []
created: 2026-06-09
status: draft
---

Created: 2026-02-17  14:49
___
Note:

>[!tip]
>**CORS** is a web browser-based mechanism that allows a web application running at one origin to access resources from a different origin. To understand this, we must first define what an **Origin** is.

**Use case:** machenizm przeglądarki CORS  spotkasz w usługach, które udostępniają zasoby przez przeglądarkę np. S3. Pozwala określić które domeny mogą korzystać. 
 
An origin is the combination of three elements: **Scheme (protocol) + Host (domain) + Port**.

• **Example:** `https://www.example.com` (where HTTPS is the protocol, the domain is the host, and the implied port is 443).

• **Same Origin:** `http://example.com/app1` and `http://example.com/app2` are considered the same origin.

• **Different Origins:** `http://www.example.com` and `http://other.example.com` are different origins because their hostnames do not match.

![[Pasted image 20260217145120.png]]
# How it Works (Browser Security)

![[Pasted image 20260217145042.png]]

By default, web browsers block cross-origin requests for security reasons.

• If you are visiting `website-A.com` and it tries to request data from `website-B.com`, the request will fail unless `website-B.com` explicitly allows it.

• To allow these requests, the target server must return specific **CORS Headers**, such as `Access-Control-Allow-Origin`.

• **Preflight Requests:** For certain types of requests, the browser sends an "OPTIONS" request first to check if the cross-origin request is permitted before sending the actual data.

**3. Amazon S3 – CORS Configuration**

Configuring CORS is a common requirement when using S3 for static website hosting.

• **The Problem:** If a user visits a website hosted in one S3 bucket (e.g., `my-bucket-html`) and that page tries to load an image or script from a different S3 bucket (e.g., `my-bucket-assets`), the browser will block the asset from loading.

• **The Solution:** You must enable the correct CORS headers on the **target** S3 bucket (the one containing the assets) to allow the requesting origin.

• **Flexibility:** You can choose to allow a specific origin (e.g., `http://my-bucket-html.s3-website.amazonaws.com`) or use a wildcard (`*`) to allow all origins.

• **Exam Tip:** Configuring S3 CORS is a very popular question on the Solutions Architect exam.

--------------------------------------------------------------------------------


• **CORS** to "strażnik" w Twojej przeglądarce, który dba o to, by skrypty z jednej strony nie kradły danych z innej bez pozwolenia.

• **Origin** (Źródło) musi być identyczne pod kątem protokołu, domeny i portu. Jeśli choć jeden z tych elementów się różni, mamy do czynienia z "Cross-Origin".

• W **Amazon S3** najczęściej spotkasz się z tym problemem, gdy trzymasz pliki HTML w jednym koszyku (Bucket), a obrazki lub czcionki w drugim. Bez ustawienia polityki CORS w tym drugim koszyku, Twoja strona nie wyświetli tych plików.






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
