--week_4 grupitöö Müügi koondandmed
-- Müük kuude kaupa. Kirjuta päring, mis näitab 2024. aasta iga kuu kohta: tellimuste arv, kogukäive, keskmine tellimusväärtus. Kasuta DATE_TRUNC('month', sale_date) grupeerimiseks. Struktuur:

SELECT      DATE_TRUNC('month', sale_date) AS kuu,      
COUNT(sale_id) AS tellimuste_arv,      
SUM(total_price) AS kogukäive,      
ROUND(AVG(total_price), 2) AS keskmine_tellimus    
FROM sales    
WHERE sale_date >= '2023-12-01'    AND sale_date <'2025-01-01'
GROUP BY DATE_TRUNC('month', sale_date)    
ORDER BY kuu;    

--Ühenda sales ja products    - GROUP BY category    - Lisa: toodete arv, kogumüük, keskmine hind   
-- HAVING: ainult kategooriad, kus kogumüük > vali ise piir
SELECT
    p.category,
    COUNT(DISTINCT p.product_id) AS toodete_arv,
    SUM(s.total_price) AS kogumüük,
    ROUND(AVG(s.unit_price), 2) AS keskmine_hind
FROM sales s
INNER JOIN products p
    ON s.product_id = p.product_id
WHERE s.sale_date >= '2024-01-01'
  AND s.sale_date < '2025-01-01'
GROUP BY p.category
HAVING SUM(s.total_price) > 1000
ORDER BY kogumüük DESC;

  --Kasuta CTE-d, et leida kuust-kuusse muutus:
 WITH kuu_myyk AS 
 (      SELECT        DATE_TRUNC('month', sale_date) AS kuu,        
 SUM(total_price) AS käive     
  FROM sales      
  WHERE sale_date >= '2023-12-01'      AND sale_date <'2025-01-01'
  GROUP BY DATE_TRUNC('month', sale_date)    )  

  SELECT      kuu,      käive,      
  LAG(käive) OVER (ORDER BY kuu) AS eelmine_kuu,      käive - LAG(käive) OVER (ORDER BY kuu) AS muutus    
  FROM kuu_myyk    
  ORDER BY kuu; 

-- Edasijõudnute (30%): Samm 3 — CTE + window function, arvuta kuust-kuusse kasvu protsent:
  WITH kuu_myyk AS (
    SELECT
        DATE_TRUNC('month', sale_date) AS kuu,
        SUM(total_price) AS käive
    FROM sales
    WHERE sale_date >= '2024-01-01'
      AND sale_date < '2025-01-01'
    GROUP BY DATE_TRUNC('month', sale_date)
)

SELECT
    kuu,
    käive,
    LAG(käive) OVER (ORDER BY kuu) AS eelmine_kuu,
    käive - LAG(käive) OVER (ORDER BY kuu) AS muutus,
    ROUND(
        (käive - LAG(käive) OVER (ORDER BY kuu))
        / LAG(käive) OVER (ORDER BY kuu) * 100,
        1
    ) AS kasvu_protsent
FROM kuu_myyk
ORDER BY kuu;