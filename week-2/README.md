# Nädal 2: SQL ja tooteandmete puhastamine

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
Kasutasin kategooriate standardiseerimiseks järgmist päringut:

```sql
UPDATE products_test
SET category = INITCAP(TRIM(category))
WHERE category != INITCAP(TRIM(category));
```

## Kokkuvõte
`products` tabeli andmekvaliteet oli üldiselt hea. Peamine probleem olid korduvad tootenimed.

## Soovitus Toomasele
Soovitan kontrollida duplikaatseid tootenimesid, et vältida topelttooteid analüüsides ja raportites.

## Väljundid

- [Minu puhastamise SQL-päringud](individual/week2_products_cleaning.sql)
- [Meeskonna andmekvaliteedi koondraport](team/week2_team_cleaning_report.md)
