--Nädal: 1          Meeskond: [Toode]          Roll: B
--ROLL: Kliendiandmete uurija (Customer Data Explorer)

-- Mitu klienti on kokku?    
SELECT COUNT(*) AS klientide_arv 
FROM customers; 
-- Kokku on 3150 klienti

--Too välja esimesed 10 rida, et näha veergude struktuuri:
SELECT * FROM customers 
LIMIT 10; 
--Veerge on kokku 9, customer_id, first_name, last_name, email,  phone, city, registration_date, loyalty_tier, birth_year

--Millistest linnadest kliendid tulevad?
SELECT Count 
(DISTINCT city)
FROM customers;
--Torkab silma, et linnade seas on palju kordusi, sest erinevus on suurtes ja väikestes tähtedes

--1. Filtreeri kindla linna kliendid. Kasuta WHERE tingimust:
SELECT  *
FROM customers    
WHERE city = 'Tallinn' OR city='TALLINN'
ORDER BY last_name ASC;
   
-- Tallinn andis 1135 klienti, kui lisasin TALLINN oli 1158 klienti, see näitab et tuleb sellistes päringutes tuleb kirjapilt ühtlustada enne päringut

--1. Kontrolli registreerimise kuupäevi. Millal esimesed ja viimased kliendid registreerusid?
SELECT 
MIN(registration_date) AS vanim,           
MAX(registration_date) AS uusim    
FROM customers;
-- Vanim 2020-01-02, uusim 2025-02-27

-- Mitu klienti, kus eesnimi on puudu? 
SELECT 
COUNT(*) - COUNT(last_name) AS puuduvad_eesnimed    
FROM customers;
-- Kõigil on eesnimed olemas

 -- Mitu klienti, kus e-mail on puudu? 
 SELECT 
 COUNT(*) - COUNT(email) AS puuduvad_emailid    
 FROM customers;    `
-- Puud on 380 emaili

--Kas tabelid on dublikaatseid emaile
SELECT 
 COUNT(email) - COUNT(DISTINCT email) AS korduvad_emailid    
 FROM customers;  
 -- ON 130 duplikaati


 --Loe kliendid linniti kokku:
SELECT city, 
COUNT(*) AS klientide_arv   
FROM customers   
GROUP BY city   ORDER BY klientide_arv DESC; 
--Sama probleem, linna nime suur ja väiketähed ei anna õiget ülevaadet

--Leia uuemad kliendid (viimase 6 kuu registreerimised):
SELECT  FROM customers  
 WHERE registration_date >= '2024-11-01'   
 ORDER BY registration_date DESC; 
--230 klienti