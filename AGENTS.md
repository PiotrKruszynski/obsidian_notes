# AGENTS.md — vault constitution (LLM Wiki)

This vault is an LLM Wiki in three layers (Karpathy's pattern):

1. **Immutable sources** — `2 - Source Materials/` (agent only reads)
2. **Wiki maintained by the agent** — `5 - Notes/` (atomic notes, continuously updated)
3. **Schema** — this file (conventions, operations, rules)

Agent's role: not just create new notes, but **continuously maintain existing ones** — update them, catch contradictions, detect gaps and duplicates, fix cross-references. The wiki should age toward consistency, not entropy.

Vault language: **Polish** (technical terms in English).

## Vault structure

| Folder                  | Role                                                                                                                                 |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| `1 - Raw Notes/`        | **Inbox** — loose takeaways from study sessions, clutter waiting to be sorted by `ingest`. Can be cleaned up after processing.       |
| `2 - Source Materials/` | **Raw / immutable sources** — PDFs, articles, transcripts, dumps. READ-ONLY: the agent does not edit, delete, or move these.         |
| `3 - Indexes/`          | Cross-cutting indexes / MOCs.                                                                                                        |
| `4 - Templates/`        | Note templates (Concept Note, AWS Service, MOC...).                                                                                  |
| `5 - Notes/`            | **The wiki proper** — atomic notes organized in module folders.                                                                      |
| `6 - Commands/`         | Command cheatsheets.                                                                                                                 |
| `7 - Assets/`           | Attachments, images.                                                                                                                 |
| `8 - Daily/`            | Daily notes.                                                                                                                         |
| `9 - Prompt template/`  | Prompt templates.                                                                                                                    |

Inside `5 - Notes/`, module folders: `Python/`, `AWS/`, `Bazy-Danych/`, `Sieci/`, `Testy/`, `C/`, `Docker/`, `AI-ML/`, `Algorytmy/`, `FastAPI-vault/`, `Projekty/` (per project, e.g. `Projekty/fastapi-rekrutacja/`).

### Concepts — a concept exists exactly once

`Koncepcje/` folders live **per module** (e.g. `Python/Koncepcje/`, `Bazy-Danych/Koncepcje/`). Convention:

- A concept exists in **one place** across the entire vault and is reused via linking.
- Before creating a new concept note, the agent MUST search **all** `Koncepcje/` folders (and all of `5 - Notes/`) for an existing note on that concept. If it exists — link `[[...]]`, don't duplicate. If it exists but is incomplete — propose an update (diff).
- A general concept (e.g. GIL, ACID) goes into the `Koncepcje/` folder of its topic module; a project-specific note goes into the project's folder, with links to the general concepts.
- **Filenames are unique across the whole vault** (Obsidian wikilinks resolve by filename).

## Atomicity rules (style: short notes for spaced repetition)

Goal of a note: to be re-readable in ~30 seconds during a daily review.
A note that can't be read that way won't be read at all. Depth lives in the link graph, not in a single file.

- **One note = one idea.** The title names that single idea. If the title needs "and" to join two concepts — that's two notes.
- **Bullets, not paragraphs.** Each point is one line: term + elaboration after a dash, only when the term alone isn't enough. Zero lecture-style prose.
- **~15-line content limit.** Runs longer → split into two notes and link them.
- **Depth through links.** Something needs a longer explanation → a separate `[[...]]` note, not another paragraph.
- **Big topic → hub + atoms.** A topic covering many concepts (e.g. AWS IAM) gets a short hub (2–3 bullet definition + TL;DR + Connections) plus separate atomic notes for sub-concepts; pitfalls/exam traps go as `[!warning]` in the note they apply to.
- **Self-contained note**: understandable without reading others. Context comes from links, not reading order.
- **Dense linking** `[[wikilinks]]` in the body, wherever a related concept comes up.
- **Every note ends with a `## Połączenia` ("Connections") section** — a list of links, each with a half-sentence explaining why the concepts are related. A bare link with no explanation doesn't count.

## Frontmatter and provenance

Every note gets frontmatter per the vault's existing convention plus a `źródło` ("source") field:

```yaml
---
title: "Note name"
type: concept        # concept | service | moc | project | question
topic: python        # topic module
tags: ["python"]
created: 2026-06-10
status: draft        # draft | done
źródło: "2 - Source Materials/file-name.pdf"
---
```

The `źródło` field is **mandatory** — it says where the claim comes from, so it can be verified later. Possible values:

- `"2 - Source Materials/file.pdf"` — note from ingesting a source (path to the file!)
- `"1 - Raw Notes/file.md"` — note from ingesting the inbox
- `"sesja LLM, <model>"` ("LLM session, <model>") — knowledge from a conversation with an LLM, e.g. `"sesja LLM, GPT-5 Codex"`, `"sesja LLM, Claude Fable 5"` (always name the model!)
- `"dokumentacja python.org"` ("python.org docs"), `"wykład 42"` ("lecture 42"), etc.

This matters: some knowledge comes from LLM conversations, which can be wrong. Without provenance you can't tell a claim from documentation apart from a hallucination.

Don't guess provenance retroactively. When filling in old notes whose true source is unknown, use the value `"nieznane (sprzed LLM Wiki)"` ("unknown (predates LLM Wiki)") instead of assigning them a false source. False provenance is worse than none.

If the agent appends new content to an old note on its own initiative (e.g. new bullets, callouts, a `## Połączenia` section, cross-link fixes), that new content also has provenance. Add or fill in the field:

```yaml
źródło_uzupełnień: ["sesja LLM, GPT-5 Codex, 2026-06-10"]
```

Don't mix this up with the original `źródło`: `źródło` describes where the note's core content came from, while `źródło_uzupełnień` ("source of additions") describes the agent's later additions.

## Spaced repetition (SM-2) — sr_* fields

The vault has an SM-2-based review system: script `sr.py` in the root (session: `python3 sr.py`,
report: `python3 sr.py stats`), grade history in `.sr_log.csv`.

- The fields `sr_due / sr_last / sr_grade / sr_interval / sr_ease / sr_reps / sr_lapses`
  are managed **exclusively by the script** — when editing a note, leave them
  unchanged (don't rewrite, delete, or "fix" the dates).
- A new concept note gets initialized with: `sr_due:` creation date,
  `sr_interval: 0`, `sr_ease: 2.5`, `sr_reps: 0`, `sr_lapses: 0` — this puts it
  straight into the review queue.
- MOCs (`type: moc`) and files named `00 — ...` are not subject to review.

## Obsidian callouts — optional, max 2 lines

- `> [!warning]` — **a real pitfall with a concrete consequence** ("if you do X, Y happens"), not a generic "be careful."
- `> [!tip]` — a memory trick, association, mnemonic.
- `> [!example]` — a mini-example (1–2 lines).

No `> [!summary]` — a short note is its own summary. A callout that
needs a paragraph of explanation is material for a separate note.

## What to avoid

- **"Catalog" notes**: a wall of code/commands instead of an explanation. Code illustrates the idea, it doesn't replace it.
- **Prose paragraphs and "lectures"** — a note is bullets.
- **Notes over the limit** — cut into atoms instead of sprawling.
- **Callouts longer than 2 lines.**
- **Duplicating concepts** across modules instead of linking to a single note.
- **Titles joining two ideas** ("X and Y") — split into two notes.
- **Skipping the `## Połączenia` section** or links without an explanation of the relationship.

## Operations (invoked by keyword)

### `ingest [file]`

Read the indicated source from `2 - Source Materials/` or a file from `1 - Raw Notes/`, then:

1. Break the content down into **atomic notes** per the rules above.
2. For each concept, check whether it **already exists** anywhere in `5 - Notes/` (all `Koncepcje/` folders and modules). If so — link it, don't duplicate; if it needs updating — propose a change.
3. **Update related existing notes** (add links, correct content, add to `## Połączenia`).
4. Fix cross-references in both directions.
5. In the frontmatter of every new note: `źródło` with the path to the source file.
6. At the end, show a **diff for approval** (new files + every change to existing ones). Save only after approval.

Files in `2 - Source Materials/` must not be modified. A file from `1 - Raw Notes/` can be marked/deleted after an approved ingest — only with consent.

### `lint`

Go through the whole vault (`5 - Notes/` + indexes) and produce a report of:

- **dead wikilinks** — `[[links]]` to nonexistent files,
- **orphan notes** — with no incoming links,
- **duplicated concepts** across modules (the same concept in two places),
- **contradictions** between notes (mutually exclusive claims — cite both locations and quotes),
- **gaps** — frequently linked concepts that have no note,
- **notes over the limit** (~15 lines of content) or with prose paragraphs — candidates
  for splitting into atoms: report with a proposed split, cut only after approval,
- additionally: missing frontmatter / missing `źródło` field / missing `## Połączenia`.

The wikilink resolver MUST behave like Obsidian, not like a simple `.md` scanner:

- check the whole vault, not just `.md` notes;
- include `7 - Assets/` and other attachments;
- recognize basename with extension (`![[image.png]]`), basename without extension (`[[Note]]`), relative paths and paths from the vault root;
- a link to an existing asset is not a conceptual gap.

Before flagging a dead wikilink as a gap, do a mapping pass:

1. `dead link → existing similar note/asset`;
2. mark the result as `to relink` if a close note exists (e.g. `[[Typy baz danych]]` → `[[types of databases]]`, `[[Indeks — koszt i korzyść]]` → a close note about indexes);
3. only report links with no reasonable existing target as **gaps**.

Don't create a new note just because a wikilink is dead. A dead link often signals a rename, a title language change, or an inconsistent alias — fix it via relinking first.

**Report only — change nothing without explicit consent.** After the report, propose an order of fixes.

### `nowa notatka [concept]` ("new note")

A single concept/task note following the same rules: duplicate check → atomicity → frontmatter with `źródło` → callouts → `## Połączenia` → update related notes → diff for approval.

### `znajdź [question]` ("find")

Searching for knowledge in the vault — a **read-only** operation:

1. Search for the answer **only in the vault's notes** (`5 - Notes/`, indexes, possibly `2 - Source Materials/`) — do NOT answer from the model's own knowledge.
2. Always give **file paths** + one sentence on what's in each.
3. Synthesizing across multiple notes is fine, but only from their content and with a list of source files.
4. If the vault doesn't have the answer — say so plainly: **"no note — that's a gap"** and propose `nowa notatka [concept]`. Don't paper over the gap with your own knowledge.
5. If your own knowledge contradicts a note's content — don't silently correct it; flag it as a potential contradiction to verify (with the note's provenance).

### `odpowiedz [question]` ("answer")

A substantive answer to a question, sourced from the vault (not the model's knowledge) — a **read-only** operation:

1. Answer the question concisely, but build the answer **only from the notes' content** (`5 - Notes/`, possibly `2 - Source Materials/`). Synthesizing across multiple notes is desirable.
2. Don't add model knowledge from outside the notes. If the notes cover the topic only partially — answer with what's there, and say plainly what's missing from the vault.
3. End the answer with a **Sources:** section listing the paths of notes used.
4. If the vault doesn't cover the topic at all — don't answer off the top of your head: flag the gap and propose `nowa notatka [concept]`.
5. When your own knowledge contradicts a note's content — answer per the note, but explicitly flag the potential contradiction for verification.

Difference from `znajdź`: `znajdź` says WHERE the knowledge lives, `odpowiedz` says WHAT follows from it. The former is for navigation, the latter for review and checking your own understanding.

### `ćwicz [topic]` ("practice")

Practice that feeds the wiki (doesn't live alongside it):

1. Build exercises **around concepts that already exist in the vault** and link them in the exercise text (`[[...]]`). A concept needed for the exercises but without a note → flag as a gap, don't smuggle it in silently.
2. Grade difficulty ★–★★★★. Exercises on a real database (SQL: Sakila — setup and series in `5 - Notes/Bazy-Danych/Cwiczenia-Sakila/`).
3. **Don't show the solution before the user shows their own attempt.** Then assess: correctness of the result, pitfalls (NULLs, duplicates, missing JOINs), readability, performance (EXPLAIN, when relevant).
4. After the session, propose closing the loop: user's mistake → `[!warning]` with a concrete consequence added to the concept note; a surprise/trick → `[!tip]`; solutions and takeaways → a "My solutions and takeaways" section in the exercise series note. Everything as a diff for approval.
5. A new exercise series = a new note following the pattern of existing series (frontmatter, `źródło`, exercises with links, takeaways section, `## Połączenia`).

## Safety rules (always)

- Changes to **existing** notes: diff first, save after approval.
- Never delete or overwrite anything without asking. `2 - Source Materials/` is untouchable.
- Don't change file permissions, don't do irreversible operations.
- Commit after meaningful stages of work (git is a safety net — the vault has auto-backups via the Obsidian Git plugin; don't overwrite its config).
