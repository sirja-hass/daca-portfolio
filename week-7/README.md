# Nädal 7: Python ja pandas — RFM-kliendisegmenteerimine

## Minu roll

Roll D: visualiseerimine ja leidude esitamine. Kasutasin Roll C loodud RFM-tabelit, et koostada Plotly diagrammid kliendisegmentide jaotuse, profiili ning kümne suurima VIP-kliendi kohta. Lisaks sõnastasin tulemuste ärilise tähenduse ja soovitused Markole.

## Meetod

RFM-analüüs hindab iga kliendi puhul kolme näitajat:

- **Recency:** kui hiljuti klient viimati ostis;
- **Frequency:** kui sageli klient ostab;
- **Monetary:** kui palju klient kokku kulutab.

Nende põhjal jagati kliendid segmentidesse `VIP Champions`, `Loyal`, `Potential`, `At Risk` ja `Lost`.

## Peamised leiud

- `Potential` ja `Loyal` on suurimad kliendigrupid ning neid saab lojaalsusprogrammi ja sihitud pakkumistega kasvatada väärtuslikumateks klientideks.
- `VIP Champions` on väiksem, kuid kõrge väärtusega segment. Neile sobivad varajane ligipääs uutele kollektsioonidele, tasuta saatmine ja personaalsem teenindus.
- `At Risk` ja `Lost` vajavad kiiret tagasivõitmise kampaaniat, sest nende viimasest ostust on möödunud rohkem aega.
- RFM-segmendid põhinevad tegelikul ostukäitumisel. Neid tasub võrrelda olemasoleva `loyalty_tier` väljaga, et leida vastuolud ametliku staatuse ja kliendi päris käitumise vahel.

## Väljundid

- [Minu Roll D notebook](individual/week7_rfm_D.ipynb)
- [RFM-segmentide CSV](individual/rfm_segments.csv)
- [Meeskonna terviklik notebook](team/week7_rfm_complete.ipynb)

Individuaalne notebook sisaldab Roll D osa ja eeldab sisendina Roll C loodud `rfm_viz` DataFrame'i. Terviklik töövoog on meeskonna notebook'is.

## AI kasutamine

Kasutasin AI-d Plotly visualiseeringute paigutuse ja värvikasutuse parandamiseks ning äriliste soovituste selgemaks sõnastamiseks. Kontrollisin tulemused RFM-andmete ja diagrammide põhjal ise üle.
