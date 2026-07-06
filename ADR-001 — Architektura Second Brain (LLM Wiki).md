# ADR-001: Second Brain (LLM Wiki) System Architecture

**Status:** Accepted
**Date:** 2026-07-06
**Deciders:** Piotr (vault owner), colleagues adopting the pattern for their own use

## Context

We need a personal system for learning and maintaining technical knowledge (Python, AWS, databases, networking, C, AI/ML, projects) that:

- lets you **capture knowledge fast** (from an LLM, from articles, from study sessions) without manual formatting every time,
- **maintains itself** — an AI agent is responsible for atomicity, cross-links, duplicates, and contradictions, not just appending new notes,
- supports **daily spaced repetition**, so knowledge actually sticks instead of just sitting in files,
- is **portable with no vendor lock-in** — it should still work in a year, regardless of which AI/SaaS provider happens to be winning at the time,
- can be **copied and handed to a colleague** as a ready-made pattern, not a one-off setup.

Constraints: single user, no budget for a dedicated team tool, wants to use any coding agent interchangeably (Codex, Claude Code, Copilot).

## Decision

Build the system as **plain Markdown files (an Obsidian vault) + an AI agent driven by a constitution file (`AGENTS.md`) + a lightweight custom Python SM-2 script for reviews**, the whole thing version-controlled in git.

Layers:

1. `2 - Source Materials/` — immutable sources (PDFs, articles, transcripts), read-only.
2. `1 - Raw Notes/` — inbox for loose takeaways, cleaned up after processing.
3. `5 - Notes/` — the wiki itself: atomic notes (~15 lines, one idea, `## Połączenia`/"Connections"), organized in topic-module folders.
4. `AGENTS.md` — an explicit specification of conventions and operations (`ingest`, `lint`, `nowa notatka`/"new note", `znajdź`/"find", `odpowiedz`/"answer", `ćwicz`/"practice"), loaded by any coding agent.
5. `sr.py` + `sr_*` frontmatter — spaced repetition (SM-2) embedded directly in the notes, with no external tool.

## Options Considered

### Option A: Markdown vault (Obsidian) + agent + custom SM-2 — **chosen**

| Dimension | Assessment |
|---|---|
| Complexity | Low–medium (files + one Python script) |
| Cost | Zero (Obsidian core is free, AI agent already paid for) |
| Portability / data ownership | Very high — plain `.md` files, git as backup |
| AI agent integration | Very high — `AGENTS.md` is read by any coding agent |
| Spaced repetition | Custom implementation, tailored 1:1 to the notes |
| Sharing the pattern | Trivial — just copy the skeleton folder (done: `second-brain-starter-kit.zip`) |

**Pros:** no lock-in, full control over convention, the agent can maintain consistency (lint, dedup), works offline, easy to clone for other people.
**Cons:** no polished mobile app, the whole workflow has to be self-maintained (conventions, script), requires discipline (ingest/lint actually have to be run).

### Option B: AI-native SaaS (Notion AI, Mem, Reflect)

| Dimension | Assessment |
|---|---|
| Complexity | Low (ready-made UI) |
| Cost | Monthly subscription |
| Portability | Low–medium — export possible, but format and metadata are provider-owned |
| AI agent integration | Limited to the vendor's built-in AI, no `AGENTS.md`-style openness |
| Spaced repetition | Usually no native SM-2 |

**Pros:** nice onboarding, mobile-first, zero setup.
**Cons:** vendor lock-in, no control over note conventions, harder to plug in any coding agent (Codex/Claude Code), no spaced repetition.

### Option C: Roam Research / Logseq (native graph) + LLM bolted on

| Dimension | Assessment |
|---|---|
| Complexity | Medium |
| Cost | Roam: subscription; Logseq: free |
| Portability | Logseq — local files (good); Roam — worse |
| AI agent integration | No native pattern for "an agent maintains the wiki per written rules" |
| Spaced repetition | Plugins exist, but not agent-driven |

**Pros:** bidirectional linking built in from day one, strong culture of atomic notes (similar to our rules).
**Cons:** no formal channel for driving an AI agent (an `AGENTS.md` equivalent), extra learning curve (outliner instead of plain markdown).

### Option D: Anki (standalone) + a separate wiki, no agent

| Dimension | Assessment |
|---|---|
| Complexity | Low |
| Cost | Zero |
| Portability | High |
| AI agent integration | None — Anki is a separate, siloed system |
| Spaced repetition | Very mature (best in class) |

**Pros:** SM-2 refined over years, huge community.
**Cons:** Anki cards and wiki notes live separately — double the work (write the note + write the card separately), the agent has no single place to maintain everything.

## Trade-off Analysis

The key trade-off: **maturity of a ready-made tool (B, D) vs. control and agent integration (A)**. Since the goal is a system an **AI agent actively maintains** (not just a convenient frontend for reading), what matters most is having an explicit, machine-readable contract (`AGENTS.md`). None of the ready-made tools (B, C, D) offer this directly — you'd have to work around it (export → process → import), which destroys the main advantage (the agent maintains the wiki continuously, in place).
The price of this decision: no polished mobile UI, and a self-maintained SM-2 script instead of mature Anki.

## Consequences

- Becomes easier: adding knowledge from any LLM (the `raw` function + `ingest`), maintaining consistency (`lint`), moving the whole system to another person (copying the skeleton folder).
- Becomes harder: no convenient mobile app for reading on the go (have to rely on the Obsidian app), spaced repetition requires a terminal (`python3 sr.py`), not a web dashboard.
- To revisit later: whether `sr.py` needs a UI (today purely terminal-based), whether an automatic `lint` is worth scheduling as a recurring task, whether the module structure in `5 - Notes/` scales past 1000+ notes.

## Action Items

1. [x] Write `AGENTS.md` with atomicity conventions, frontmatter, and operations (`ingest`, `lint`, `nowa notatka`, `znajdź`, `odpowiedz`, `ćwicz`).
2. [x] Implement `sr.py` (SM-2) embedded in note frontmatter.
3. [x] Prepare `second-brain-starter-kit.zip` — the skeleton to hand to colleagues.
4. [ ] Each colleague: adapt the `topic`/modules in `AGENTS.md` to their own knowledge domain.
5. [ ] Set a `lint` cadence (e.g. weekly) — see `execution_plan.md`.
