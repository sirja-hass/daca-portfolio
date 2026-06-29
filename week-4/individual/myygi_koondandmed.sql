-- Nädal 4 | Meeskond: Toode | Roll A
-- Roll: müügi koondandmete analüüs

-- 1. Müük 2024. aasta kuude kaupa.
SELECT DATE_TRUNC('month', sale_date) AS kuu,
       COUNT(sale_id) AS tellimuste_arv,
       ROUND(SUM(total_price), 2) AS kogukäive,
       ROUND(AVG(total_price), 2) AS keskmine_tellimus
FROM sales
WHERE sale_date >= DATE '2024-01-01'
  AND sale_date < DATE '2025-01-01'
GROUP BY DATE_TRUNC('month', sale_date)
ORDER BY kuu;

-- 2. Tootekategooriate 2024. aasta müük.
-- Näita ainult kategooriaid, mille kogumüük ületab 1000 eurot.
SELECT p.category,
       COUNT(DISTINCT p.product_id) AS toodete_arv,
       ROUND(SUM(s.total_price), 2) AS kogumüük,
       ROUND(AVG(s.unit_price), 2) AS keskmine_hind
FROM sales s
INNER JOIN products p ON s.product_id = p.product_id
WHERE s.sale_date >= DATE '2024-01-01'
  AND s.sale_date < DATE '2025-01-01'
GROUP BY p.category
HAVING SUM(s.total_price) > 1000
ORDER BY kogumüük DESC;

-- 3. Kuust-kuusse käibemuutus.
-- Detsember 2023 on kaasatud ainult jaanuari muutuse võrdlusbaasiks.
WITH kuu_myyk AS (
    SELECT DATE_TRUNC('month', sale_date) AS kuu,
           SUM(total_price) AS käive
    FROM sales
    WHERE sale_date >= DATE '2023-12-01'
      AND sale_date < DATE '2025-01-01'
    GROUP BY DATE_TRUNC('month', sale_date)
),
kuu_vordlus AS (
    SELECT kuu,
           käive,
           LAG(käive) OVER (ORDER BY kuu) AS eelmine_kuu
    FROM kuu_myyk
)
SELECT kuu,
       ROUND(käive, 2) AS käive,
       ROUND(eelmine_kuu, 2) AS eelmine_kuu,
       ROUND(käive - eelmine_kuu, 2) AS muutus
FROM kuu_vordlus
WHERE kuu >= DATE '2024-01-01'
ORDER BY kuu;

-- 4. Edasijõudnute tase: kuust-kuusse kasvuprotsent.
WITH kuu_myyk AS (
    SELECT DATE_TRUNC('month', sale_date) AS kuu,
           SUM(total_price) AS käive
    FROM sales
    WHERE sale_date >= DATE '2023-12-01'
      AND sale_date < DATE '2025-01-01'
    GROUP BY DATE_TRUNC('month', sale_date)
),
kuu_vordlus AS (
    SELECT kuu,
           käive,
           LAG(käive) OVER (ORDER BY kuu) AS eelmine_kuu
    FROM kuu_myyk
)
SELECT kuu,
       ROUND(käive, 2) AS käive,
       ROUND(eelmine_kuu, 2) AS eelmine_kuu,
       ROUND(käive - eelmine_kuu, 2) AS muutus,
       ROUND((käive - eelmine_kuu) / NULLIF(eelmine_kuu, 0) * 100, 1) AS kasvu_protsent
FROM kuu_vordlus
WHERE kuu >= DATE '2024-01-01'
ORDER BY kuu;
