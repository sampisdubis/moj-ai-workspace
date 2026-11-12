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

- Ne upisuj tajne (.env, tokene, kljuceve) u repozitorijum.
- Na kraju sesije azuriraj `notes.md`.
- Kada korisnik kaze "sacuvaj" ili "push", commituj i pushuj na GitHub.
- Ne brisi tudje fajlove bez pitanja.
