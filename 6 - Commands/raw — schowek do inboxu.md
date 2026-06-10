# `raw` — schowek z LLM prosto do inboxu

Funkcja zsh: kopiujesz odpowiedź LLM (Cmd+C), piszesz `raw nazwa-pliku [model]` → plik ląduje w `1 - Raw Notes/` z datą i źródłem. Potem mówisz agentowi „zrób ingest [plik]".

Instalacja — dopisz do `~/.zshrc` i odpal `source ~/.zshrc`:

```zsh
# LLM → inbox vaultu: raw nazwa-pliku [model]
raw() {
  local name="${1:?użycie: raw nazwa-pliku [model]}"
  local file="$HOME/obsidian_notes/1 - Raw Notes/${name%.md}.md"
  [[ -e "$file" ]] && { echo "❌ istnieje już: $file"; return 1; }
  { echo "źródło: sesja LLM, ${2:-model nieznany}, $(date +%F)"; echo; pbpaste; } > "$file"
  echo "✓ zapisano: $file"
}
```

Użycie:

```bash
raw gil-wnioski "GPT-5 Codex"   # → 1 - Raw Notes/gil-wnioski.md
raw async-pulapki                # bez modelu → "model nieznany"
```

Zachowanie: nie nadpisze istniejącego pliku (błąd zamiast utraty danych); `.md` w nazwie nie zdubluje rozszerzenia; pierwsza linia pliku to proweniencja (`źródło: sesja LLM, <model>, <data>`), którą ingest przepisze do frontmattera notatek.
