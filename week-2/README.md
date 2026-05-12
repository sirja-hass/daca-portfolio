# Nädal 2: SQL Cleaning 
# Tooteandmete puhastamisraport

## Roll
Tooteandmete puhastaja (Product Data Cleaner)

## Tabel
products_test

## Tulemused
- Testkoopia sisaldas 362 rida.
- Leidsin 12 duplikaatset tootenime.
- NULL väärtusi ega puuduvaid välju ei leitud.
- Negatiivseid või äärmuslikke hindu ei leitud.
- Ebajärjekindlaid kategooria nimekujusid ei leitud.
- NULL cost_price või category väärtustega ridu ei leitud.

## Puhastamine
Kontrollisin kategooriate standardiseerimist `INITCAP(TRIM(category))` abil, kuid muudatusi ei tehtud, sest kategooriad olid juba korrektses formaadis.

## Kokkuvõte
Products tabeli andmekvaliteet oli üldiselt hea. Peamine probleem olid duplikaatsed tootenimed.

## Soovitus Toomasele
Soovitan kontrollida duplikaatseid tootenimesid, et vältida topelttooteid analüüsides ja raportites.
