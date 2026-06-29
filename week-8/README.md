# Nädal 8: Python, API-d ja ETL-pipeline

## Projekti eesmärk

Meeskond automatiseeris UrbanStyle'i iganädalase müügiülevaate. ETL-pipeline pärib andmed Supabase API-st, puhastab ja ühendab tabelid, arvutab KPI-d, loob Plotly visualiseeringud ning ekspordib tulemused CSV- ja HTML-failidena.

## Minu roll

Roll A: API Query. Minu moodul [`data_fetcher.py`](individual/data_fetcher.py) vastutab `sales`, `customers` ja `products` tabelite turvalise pärimise eest.

Moodul sisaldab:

- Supabase'i ühenduse loomist keskkonnamuutujate kaudu;
- 1000 rea kaupa lehitsemist ehk pagination'it;
- kuni kolme katsega retry-loogikat;
- 1, 2 ja 4 sekundi pikkust exponential backoff'i;
- CSV-varuandmete kasutamist API tõrke korral;
- selgeid logi- ja veateateid.

## Meeskonna pipeline

1. **Extract:** andmete pärimine API-st või CSV-varuallikast.
2. **Transform:** puhastamine, tabelite ühendamine ja KPI-de arvutamine.
3. **Visualize:** nädalakäibe ja KPI-de Plotly graafikud.
4. **Export:** tulemuste salvestamine CSV- ja HTML-failidena.

## Demo tulemus

Meeskonna kontrollkäivitus lõppes edukalt ning lõi 2023.–2024. aasta andmete põhjal järgmise kokkuvõtte:

- kogukäive ligikaudu 2,69 miljonit eurot;
- 2464 unikaalset klienti;
- keskmine tellimuse väärtus 287,80 eurot;
- 105 nädalakoondit.

## Äriline väärtus

Marko ei pea iganädalast müügiülevaadet enam käsitsi koostama. Sama töövoog saab käia ühe käsuga ning tulemus on kohe analüüsiks ja jagamiseks valmis. CSV fallback ja retry-loogika vähendavad välise teenuse tõrgetest tulenevat katkestusriski.

## Turvalisus

API URL ja võti loetakse `.env` failist; tunnuseid ei kirjutata koodi ega lisata GitHubi. Reposse sobib ainult väärtusteta `.env.example` näidis.

## Väljundid

- [Minu API päringumoodul](individual/data_fetcher.py)
- [Meeskonna pipeline'i demo ja arhitektuur](team/week8_pipeline_demo.md)

Portfoolio sisaldab nõuete järgi minu individuaalset moodulit ja meeskonna demo kirjeldust. Terviklik pipeline koos teiste rollide moodulitega asus meeskonna ühises tööruumis.

## AI kasutamine

Kasutasin AI-d moodulite liideste kontrollimiseks, veerunimede erinevuste leidmiseks ning pagination'i, retry-loogika ja dokumentatsiooni täpsustamiseks. Kontrollisin pipeline'i toimimist reaalse tervikkäivitusega.

## Refleksioon

- **API eelis CSV ees:** värskeid andmeid saab pärida automaatselt ilma faile käsitsi asendamata.
- **Keerukaim integratsioonikoht:** moodulite sisend- ja väljundvormingute ühtlustamine.
- **Veakäsitluse väärtus:** retry, logimine ja fallback muudavad töövoo töökindlamaks ning vead lihtsamini diagnoositavaks.
- **Järgmine automatiseerimine:** ajastatud andmevärskendus ja raporti automaatne saatmine sidusrühmadele.
