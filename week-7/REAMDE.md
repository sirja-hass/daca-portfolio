## Nädal 7: Python Pandas — RFM kliendisegmenteerimine

### Minu roll
Roll D: Visualization ehk visualiseerimine ja leidude esitamine. Minu ülesanne oli Roll C loodud RFM tabeli põhjal koostada Plotly diagrammid, mis näitavad kliendisegmentide jaotust, segmentide profiili ning TOP 10 VIP klienti kogukulutuse järgi. Lisaks koostasin lühikese äritõlgenduse ja soovitused Markole.

### Peamised leiud
- Kõige suuremad kliendigrupid on Potential ja Loyal segmendid, mis näitab, et UrbanStyle'il on palju kliente, keda saab sihitud pakkumiste ja lojaalsusprogrammiga kasvatada väärtuslikumateks klientideks.
- VIP Champions kliendid on väiksem, aga äriliselt väga oluline segment, sest nad ostavad sagedamini ja kulutavad rohkem. Neile tasub pakkuda eritingimusi, näiteks varajast ligipääsu uutele kollektsioonidele, tasuta saatmist ja personaalsemat klienditeenindust.
- At Risk ja Lost segmentide puhul on oluline tegutseda kiiresti, näiteks win-back kampaaniaga, sest nende klientide viimasest ostust on möödas rohkem aega ja nad võivad ettevõttest eemalduda.
- RFM analüüs põhineb ostukäitumisel, mitte ettevõtte olemasoleval `loyalty_tier` väljal. Seetõttu tasub võrrelda RFM segmente lojaalsustasemega, et leida kliendid, kelle ostukäitumine ja ametlik lojaalsusstaatus ei ole kooskõlas.

### AI kasutamine
Kasutasin AI abi RFM tulemuste visualiseerimiseks Plotly abil ning graafikute värvide ja paigutuse parandamiseks. AI aitas sõnastada ka äritõlgenduse nii, et soovitused oleksid seotud konkreetsete kliendisegmentidega.