# Week 8: UrbanStyle ETL Pipeline

## Projekti eesmärk

UrbanStyle OÜ vajas viisi, kuidas iganädalane müügiülevaade automaatselt koostada. Selle töö jaoks ehitasime Python pipeline'i, mis pärib müügi-, kliendi- ja tooteandmed, puhastab need, arvutab peamised KPI-d ning salvestab tulemused CSV ja HTML raportitena.

Pipeline'i põhivoog:

1. Extract - andmete pärimine Supabase API-st või CSV fallback-failidest.
2. Transform - andmete puhastamine, nädalakoondid, KPI-d ja tabelite ühendamine.
3. Visualize - Plotly graafikud nädalase käibe ja KPI-de jaoks.
4. Export - tulemuste salvestamine `output/` kausta.

## Failide ülevaade

| Fail | Roll | Kirjeldus |
| --- | --- | --- |
| `data_fetcher.py` | Roll A: API Query | Pärib `sales`, `customers` ja `products` tabelid Supabase API-st. Kui API ei tööta, kasutab `datasets/` CSV faile. |
| `transform.py` | Roll B: Data Processing | Eemaldab duplikaadid, vormindab kuupäevad, arvutab nädalased koondid ja KPI-d ning ühendab müügi- ja kliendiandmed. |
| `visualize_export.py` | Roll C: Visualization + Saving | Loob Plotly HTML graafikud ja ekspordib tulemused CSV-faili. |
| `pipeline.py` | Roll D: Automation Script | Käivitab kogu töövoo ühe käsuga. |
| `config.yaml` | Konfiguratsioon | Määrab analüüsiperioodi ja väljundkausta. |
| `.env.example` | Näidis | Näitab, milliseid Supabase keskkonnamuutujaid on vaja. |
| `datasets/` | Fallback data | Kohalikud CSV andmed juhuks, kui Supabase pole kättesaadav. |
| `output/` | Väljundid | Pipeline'i loodud CSV ja HTML failid. |
| `logs/` | Logid | Pipeline'i käivituste logifailid. |

## Käivitamine

Paigalda sõltuvused:

```bash
pip install -r requirements.txt
```

Soovi korral loo `.env` fail Supabase ühenduse jaoks:

```bash
cp .env.example .env
```

`.env` faili oodatud muutujad:

```text
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_KEY=your-anon-or-service-role-key
```

Käivita kogu pipeline:

```bash
python pipeline.py
```

Kui `.env` puudub, API võti on vale või Supabase ei vasta, kasutab pipeline automaatselt `datasets/` kaustas olevaid CSV fallback-andmeid.

## Konfiguratsioon

Analüüsi periood ja väljundkaust on failis `config.yaml`:

```yaml
pipeline:
  start_date: "2023-01-01"
  end_date: "2024-12-31"
  output_dir: "output"
```

Demo kasutab perioodi 2023-01-01 kuni 2024-12-31, sest need aastad on andmetes terviklikud.

## Demo tulemus

Viimane edukas käivitus lõi järgmised tulemused:

```text
Käive: 2,691,235.81 EUR
Unikaalseid kliente: 2464
Keskmine tellimuse väärtus: 287.80 EUR
Müügiridu API-st: 9411
Eksporditud ühendatud ridu: 9351
Nädalakoondid: 105 nädalat
```

Loodud failid:

```text
output/pipeline_results_20260625_205349.csv
output/weekly_revenue_20260625_205349.html
output/kpi_summary_20260625_205349.html
logs/pipeline_20260625.log
```

## Väljundid

Pipeline salvestab iga käivituse ajatempliga failinimedega, et varasemaid tulemusi üle ei kirjutataks:

- `pipeline_results_YYYYMMDD_HHMMSS.csv` - ühendatud müügi- ja kliendiandmed.
- `weekly_revenue_YYYYMMDD_HHMMSS.html` - nädalase käibe Plotly graafik.
- `kpi_summary_YYYYMMDD_HHMMSS.html` - KPI kokkuvõtte HTML raport.
- `pipeline_YYYYMMDD.log` - logi extract, transform, visualize ja export sammudest.

## Veakäsitlus

Pipeline on tehtud nii, et demo ei jääks välise teenuse vea tõttu seisma.

- Supabase päringutel on pagination, et suuri tabeleid lugeda 1000 rea kaupa.
- Ajutise API vea korral proovitakse päringut kuni 3 korda.
- Retry loogika kasutab exponential backoff'i: 1s, 2s ja 4s.
- Kui API ei tööta, loetakse andmed `datasets/sales.csv`, `datasets/customers.csv` ja `datasets/products.csv` failidest.
- Kui visualiseerimine ebaõnnestub, jätkab pipeline CSV ekspordiga.
- Kui extract, transform või export ebaõnnestub, logitakse viga ja pipeline peatub.

## Äriline järeldus

UrbanStyle'i 2023-2024 puhastatud andmete põhjal oli kogukäive umbes 2.69 miljonit eurot, unikaalseid kliente oli 2464 ja keskmine tellimuse väärtus oli 287.80 eurot.

See tähendab, et Marko ei pea iganädalast müügiülevaadet enam käsitsi koostama. Sama töövoog käib ühe käsuga ning tulemused on kohe CSV ja HTML kujul jagatavad.

## AI kasutamine

AI-d kasutati abina moodulite kokkusobivuse kontrollimiseks, veerunimede erinevuste leidmiseks, pagination'i ja retry loogika täpsustamiseks, README struktuuri parandamiseks ning pipeline'i terminali- ja logiväljundi selgemaks muutmiseks.

## Seotud fail

Meeskonna lühike demo-kokkuvõte asub failis `team/week8_pipeline_demo.md`.
