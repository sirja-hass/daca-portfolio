-- Nädal 2 Tooteandmete puhastaja (Product Data Cleaner)
--Loo test koopia:

CREATE TABLE products_test AS SELECT * FROM products;
SELECT COUNT(*) AS ridade_arv FROM products_test;
--362 rida

--Leia duplikaadid — kas on korduvaid tootenimesid?
SELECT product_name, COUNT(*) AS koopiate_arv
FROM products_test
GROUP BY product_name
HAVING COUNT(*) > 1
ORDER BY koopiate_arv DESC;
--12 dupikaatset tootenime, kõiki 2 tk

--Leia NULL väärtused kriitilistes väljades:
SELECT
    COUNT(*) FILTER (WHERE product_name IS NULL OR product_name = '') AS null_nimi,
    COUNT(*) FILTER (WHERE category IS NULL OR category = '') AS null_kategooria,
    COUNT(*) FILTER (WHERE retail_price IS NULL) AS null_jaehind,
    COUNT(*) FILTER (WHERE cost_price IS NULL) AS null_omahind
FROM products_test;
--Ei lednud ühtegi null ega puuduvat väärtust

--Kontrolli loogilisi vigu — kas on ebareaalseid hindu?
-- Kas on negatiivseid hindu?
SELECT COUNT(*) AS negatiivne_hind
FROM products_test
WHERE retail_price < 0;
--Puuduvad

-- Kas on äärmuslikke hindu (> 1000€)?
SELECT product_name, retail_price
FROM products_test
WHERE retail_price > 1000
ORDER BY retail_price DESC;
--puuduvad

--Kontrolli kategooriate järjekindlust:
SELECT category, COUNT(*) AS arv
FROM products_test
GROUP BY category
ORDER BY category;
--Ebajärjekindlaid kategooria nimekujusid ei leitud.

--NULL omahind/kategooria
SELECT *
FROM products_test
WHERE cost_price IS NULL
   OR category IS NULL;
   --Ridu ei leitud

   -- Ühtlusta kategooriate nimed
UPDATE products_test
SET category = INITCAP(TRIM(category))
WHERE category != INITCAP(TRIM(category));

-- Kontrolli tulemust
SELECT category, COUNT(*) AS arv
FROM products_test
GROUP BY category ORDER BY category;

UPDATE products_test
SET category = CASE
    WHEN LOWER(TRIM(category)) IN ('shoes', 'jalanõud', 'footwear') THEN 'Shoes'
    WHEN LOWER(TRIM(category)) IN ('shirts', 'särgid', 'tops') THEN 'Shirts'
    WHEN LOWER(TRIM(category)) IN ('pants', 'püksid', 'trousers') THEN 'Pants'
    ELSE INITCAP(TRIM(category))
END;

SELECT COUNT(*)
FROM products
WHERE category != INITCAP(TRIM(category));

-- Puhastamisraport
-- Duplikaatsed nimed: leitud 12 korduvat tootenime.
-- NULL nimi/hind: puuduvaid väärtusi ei leitud.
-- Loogilised vead: negatiivne või äärmuslik jaehind puudub.
-- Ebajärjekindlad kategooriad: ebajärjekindlaid nimekujusid ei leitud.
-- NULL omahind/kategooria: vigu ei leitud.
-- Kokku: leitud 12 korduvat tootenime.

 
