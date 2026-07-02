---
title: "event loop"
type: concept
topic: python
tags: ["python", "async"]
created: 2026-06-10
status: draft
źródło: "sesja LLM, GPT-5 Codex, 2026-06-10"
sr_due: 2026-07-05
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

# event loop

> [!summary]
> Event loop to pętla, która uruchamia zadania asynchroniczne, oddaje sterowanie podczas `await` i wraca do zadania, gdy oczekiwane I/O jest gotowe.

Model mentalny: event loop jest dyspozytorem. Nie robi wszystkiego naraz; szybko przełącza uwagę między zadaniami, gdy jedne czekają na sieć, dysk albo timer.

```python
import asyncio

async def main():
    print("start")
    await asyncio.sleep(1)
    print("koniec")

asyncio.run(main())
```

`await` mówi: "tu czekam, możesz w tym czasie obsłużyć inne zadania". Dzięki temu jeden wątek może obsługiwać wiele operacji I/O bez blokowania całego programu.

> [!warning]
> Event loop nie chroni przed blokującym kodem. Jeśli w `async def` wywołasz `time.sleep()` albo `requests.get()`, blokujesz pętlę i inne zadania nie dostają czasu.

## Połączenia
- [[async]] — słowa `async` i `await` są składnią pracy z pętlą zdarzeń.
- [[async def vs def w FastAPI]] — FastAPI używa event loop dla endpointów `async def`.
- [[stack|call stack]] — event loop wznawia funkcję w miejscu, w którym oddała sterowanie przez `await`.
- [[queue]] — gotowe do wznowienia zadania można rozumieć jak kolejkę pracy dla pętli.
