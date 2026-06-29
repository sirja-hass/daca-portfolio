# Nädal 2: andmekvaliteedi koondraport

**Meeskond:** Toode

**Tegelane:** Toomas Kask

## Peamised leiud

- **Triin — müügiandmed:** 4018 korduvat `sale_id` väärtust, 1487 puuduvat `customer_id` väärtust ja 8 tulevikukuupäevaga tehingut. Pärast kontrolli jäi alles 988 puuduva kliendiviitega tehingut, mida käsitleti külalisostudena.
- **Jörgen — kliendiandmed:** 128 korduvat ja 380 puuduvat e-posti aadressi. Linnade 54 erinevat nimekuju standardiseeriti 12 linnaks.
- **Sirja — tooteandmed:** 12 korduvat tootenime; muid kriitilisi puuduvaid väärtusi ega hinnavigu ei leitud.
- **Tuuli — ristkontroll:** 1487 puuduva kliendiviitega müüki, 664 müügi- ja tootehinna lahknevust, 592 ostuta klienti ning 12 müümata toodet. Need kategooriad võivad osaliselt kattuda.

## Suurim üllatus

Kõige suuremad probleemid olid müügitabeli kordused ja linnanimede ebaühtlane kirjapilt. Positiivne oli see, et tooteandmete kriitilistes väljades puuduvad väärtused ja ebarealistlikud hinnad puudusid.

## Soovitus Toomasele

Kehtestada sisestusreeglid ja valideerimised, mis takistavad korduvaid ID-sid, standardiseerivad asukohanimed ning kontrollivad kliendi- ja tooteviiteid juba andmete sisestamisel.

## Puuduvad ärireeglid

Täpsustada tuleb, kas negatiivsed summad tähistavad tagastusi, tühistamisi või sisestusvigu ning kas kõik puuduva kliendiviitega tehingud on päriselt külalisostud.

## Meeskonna esitlus

[Ava nädala 2 slaidiesitlus](https://docs.google.com/presentation/d/1A8KvN7d0f7EDag7m9cagzEe5bE2fw8dw/edit?slide=id.g3e132ed0bcd_0_4#slide=id.g3e132ed0bcd_0_4)
