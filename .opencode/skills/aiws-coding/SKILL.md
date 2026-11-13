---
name: AIWS Programiranje
description: Programiranje i izmene koda - minimalne izmene, pracenje konvencija projekta, testiranje i zavrsni izvestaj. Use when writing, reviewing, debugging, refactoring, or changing code.
---

# Module: Programiranje i izmjene koda

Aktiviraj ovaj modul kada pišeš, pregledaš, otklanjaš greške ili mijenjaš kod.

## Prije izmjene
- Prvo pregledaj relevantni kod, strukturu projekta, postojeće konvencije, zavisnosti i testove.
- Utvrdi kako se aplikacija pokreće i kako se provjerava ispravnost, ako su te informacije dostupne.
- Razjasni cilj i kriterijum prihvatanja. Ne nagađaj o arhitekturi kada je možeš pregledati.
- Ako postoji više razumnih rješenja, izaberi najmanje rizično koje odgovara postojećem projektu.

## Tokom izmjene
- Mijenjaj samo ono što je potrebno za zahtjev.
- Ne refaktoriši nepovezane djelove i ne mijenjaj formatiranje bez potrebe.
- Prati postojeći stil i obrasce projekta, osim kada postoji konkretan razlog da ih promijeniš.
- Ne dodaj nove biblioteke, konfiguracione opcije, slojeve apstrakcije ili funkcionalnosti bez opravdanja.
- Ukloni samo ono što je tvoja izmjena učinila nepotrebnim; postojeći nepovezani dug ili mrtav kod prijavi, ali ga ne uklanjaj samoinicijativno.
- Obrati pažnju na validaciju ulaza, upravljanje greškama, autentifikaciju, autorizaciju, tajne i druge bezbjednosne implikacije.

## Provjera
- Kada je moguće, prvo napravi ili identifikuj test koji reprodukuje problem.
- Pokreni najrelevantnije testove, lint, type-check ili build koji su dostupni.
- Ne tvrdi da test prolazi ako ga nijesi pokrenuo i vidio rezultat.
- Ako testovi nijesu dostupni ili nijesu mogli biti pokrenuti, navedi to izričito.
- Pregledaj konačni diff: svaka izmjena treba da ima jasnu vezu sa zahtjevom.

## Završni izvještaj
Sažeto navedi:
1. Šta je promijenjeno.
2. Zašto je promijenjeno.
3. Koje provjere su izvršene i njihov rezultat.
4. Šta ostaje neprovjereno ili predstavlja rizik.
