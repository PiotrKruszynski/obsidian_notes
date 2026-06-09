---
title: "MIT2 RRN Transformers"
type: concept
topic: ai-ml
tags: ["ai"]
created: 2026-06-09
status: draft
---

MIT pokazuje podstawowy schemat:

$ht=tanh⁡(Whht−1+Wxxt+b)$
$y^t=Wyht+by$

Czyli:
- bierzesz poprzedni stan
- bierzesz nowe wejście
- łączysz je
- tworzysz nowy stan
To tworzy „łańcuch” w czasie.
![[Pasted image 20260417145344.png]]

neuron
![[Pasted image 20260417145400.png]]

![[Pasted image 20260417145503.png]]

![[Pasted image 20260417145521.png]]

![[Pasted image 20260417145649.png]]

![[Pasted image 20260415215412.png]]

![[Pasted image 20260417145631.png]]

> **Gradient mówi sieci neuronowej, w którą stronę i jak mocno powinna zmienić swoje wagi, żeby zmniejszyć błąd.**

![[Pasted image 20260417133151.png]]

![[Pasted image 20260417133506.png]]

![[Pasted image 20260417145751.png]]

![[Pasted image 20260417140702.png]]

> **Transformer nie potrzebuje pamięci jak LSTM.** **Zamiast tego każde słowo patrzy na wszystkie inne naraz.**

![[Pasted image 20260417145829.png]]

encoding position information
![[Pasted image 20260417150328.png]]
extract query, key, value for search
![[Pasted image 20260417150403.png]]
compute attention weighting
![[Pasted image 20260417150449.png]]
![[Pasted image 20260417151459.png]]
extract features with high attention
![[Pasted image 20260417151524.png]]

![[Pasted image 20260417151931.png]]
attention head -> Pojedynczy blok self-attention operujący na Q, K, V.
![[Pasted image 20260417151955.png]]
ten pipeline (Q, K, V → attention → weighted sum) to **jeden moduł zwany _self-attention head_**, który jest **budulcem większej sieci (Transformera)**.
![[Pasted image 20260417152609.png]]

![[Pasted image 20260417152900.png]]
