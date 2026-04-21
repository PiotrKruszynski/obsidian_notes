Created: 2026-04-21  23:31
___
Note:

[Karpathy‑style](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)



Kiedy dodajesz nowy dokument:

1. LLM czyta cały dokument.
2. Wyciąga kluczowe informacje.
3. Aktualizuje istniejące strony wiki.
4. Tworzy nowe strony, jeśli trzeba.
5. Dodaje linki między stronami.
6. Oznacza sprzeczności.
7. Uzupełnia syntezę.

**Wynik:** Masz _żywą, rosnącą bazę wiedzy_, która staje się coraz mądrzejsza.

# 🏛️ **3) Trzy warstwy architektury**

To jest klucz — LLM‑Wiki to **system trójwarstwowy**.

## **Warstwa 1: Raw Sources (źródła surowe)**

To Twoje dokumenty:

- PDFy
- artykuły
- notatki
- książki
- zrzuty ekranu
- dane

**Zasada:** LLM **nigdy ich nie zmienia**. To jest _źródło prawdy_.

## **Warstwa 2: Wiki (kompilacja wiedzy)**

To katalog Markdownów generowanych przez LLM:

- strony pojęć
- strony bytów (entity pages)
- strony tematów
- syntezy
- porównania
- mapy koncepcji
- timeline’y
- przeglądy literatury

**LLM jest jedynym autorem.** Ty tylko czytasz i dodajesz nowe źródła.

Wiki jest:

- spójne,
- interlinkowane,
- aktualizowane,
- rosnące,
- coraz bardziej inteligentne.

## **Warstwa 3: Schema (instrukcja dla LLM)**

To najważniejszy element.

Schema (np. `CLAUDE.md`, `AGENTS.md`) mówi LLM:

- jak wygląda struktura wiki,
- jakie są typy stron,
- jak aktualizować istniejące strony,
- jak tworzyć nowe,
- jak linkować,
- jak obsługiwać sprzeczności,
- jak odpowiadać na pytania,
- jak integrować nowe źródła.

**Schema = skill, który zamienia LLM w profesjonalnego wiki‑maintainera.**

# 🔥 **4) Co jest rewolucyjne w LLM‑Wiki?**

### **A. Wiedza jest kompilowana, nie wyszukiwana**

RAG = „szukaj i improwizuj”. LLM‑Wiki = „kompiluj i utrzymuj”.

___
Metadata:

```yaml
---
type: tool    # concept | tool | pattern
language: python # python | js | sql | etc.
---
```

Status: #pending
Tags: #empty
