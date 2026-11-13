# AI Working System

Univerzalni skup instrukcija za konzistentniji rad sa različitim AI modelima i agentima. Inspirisan je principima jednostavnosti, promišljenog rada, minimalnih izmjena i provjerljivih ciljeva iz Karpathy-style coding guidelines, ali je proširen i za istraživanje, analizu i rad sa alatima.

## Sadržaj

- `CORE.md` — zajednička pravila za sve razgovore.
- `modules/CODING.md` — programiranje, pregled i izmjene koda.
- `modules/RESEARCH.md` — istraživanje i provjera informacija.
- `modules/ANALYSIS-DECISIONS.md` — procjena ideja i donošenje odluka.
- `modules/AGENT-EXECUTION.md` — agenti koji koriste alate i izvršavaju višekoračne zadatke.
- `SESSION-START.md` — šablon za početak sesije kada ne postoji trajno polje za instrukcije.
- `ALL-IN-ONE.md` — objedinjena verzija za kopiranje u sisteme koji podržavaju samo jedan blok instrukcija.

## Kako postaviti

1. **Najbolja opcija:** ako alat podržava system/developer instructions ili projektna pravila, postavi `CORE.md` tamo.
2. **Za konkretan projekat:** dodaj samo relevantni modul uz osnovu. Primjer: `CORE.md` + `modules/CODING.md`.
3. **Za novu sesiju bez trajnih instrukcija:** kopiraj `ALL-IN-ONE.md` ili pošalji `CORE.md`, zatim odgovarajući modul i šablon iz `SESSION-START.md`.
4. **Za agenta:** postavi osnovu i odgovarajući modul u najviši nivo instrukcija koji ti platforma dozvoljava; konkretan zadatak zadaj odvojeno.

## Važna ograničenja

- Ovo ne mijenja model, njegove stvarne sposobnosti, alatke, kontekstni prozor ili pristup podacima.
- Instrukcije nijesu garancija ponašanja. Model može pogrešno protumačiti ili zanemariti pravilo, naročito kada je kontekst dug ili su instrukcije u sukobu.
- Sistemska pravila platforme i bezbjednosna ograničenja imaju prednost nad ovim paketom.
- Nemoj uključivati sve module u svaki razgovor. Višak instrukcija može povećati šum i sukobe.
- Za produkcijske agente testiraj instrukcije na stvarnim zadacima i prati greške; nemoj se oslanjati samo na prompt.

## Preporučeni početni test

Uzmi tri zadatka: jedan jednostavan, jedan koji traži prosuđivanje i jedan koji traži provjeru/izvršenje. Uporedi rezultate sa i bez instrukcija. Gledaj tačnost, broj nepotrebnih pitanja, neželjene izmjene, kvalitet provjere i vrijeme do korisnog rezultata.
