# opencode web autostart u Codespace-u

Datum: 2026-11-12

## Cilj

Da se `opencode web --port 4096 --hostname 0.0.0.0` sam pokrene pri paljenju
Codespace-a, bez rucnog kucanja.

## Resenje (primenjeno)

Idempotentna skripta + dva okidaca:

1. `postStartCommand` u `.devcontainer/devcontainer.json` — pokrece se na svaki
   container start (i za buduce Codespace-ove).
2. Hook u `~/.bashrc` / `~/.zshrc` — pokrece se kad se otvori shell.

Skripta proverava da li port vec slusa; ako da, ne radi nista. Koristi `flock`
da spreci dupliranje kad se otvori vise terminala istovremeno.

### Fajlovi

- `.devcontainer/devcontainer.json` — image + `postStartCommand` + forward port 4096
- `.devcontainer/start-opencode-web.sh` — kanonska (verzionisana) launcher skripta
- `~/.local/bin/start-opencode-web.sh` — kopija za hook u ovom Codespace-u
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

- `bash -n .devcontainer/start-opencode-web.sh` — sintaksa OK
- `python3 -m json.tool .devcontainer/devcontainer.json` — JSON OK
- Test na portu 4097: server se podigao (log potvrdio `http://localhost:4097`)
- Ponovni poziv dok je 4096 zauzet: izlazi za ~0.3s, bez duplikata

## Vazno / ogranicenja

- `.devcontainer` se primenjuje tek posle **rebuild** container-a; za to je
  potreban rebuild iz Codespaces menija.
- U novim Codespace-ovima `opencode` binarni fajl mora biti instaliran
  (`~/.opencode/bin/opencode`); skripta se tiho preskace ako ga nema.
- Home prezivljava stop/start istog Codespace-a, ali ne i brisanje.

## Sledeci koraci (opciono)

- Rebuild container-a da se aktivira `postStartCommand`.
- Dotfiles repo za univerzalno podesavanje po korisniku.
