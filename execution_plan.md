# Execution Plan — Second Brain (LLM Wiki) System Rollout

Rollout plan for the pattern described in `ADR-001 — Architektura Second Brain (LLM Wiki).md` ("ADR-001 — Second Brain Architecture (LLM Wiki)"). Use it both when rebuilding your own vault from scratch and when handing it to a colleague (base: `second-brain-starter-kit.zip`).

**Every change to this plan must be logged in the `## Change log` section at the bottom, with a UTC timestamp.** This includes edits to phases, checklist items, cadence, or risks — not just the initial authoring. See that section for the required format.

## Phase 0 — Assumptions (before starting)

- [ ] Editor chosen: Obsidian (free, local `.md` files).
- [ ] Coding agent chosen: Claude Code / Codex / Copilot — any of them, as long as it reads `AGENTS.md` from the folder root.
- [ ] Git installed locally + the **Obsidian Git** plugin (auto-backup, history, ability to revert changes).
- [ ] Knowledge domain the wiki should cover (e.g. Python/AWS/databases — as with Piotr's, or an entirely different domain).

## Phase 1 — Vault skeleton (15–30 min)

1. [ ] Unpack `second-brain-starter-kit.zip` into a new folder.
2. [ ] Open the folder as a vault in Obsidian.
3. [ ] Initialize a git repo in the folder (`git init`), first commit of the skeleton.
4. [ ] Install and enable the **Obsidian Git** plugin (auto-backup).
5. [ ] Verify the folder structure matches: `1 - Raw Notes/`, `2 - Source Materials/`, `3 - Indexes/`, `4 - Templates/`, `5 - Notes/`, `6 - Commands/`, `7 - Assets/`, `8 - Daily/`, `9 - Prompt template/`.

## Phase 2 — Adapting the constitution (`AGENTS.md`) (30–60 min)

1. [ ] Update the list of modules under `5 - Notes/` to your own domain (the "Vault structure" section in `AGENTS.md`).
2. [ ] Decide on the vault's language (Polish / English / other) — update the relevant line in `AGENTS.md`.
3. [ ] Review the atomicity limit (~15 lines) and adjust it to your own reading preferences if needed.
4. [ ] Leave unchanged: the provenance rules (`źródło`/"source", `źródło_uzupełnień`/"source of additions") and the `sr_*` fields — this is the scaffolding that `sr.py` relies on.
5. [ ] Launch the agent in the vault folder and confirm it loads `AGENTS.md` automatically (e.g. ask the agent "which operations do you know from AGENTS.md?").

## Phase 3 — Note templates (15 min)

1. [ ] Review `4 - Templates/` — adapt the `topic`/`tags` fields in each template to your own modules.
2. [ ] Check in Obsidian: Settings → Templates → `4 - Templates` folder (already configured in `.obsidian/templates.json`).
3. [ ] Optionally add your own templates (e.g. "Meeting Note", "Book Note") following the same frontmatter pattern.

## Phase 4 — Knowledge intake (30 min)

1. [ ] Install the `raw` function from `6 - Commands/raw — schowek do inboxu.md` ("raw — clipboard to inbox") into `~/.zshrc`.
2. [ ] Test: copy any LLM response, run `raw test-note model-name`, verify the file lands in `1 - Raw Notes/`.
3. [ ] Drop your first real source material (PDF/article) into `2 - Source Materials/`.
4. [ ] Ask the agent: **"ingest [file]"** — verify it shows a diff before saving, that new notes have frontmatter with `źródło`, and that they end with `## Połączenia`.

## Phase 5 — Spaced repetition (15 min)

1. [ ] Verify `sr.py` is in the vault root and executable (`python3 sr.py --help`).
2. [ ] After the first ingest: `python3 sr.py add` — enroll new notes into the review queue.
3. [ ] Run the first session: `python3 sr.py` — verify it opens notes in Obsidian and writes the `sr_*` fields.
4. [ ] Set your own cadence: daily morning/evening, `python3 sr.py stats` once a week to check backlog.

## Phase 6 — Maintenance cadence (ongoing)

| Frequency | Action |
|---|---|
| Daily | `raw` → capture loose takeaways; `python3 sr.py` — review session |
| After every study session | `ingest [file]` — break the material into atomic notes |
| Weekly | "lint the vault" — review dead links, orphans, duplicates, contradictions |
| Weekly | `python3 sr.py stats` — check review effectiveness |
| Before an exam/interview | `python3 sr.py [module] --all` — review a whole module regardless of due dates |
| Ad hoc | "find [question]" / "answer [question]" — search and synthesis sourced only from notes |

## Phase 7 — Rollout verification (final checklist)

- [ ] The agent correctly refuses to save without showing a diff first (safety).
- [ ] The agent doesn't modify anything under `2 - Source Materials/`.
- [ ] A new note has the full set: frontmatter (`title`, `type`, `topic`, `tags`, `created`, `status`, `źródło`), `## Połączenia`, ~15-line limit.
- [ ] `sr.py` correctly writes the `sr_*` fields after grading and logs to `.sr_log.csv`.
- [ ] The first `lint` has been run, the report reviewed, and fix decisions made deliberately (not automatically).
- [ ] Git history reflects the successive stages (skeleton → first ingest → first lint).

## Risks and mitigations

- **Lack of discipline running `ingest`/`lint`** → material piles up in `1 - Raw Notes/`. Mitigation: stick to the Phase 6 cadence, optionally a `schedule`d task for a weekly `lint` reminder.
- **The agent changes something without approval** → fall back to `git log` and revert the commit; this is why the Obsidian Git backup is mandatory from Phase 1.
- **Notes grow past the limit (~15 lines)** → `lint` flags candidates for splitting; don't split without reviewing the report first.
- **False provenance when filling in old notes** → always use `"nieznane (sprzed LLM Wiki)"` ("unknown (predates LLM Wiki)") instead of guessing (see `AGENTS.md`).

## Change log

Every edit to this plan — new phases, changed cadence, updated risks, anything — gets a row here with a UTC timestamp, the agent (or person) making the change, and a one-line description. Never overwrite or delete prior rows; append only.

| Timestamp UTC | Agent | Change |
|---|---|---|
| 2026-07-06 10:29Z | Claude (Cowork) | Translated execution plan to English from the Polish source and added this mandatory timestamped change log requirement. |
