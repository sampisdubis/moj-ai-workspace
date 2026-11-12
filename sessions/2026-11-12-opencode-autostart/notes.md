# opencode web autostart u Codespace-u

Datum: 2026-11-12

## Cilj

Da se `opencode web --port 4096 --hostname 0.0.0.0` sam pokrene pri paljenju
Codespace-a, bez rucnog kucanja.

## Resenje (primenjeno)

Idempotentna skripta + hook u shell profilima. Skripta proverava da li port
vec slusa; ako da, ne radi nista. Koristi `flock` da spreci dupliranje kad se
otvori vise terminala istovremeno.

### Fajlovi

- `~/.local/bin/start-opencode-web.sh` — launcher (kopija u ovom folderu)
- `~/.bashrc` — poziva launcher na startu interaktivnog shell-a
- `~/.zshrc` — isto za zsh

Hook (identican u oba profila):

```bash
if [ -n "${CODESPACES:-}" ] && [ -x "$HOME/.local/bin/start-opencode-web.sh" ]; then
    "$HOME/.local/bin/start-opencode-web.sh" >/dev/null 2>&1 || true
fi
```

Skripta:

- port: `OPENCODE_WEB_PORT` (default 4096)
- log: `OPENCODE_WEB_LOG` (default `~/.opencode/web.log`)
- `--hostname 0.0.0.0` da bi port-forwarding radio

## Provera

- `bash -n ~/.local/bin/start-opencode-web.sh` — sintaksa OK
- Test na portu 4097: server se podigao (log potvrdio `http://localhost:4097`)
- Ponovni poziv dok je 4096 zauzet: izlazi za ~0.3s, bez duplikata

## Vazno / ogranicenja

- Hook se pokrece kad se otvori shell (Codespace obicno otvori/obnovi terminal).
- `~` (home) prezivljava stop/start istog Codespace-a, ali ne i brisanje.
- Za garanciju na svaki container start i za sve buduce Codespace-ove:
  `.devcontainer/devcontainer.json` sa `postStartCommand`. Zahteva rebuild
  container-a, pa nije automatski primenjeno (rizik promene image-a).

## Sledeci koraci (opciono)

- Dodati `.devcontainer/devcontainer.json` (image
  `mcr.microsoft.com/vscode/devcontainers/universal:latest`, `postStartCommand`)
  i rebuild.
- Ili dotfiles repo za univerzalno podesavanje po korisniku.
