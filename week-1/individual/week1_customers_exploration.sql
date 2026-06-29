-- Nädal: 1 | Meeskond: Toode | Roll B
-- Roll: kliendiandmete uurija (Customer Data Explorer)

-- Mitu klienti on kokku?
SELECT COUNT(*) AS klientide_arv
FROM customers;
-- Kokku on 3150 klienti.

-- Too välja esimesed 10 rida, et näha veergude struktuuri.
SELECT *
FROM customers
LIMIT 10;
-- Veerge on kokku 9: customer_id, first_name, last_name, email,
-- phone, city, registration_date, loyalty_tier ja birth_year.

-- Millistest linnadest kliendid tulevad?
SELECT COUNT(DISTINCT city) AS linnade_arv
FROM customers;
-- Linnade nimedes on suur- ja väiketähtedest tingitud kordusi.

-- Filtreeri Tallinna kliendid, ühtlustades nimekuju päringus.
SELECT *
FROM customers
WHERE UPPER(TRIM(city)) = 'TALLINN'
ORDER BY last_name ASC;
-- Nimekuju ühtlustamine suurendas tulemuse 1135 kliendilt 1158 kliendile.

-- Kontrolli esimest ja viimast registreerimiskuupäeva.
SELECT
    MIN(registration_date) AS vanim,
    MAX(registration_date) AS uusim
FROM customers;
-- Vanim 2020-01-02, uusim 2025-02-27

-- Mitu klienti on puuduva eesnimega?
SELECT COUNT(*) - COUNT(first_name) AS puuduvad_eesnimed
FROM customers;
-- Kõigil on eesnimed olemas

-- Mitu klienti on puuduva e-posti aadressiga?
SELECT COUNT(*) - COUNT(email) AS puuduvad_emailid
FROM customers;
-- E-posti aadress puudub 380 kliendil.

-- Mitu korduvat e-posti aadressi tabelis on?
SELECT COUNT(email) - COUNT(DISTINCT email) AS korduvad_emailid
FROM customers;
-- Korduvaid e-posti aadresse on 130.


-- Loe kliendid normaliseeritud linna järgi kokku.
SELECT INITCAP(TRIM(city)) AS linn,
       COUNT(*) AS klientide_arv
FROM customers
GROUP BY INITCAP(TRIM(city))
ORDER BY klientide_arv DESC;

-- Leia kliendid, kes registreerusid alates 2024-11-01.
SELECT *
FROM customers
WHERE registration_date >= '2024-11-01'
ORDER BY registration_date DESC;
-- Tulemuses on 230 klienti.
