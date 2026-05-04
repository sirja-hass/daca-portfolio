-- Päring, et näha näha tellimuste loetelu koos kliendi ID, kuupäeva ja summaga — sorteerituna kuupäeva järgi (uuemad enne).
SELECT customer_id, sale_date, total_price
FROM sales
ORDER BY sale_date DESC
LIMIT 20;

-- Päring, kus tellmus- Summa on üle 200 euro, tellimus on tehtud 2024. aastal
SELECT customer_id, sale_date, total_price
FROM sales
WHERE total_price >= 200 AND sale_date BETWEEN '2024-01-01' AND '2024-12-31'
ORDER BY total_price DESC;

--Päring, kus kõik tellimused, kus midagi on kahtlast — kas summa on 0 või väiksem, või kliendi ID puudub.
SELECT sale_id, customer_id, total_price, customer_id
FROM sales
WHERE total_price<=0 OR customer_id IS null
ORDER BY total_price ASC;
-- Leidsin kahtlased read


-- Päring, mis näitab Toodete koguarv, Unikaalsete kategooriate arv, Puuduvate hindade arv
SELECT 
COUNT(*) AS toodete_koguarv,
COUNT (DISTINCT category) AS unikaalsete_kat_arv,
COUNT(*)- COUNT(cost_price) AS puuduvate_hindade_arv
FROM products;
--Vastus 362, 5 ja 0.

-- Küsimus: mitu duplikaati on?
SELECT
    COUNT(*) AS ridu_kokku,
    COUNT(DISTINCT sale_id) AS unikaalseid,
    COUNT(*) - COUNT(DISTINCT sale_id) AS duplikaate
FROM sales;
--5116 duplikaati

--Päring, mitmel real puudub customer_id?
SELECT
    COUNT(*) AS ridu_kokku,
    COUNT(customer_id) AS klientidega_read,
    COUNT(*) - COUNT(customer_id) AS puudub
FROM sales;
-- 1487 real puudu id, anonüümsed ostud