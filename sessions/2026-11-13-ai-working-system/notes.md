# AI Working System pravila u opencode

Datum: 2026-11-13

## Sta je uradjeno

- Preuzet paket `AI Working System` (CORE + 4 modula) sa catbox linka.
- U repo dodato:
  - `rules/ai-working-system/CORE.md` — osnovna pravila.
  - `rules/ai-working-system/modules/*.md` — CODING, RESEARCH, ANALYSIS-DECISIONS, AGENT-EXECUTION.
  - `rules/ai-working-system/README.md` — opis paketa.
  - `rules/ai-working-system/install.sh` — ponovna instalacija u globalni opencode config.
  - `.opencode/skills/aiws-*/SKILL.md` — moduli kao opencode skills.
- Globalno instalirano:
  - `~/.config/opencode/AGENTS.md` = CORE (vazi za sve modele i sve projekte).
  - `~/.config/opencode/skills/aiws-{coding,research,analysis,agent-execution}/SKILL.md`.

## Odluke

- CORE ide u globalni `AGENTS.md` jer se automatski ubacuje u kontekst za svaki model.
- Moduli su skills da se ucitavaju samo kada zadatak odgovara, bez stalnog suma u kontekstu.
- Skill ID-jevi: `aiws-coding`, `aiws-research`, `aiws-analysis`, `aiws-agent-execution`.
- Globalni config nije u git-u, pa `install.sh` sluzi za obnovu posle rebuild-a.

## Sledeci koraci

- Ponovo pokrenuti opencode da bi se ucitali novi globalni AGENTS.md i skills.
- Opciono: pozvati `rules/ai-working-system/install.sh` iz devcontainer `postCreateCommand`.
