-- Nädal 2 | Meeskond: Toode | Roll C
-- Roll: tooteandmete puhastaja (Product Data Cleaner)

-- Loo analüüsimiseks värske testkoopia. Originaaltabelit ei muudeta.
DROP TABLE IF EXISTS products_test;
CREATE TABLE products_test AS
SELECT *
FROM products;

SELECT COUNT(*) AS ridade_arv
FROM products_test;
-- Testkoopias on 362 rida.

-- Leia korduvad tootenimed.
SELECT product_name,
       COUNT(*) AS koopiate_arv
FROM products_test
GROUP BY product_name
HAVING COUNT(*) > 1
ORDER BY koopiate_arv DESC;
-- Leitud 12 korduvat tootenime; iga nimi esineb kaks korda.

-- Kontrolli puuduvaid väärtusi kriitilistes väljades.
SELECT
    COUNT(*) FILTER (WHERE product_name IS NULL OR TRIM(product_name) = '') AS puuduv_nimi,
    COUNT(*) FILTER (WHERE category IS NULL OR TRIM(category) = '') AS puuduv_kategooria,
    COUNT(*) FILTER (WHERE retail_price IS NULL) AS puuduv_jaehind,
    COUNT(*) FILTER (WHERE cost_price IS NULL) AS puuduv_omahind
FROM products_test;
-- Puuduvaid väärtusi ei leitud.

-- Kontrolli negatiivseid ja äärmuslikke hindu.
SELECT product_name,
       retail_price
FROM products_test
WHERE retail_price < 0
   OR retail_price > 1000
ORDER BY retail_price DESC;
-- Negatiivseid ega üle 1000 euro suuruseid jaehindu ei leitud.

-- Vaata kategooriate nimekujusid enne standardiseerimist.
SELECT category,
       COUNT(*) AS toodete_arv
FROM products_test
GROUP BY category
ORDER BY category;

-- Ühtlusta kategooriate tühikud ja suur-/väiketähed.
UPDATE products_test
SET category = INITCAP(TRIM(category))
WHERE category IS DISTINCT FROM INITCAP(TRIM(category));

-- Ühenda võimalikud sünonüümid ühtse nimetuse alla.
UPDATE products_test
SET category = CASE
    WHEN LOWER(TRIM(category)) IN ('shoes', 'jalanõud', 'footwear') THEN 'Shoes'
    WHEN LOWER(TRIM(category)) IN ('shirts', 'särgid', 'tops') THEN 'Shirts'
    WHEN LOWER(TRIM(category)) IN ('pants', 'püksid', 'trousers') THEN 'Pants'
    ELSE INITCAP(TRIM(category))
END;

-- Valideeri puhastatud testtabel.
SELECT category,
       COUNT(*) AS toodete_arv
FROM products_test
GROUP BY category
ORDER BY category;

SELECT COUNT(*) AS standardiseerimata_kategooriaid
FROM products_test
WHERE category IS DISTINCT FROM INITCAP(TRIM(category));

-- Kokkuvõte:
-- leitud 12 korduvat tootenime;
-- kriitilisi puuduvaid väärtusi ega ebarealistlikke hindu ei leitud;
-- kategooriate nimekujud standardiseeriti testtabelis.
