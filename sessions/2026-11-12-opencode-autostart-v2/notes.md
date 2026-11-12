# opencode web autostart — v2 (ojacan)

Datum: 2026-11-12

## Cilj

`opencode web` da se sam pokrene pri svakom startu Codespace-a, bez rucnog
kucanja, i da to bude robustno (bez laznog "uspeha", bez duplikata, sa logom).

## Sta je uradjeno

### `.devcontainer/devcontainer.json`

- Zadrzan postojeci `image` (nije diran da se ne bi menjao environment).
- `postCreateCommand` -> `start-opencode-web.sh --install-only || true`
  (instalira opencode jednom pri kreiranju/rebuild-u).
- `postStartCommand` -> `start-opencode-web.sh || true`
  (pokrece server pri svakom startu/resume-u).
- `forwardPorts` i `portsAttributes` zadrzani.

### `.devcontainer/start-opencode-web.sh` (prepisana)

- `cd` u koren repozitorijuma pre pokretanja (servira pravi projekat).
- Provera porta (`ss`, fallback `/dev/tcp`) pre bilo cega.
- `flock` protiv paralelnog pokretanja; dvostruka provera porta pod lock-om.
- Instalacija opencode-a samo ako binarni fajl ne postoji.
- `OPENCODE_BIN` override (za testiranje bez pokretanja pravog servera).
- `setsid nohup ... </dev/null` — potpuno odvojen proces; stdin iz `/dev/null`
  da lifecycle komanda ne visi.
- Verifikacija: ceka do 10s da port pocne da slusa; ako proces umre, exit 1.
- Rotacija loga na 5 MB (`web.log` -> `web.log.1`).
- Konfiguracija preko env: `OPENCODE_WEB_PORT`, `OPENCODE_WEB_HOSTNAME`,
  `OPENCODE_WEB_LOG`, `OPENCODE_WEB_LOG_MAX_BYTES`.
- `--install-only` mod za `postCreateCommand`.

## Testovi (izvrseno)

- `bash -n .devcontainer/start-opencode-web.sh` — OK
- `jq . .devcontainer/devcontainer.json` — OK
- Dok je 4096 zauzet: skripta izlazi 0 odmah, bez duplikata.
- Fake server na 4097: pokrenut, port slusa, log prazan (nema greske).
- Drugi poziv na 4097: exit 0, bez drugog procesa.
- Fake binarni fajl koji odmah padne na 4098: exit 1 + poruka u logu.
- `--install-only` sa postojecim binarnim fajlom: exit 0.
- Realni server na 4096 ostao zdrav (`HTTP 200`) — nije diran.

## Vazno

- `.devcontainer` izmene se primenjuju tek posle **Rebuild Container**.
- Port na GitHub-u drzati **Private**. `--hostname 0.0.0.0` je samo da bi
  port-forwarding unutar kontejnera radio; "Public" bi izlozio agenta internetu.
- `image` tag `mcr.microsoft.com/vscode/devcontainers/universal:latest` je
  legacy; nije menjan da rebuild ne bi promenio okolinu. Ako se jednog dana
  radi cist rebuild, razmotriti `mcr.microsoft.com/devcontainers/universal:2`.
- Ako zelis i fallback za shell (npr. stariji Codespace bez rebuild-a), opciono
  dodati hook u `~/.bashrc` koji poziva skriptu; nije deo repozitorijuma.
- Log raste do 5 MB pa se rotira; stariji se cuva kao `web.log.1`.
