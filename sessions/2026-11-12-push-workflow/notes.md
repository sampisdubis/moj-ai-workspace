# Push workflow — uvek pitaj pre push-a

Datum: 2026-11-12

## Cilj

Da se sve sto se uradi u opencode-u moze sacuvati na
`https://github.com/sampisdubis/moj-ai-workspace`, ali **samo uz odobrenje**.
Agent treba da na kraju zadatka ponudi commit + push, a push nikad ne sme da
protekne bez pitanja.

## Sta je uradjeno

### `opencode.json` (novo)

Dodat V1 permission (ovaj build je opencode V1; `permissions`/`shell` iz V2 je
odbijen pri validaciji):

- `*git push*` -> `ask`
- `*git push --force*` -> `deny`
- `*git push -f*` -> `deny`

Time je push tvrdo zaustavljen na approval promptu, cak i ako agent zaboravi
da pita. Force push je uvek zabranjen.

### `AGENTS.md`

Dodat „Push na GitHub (podrazumevani workflow)“: na kraju svakog zadatka, ako
ima izmena, agent azurira `sessions/<sesija>/notes.md`, pokrene lint/test ako
postoje, pokaze `git status`/`git diff --stat`, pa preko `question` alata pita:
„Commit + push“ / „Samo commit“ / „Ne diraj“. Tek posle odobrenja stage-uje
samo namenske fajlove i pushuje na `origin` (nikad `--force`).

Eksplicitno „sacuvaj“ ili „push“ ostaje odobrenje bez ponovnog pitanja.

### `.gitignore` (novo)

Sprecava da se slucajno commit-uju tajne (`.env`, kljucevi, `.npmrc`) i lokalni
artefakti (`node_modules/`, logovi).

## Vazno / ogranicenja

- Promene `opencode.json` i `AGENTS.md` vaze tek posle **restarta opencode-a**
  (config se ucitava jednom pri startu).
- Agent i dalje moze da zaboravi da ponudi push; zato je tu permission `ask`
  kao tvrda brana, ali ona reaguje samo ako se push zaista pokusa.
- Chat istorija se ne commituje automatski — u repo idu fajlovi i `notes.md`.
- Ne pushovati tajne; `.gitignore` je samo pomoc, `git add` mora biti namenski.
- Push ide na trenutnu granu (`main`); force push je zabranjen.

## Testovi

- `jq . opencode.json` — OK.
- `opencode debug config` — config se parsira bez greske (V1 `permission`).
- V2 `permissions` oblik je odbijen: „V2 permissions are not supported by
  OpenCode V1“ — zato je zadrzan V1 oblik.
