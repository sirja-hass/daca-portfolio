# Nädal 8: UrbanStyle'i ETL-pipeline'i demo

## Eesmärk

Muuta UrbanStyle'i iganädalane käsitsi koostatav müügiülevaade automaatseks ja veakindlaks Python pipeline'iks.

## Arhitektuur ja rollid

| Etapp | Roll | Moodul | Vastutus |
| --- | --- | --- | --- |
| Extract | A: API Query | `data_fetcher.py` | Supabase'i päringud, pagination, retry ja CSV fallback |
| Transform | B: Data Processing | `transform.py` | Andmete puhastamine, ühendamine ja KPI-d |
| Visualize | C: Visualization | `visualize_export.py` | Plotly graafikud ning CSV- ja HTML-eksport |
| Orchestrate | D: Automation | `pipeline.py` | Kogu töövoo käivitamine, logimine ja veahaldus |

## Integratsioonitesti tulemus

Pipeline läbis kõik neli etappi:

```text
EXTRACT OK
TRANSFORM OK
VISUALIZE OK
EXPORT OK
```

Kontrollkäivituse tulemus:

- kogukäive ligikaudu 2,69 miljonit eurot;
- 2464 unikaalset klienti;
- keskmine tellimuse väärtus 287,80 eurot;
- väljundina ajatempliga CSV ja kaks HTML-raportit.

## Töökindlus

- API päringud loetakse lehekülgede kaupa;
- ajutiste vigade korral kasutatakse retry'd ja exponential backoff'i;
- API tõrke korral kasutatakse CSV-varuandmeid;
- etappide tegevused ja vead kirjutatakse logifaili;
- visualiseerimise tõrge ei takista CSV-väljundi loomist.

## Peamine järeldus Markole

Iganädalast müügiülevaadet ei pea enam käsitsi koostama. Pipeline muudab andmete pärimise ja raporti loomise korratavaks ning vähendab käsitsi tehtavate vigade riski.

## AI kasutamine

AI aitas kontrollida moodulite omavahelist sobivust, leida veerunimede erinevusi ning täpsustada pagination'i, retry-loogikat ja terminaliväljundit. Lõpptulemus valideeriti pipeline'i tervikkäivitusega.
