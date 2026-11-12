# moj-ai-workspace — uputstvo za AI agente

Ovaj repozitorijum je trajno skladiste za rad AI sesija.

## Gde cuvati

Sve sto napravis (kod, skripte, beleske, izvestaje, generisane fajlove) cuvaj
unutar ovog repozitorijuma, u folderu `sessions/`.

Za svaku sesiju napravi podfolder:

    sessions/YYYY-MM-DD-kratak-naziv/

U njemu:

- `notes.md` — sta je uradjeno, odluke, sledeci koraci
- sve ostale fajlove koje sesija proizvede

## Pravila

- Ne upisuj tajne (.env, tokene, kljuceve, privatne kljuceve) u repozitorijum.
- Na kraju sesije azuriraj `notes.md`.
- Kada korisnik kaze "sacuvaj" ili "push", to je odobrenje: commituj i pushuj
  bez dodatnog pitanja.
- Ne brisi tudje fajlove bez pitanja.

## Push na GitHub (podrazumevani workflow)

Cilj: korisnik uvek ima u repozitorijumu ono sto je uradjeno, ali **samo ako
odobri push**. Remote je `origin` (`https://github.com/sampisdubis/moj-ai-workspace`).

Na kraju svakog zadatka, pre nego sto zavrsis odgovor:

1. Proveri `git status --short` i `git diff --stat`.
2. Ako ima izmena:
   - azuriraj `sessions/YYYY-MM-DD-kratak-naziv/notes.md` (sta je uradjeno,
     odluke, sledeci koraci);
   - ako postoje, pokreni lint/test;
   - kratko navedi sta je uradjeno i predlozi commit poruku.
3. Pitaj korisnika preko `question` alata sa opcijama:
   - "Commit + push" (podrazumevano),
   - "Samo commit",
   - "Ne diraj".
4. Tek posle izricitog odobrenja:
   - stage-uj samo namenske fajlove (`git add <putanja> ...`), nikad tajne;
   - commit u stilu repozitorijuma (kratko, na srpskom);
   - `git push origin <trenutna-grana>`; nikad `--force`.

Ako korisnik ne odobri, ostavi izmene u radnom stablu i kazi sta ceka push.
Ako kaze "sacuvaj"/"push", to je vec odobrenje — ne pitaj ponovo.

"Na adekvatno mesto" znaci: kod i konfiguracija tamo gde pripadaju u projektu,
a sesijski artefakti u `sessions/<sesija>/`. Ne pushuj slucajne fajlove.
