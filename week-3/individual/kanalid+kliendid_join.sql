--w3 grupitöö Müügikanalid + Kliendid (INNER JOIN + mitme tabeli JOIN)
--Mitme tabeli JOIN: millised müügikanalid toovad enim müüke ja millised kliendid kasutavad milliseid kanaleid? Koosta müügikanalite analüüs Annale.
Tabelid: sales, customers, products

 -- Vaata, millised müügikanalid on olemas    
 SELECT DISTINCT channel FROM sales ORDER BY channel;    
 -- Märgi üles: mitu erinevat kanalit on?    `Müügikanalid on pood ja online

 -- Milline kanal toob enim müüke?    
 SELECT  s.channel AS müügikanal,        
 COUNT(DISTINCT s.customer_id) AS kliente,        
 COUNT(s.sale_id) AS oste,        
 SUM(s.total_price) AS kogumüük    
 FROM sales s    
 GROUP BY s.channel    
 ORDER BY kogumüük DESC; 
 --Pood on toonud müüke 1.9 mlj ja online 1 mlj

  -- Millistest linnadest kliendid milliseid kanaleid kasutavad?    
  SELECT s.channel AS müügikanal, c.city AS linn,        
  COUNT(DISTINCT c.customer_id) AS kliente,        
  SUM(s.total_price) AS kogumüük    
  FROM sales s INNER JOIN customers c ON s.customer_id = c.customer_id    
  GROUP BY s.channel, c.city    
  ORDER BY müügikanal, kogumüük DESC; 
  --Kõikide linnade kliendid kasutavad nii online kanalit kui poodi, esikolmik mõlemas kategoorias Tallinn (online oste 667 summas 335719 , poe oste 910 summas 670533), Tartu, Pärnu

  --Ühenda 3 tabelit: `sales` + `customers` + `products`:
   -- 3 tabeli JOIN: millised tooted müüvad millises kanalis?    
   SELECT        s.channel AS müügikanal,        p.category AS tootekategooria,        
   COUNT(DISTINCT c.customer_id) AS kliente,        
   COUNT(s.sale_id) AS oste,        
   SUM(s.total_price) AS kogumüük,        
   ROUND(AVG(s.total_price), 2) AS keskmine_ost    
   FROM sales s    INNER JOIN customers c ON s.customer_id = c.customer_id    INNER JOIN products p ON s.product_id = p.product_id    
   GROUP BY s.channel, p.category    
   ORDER BY müügikanal, kogumüük DESC; 
   --Online müüvad kõige paremini jalanõud ja kõige kehvemini lasteriided, poes müüvad kõige paremini meesteriided ja 
   kõige kehvemini samuti lasteriided

    --Leia kõige efektiivsem kanal (müük per klient):
SELECT        s.channel AS müügikanal,        
COUNT(DISTINCT s.customer_id) AS kliente,        
SUM(s.total_price) AS kogumüük,        
ROUND(SUM(s.total_price) / COUNT(DISTINCT s.customer_id), 2) AS müük_per_klient    
FROM sales s    
GROUP BY s.channel    
ORDER BY müük_per_klient DESC;  
--Kõige efektiivsem kanal kliendi kohta on pood summas 835, online müük kliendi kohta 590, kogumüük/kliendid

--Lisa kaupluste võrdlus: leia iga kaupluse müügikanalite jaotus

  SELECT       s.store_location AS kauplus,       s.channel AS müügikanal,       
  COUNT(s.sale_id) AS oste,       
  SUM(s.total_price) AS kogumüük,       
  ROUND(SUM(s.total_price) / COUNT(s.sale_id), 2) AS keskmine_ost   
  FROM sales s   
  GROUP BY s.store_location, s.channel   
  ORDER BY kauplus, kogumüük DESC;
--Üks ost keskmiselt 285 eurot igas kanalis, kogumüük/ostud
--Tallinna pood üksi müüb sama palju kui online

