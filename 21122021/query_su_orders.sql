select status, count(*) as conteggio
FROM orders group by status 
ORDER BY count(*) desc;

select YEAR(orderDate), status, count(*) as conteggio
FROM orders 
group by YEAR(orderDate), status 
ORDER BY conteggio desc;

/* ORDINI CON IMPORTO TOTALE DELL'ORDINE */
select orders.ordernumber, orders.orderdate, SUM(quantityOrdered) AS num_prodotti, 
            SUM(quantityOrdered * priceEach) AS importo_totale
from orders
JOIN orderdetails ON orders.ordernumber = orderdetails.ordernumber
GROUP BY orders.ordernumber, orders.orderdate
LIMIT 2;

/* Raggruppamento per stato con totalizzazione impori */
SELECT status, SUM(quantityOrdered * priceEach) AS importo_totale
FROM orders
JOIN orderdetails ON orders.ordernumber = orderdetails.ordernumber
GROUP BY status;


SELECT products.productLine, SUM(quantityOrdered * priceEach) AS TOTALEVENDUTO
FROM products 
JOIN orderdetails ON Products.productCODE = orderdetails.productCode
JOIN orders ON orders.ordernumber = orderdetails.ordernumber
group by products.productline
ORDER BY productLine;



SELECT products.productLine, orders.status, SUM(quantityOrdered * priceEach) AS TOTALEVENDUTO
FROM products 
JOIN orderdetails ON Products.productCODE = orderdetails.productCode
JOIN orders ON orders.ordernumber = orderdetails.ordernumber
group by products.productline, orders.status
ORDER BY products.productLine, orders.status;


/* Venduto per singolo anno */
SELECT YEAR(orders.orderDate), SUM(quantityOrdered * priceEach) AS TOTALEVENDUTO
FROM orders
JOIN orderdetails ON orders.ordernumber = orderdetails.ordernumber
GROUP BY YEAR(orders.orderDate)
ORDER BY YEAR(orders.orderDate);

/* Venduto per singolo mese */
SELECT YEAR(orders.orderDate), MONTH(orders.orderDate), SUM(quantityOrdered * priceEach) AS TOTALEVENDUTO
FROM orders
JOIN orderdetails ON orders.ordernumber = orderdetails.ordernumber
WHERE MONTH(orders.orderDate) IN(2, 3)  /* (MONTH(orders.orderDate) = 2 or MONTH(orders.orderDate) = 3) */
GROUP BY YEAR(orders.orderDate), MONTH(orders.orderDate)
HAVING TOTALEVENDUTO > 200000
ORDER BY SUM(quantityOrdered * priceEach) DESC;


/* Le righe dell'ordine con il minore orderNumber */
SELECT *
FROM orderdetails 
WHERE orderNumber = (
    SELECT MAX(orderNumber) FROM orderdetails
)
ORDER BY orderNumber;



/* L'ordine piu' piccolo */
SELECT MIN(orderNumber)
FROM orderdetails;