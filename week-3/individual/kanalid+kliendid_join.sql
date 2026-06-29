-- Nädal 3: müügikanalid ja kliendid (INNER JOIN + mitme tabeli JOIN)
-- Tabelid: sales, customers, products

-- Vaata, millised müügikanalid on olemas.
SELECT DISTINCT channel
FROM sales
ORDER BY channel;
-- Müügikanalid on pood ja online.

-- Milline kanal toob enim müüke?
SELECT s.channel AS müügikanal,
       COUNT(DISTINCT s.customer_id) AS kliente,
       COUNT(s.sale_id) AS oste,
       SUM(s.total_price) AS kogumüük
FROM sales s
GROUP BY s.channel
ORDER BY kogumüük DESC;
-- Pood on toonud müüki 1,9 miljonit ja online-kanal 1 miljon eurot.

-- Millistest linnadest kliendid eri kanaleid kasutavad?
SELECT s.channel AS müügikanal,
       c.city AS linn,
       COUNT(DISTINCT c.customer_id) AS kliente,
       SUM(s.total_price) AS kogumüük
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
GROUP BY s.channel, c.city
ORDER BY müügikanal, kogumüük DESC;
-- Mõlema kanali esikolmik on Tallinn, Tartu ja Pärnu.

-- Kolme tabeli JOIN: millised tootekategooriad müüvad eri kanalites?
SELECT s.channel AS müügikanal,
       p.category AS tootekategooria,
       COUNT(DISTINCT c.customer_id) AS kliente,
       COUNT(s.sale_id) AS oste,
       SUM(s.total_price) AS kogumüük,
       ROUND(AVG(s.total_price), 2) AS keskmine_ost
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
INNER JOIN products p ON s.product_id = p.product_id
GROUP BY s.channel, p.category
ORDER BY müügikanal, kogumüük DESC;
-- Online'is müüvad kõige paremini jalanõud ja kõige vähem lasteriided.
-- Poes müüvad kõige paremini meesteriided ja kõige vähem samuti lasteriided.

-- Leia kõige efektiivsem kanal müügi järgi kliendi kohta.
SELECT s.channel AS müügikanal,
       COUNT(DISTINCT s.customer_id) AS kliente,
       SUM(s.total_price) AS kogumüük,
       ROUND(SUM(s.total_price) / COUNT(DISTINCT s.customer_id), 2) AS müük_per_klient
FROM sales s
GROUP BY s.channel
ORDER BY müük_per_klient DESC;
-- Müük kliendi kohta on poes 835 ja online-kanalis 590 eurot.

-- Võrdle kaupluste müügikanalite jaotust.
SELECT s.store_location AS kauplus,
       s.channel AS müügikanal,
       COUNT(s.sale_id) AS oste,
       SUM(s.total_price) AS kogumüük,
       ROUND(SUM(s.total_price) / COUNT(s.sale_id), 2) AS keskmine_ost
FROM sales s
GROUP BY s.store_location, s.channel
ORDER BY kauplus, kogumüük DESC;
-- Keskmine ost on mõlemas kanalis ligikaudu 285 eurot.
-- Tallinna poe kogumüük on ligikaudu sama suur kui kogu online-kanali müük.
