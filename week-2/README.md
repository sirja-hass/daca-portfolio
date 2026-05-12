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
Kasutasin kategooriate standardiseerimiseks:

```sql
UPDATE products_test
SET category = INITCAP(TRIM(category))
WHERE category != INITCAP(TRIM(category));

## Kokkuvõte
Products tabeli andmekvaliteet oli üldiselt hea. Peamine probleem olid duplikaatsed tootenimed.

## Soovitus Toomasele
Soovitan kontrollida duplikaatseid tootenimesid, et vältida topelttooteid analüüsides ja raportites.
