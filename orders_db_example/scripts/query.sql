SELECT Orders.orderNumber, Orders.orderDate, SUM(quantityOrdered) AS num_prodotti,
SUM(quantityOrdered*priceEach) AS importo_totale
FROM Orders 
JOIN OrderDetails ON Orders.orderNumber= OrderDetails.orderNumber
GROUP BY Orders.orderNumber, Orders.orderDate
LIMIT 2;

/* raggruppamento per stato con totalizzazioni importi*/

SELECT status, SUM(quantityOrdered*priceEach) AS importo_totale
FROM Orders 
JOIN OrderDetails ON Orders.orderNumber= OrderDetails.orderNumber
GROUP BY status;

SELECT DISTINCT productLine
FROM Products;
/* ne vedo una sola */
ordine>dettagli>articolo
sommatoria importi per ogni productLine

SELECT Products.productName, count(*) as num_tot,
SUM(quantityOrdered*priceEach) importoVenduto,
Products.productLine
FROM Products
JOIN OrderDetails ON Products.productCode=OrderDetails.productCode
GROUP BY Products.productLine /*per righe doppie*/
ORDER BY num_tot; /*su Sum avg etccc*/

// il join si fa solo con le righe e gli articoli che sono sugli ordini

/*raggruppo per status e product line e la somma del venduto */

SELECT status, productLine ,SUM(quantityOrdered*priceEach) AS importo_totale
FROM Products
JOIN OrderDetails ON Products.productCode=OrderDetails.productCode
JOIN Orders ON orderdetails.orderNumber=Orders.orderNumber
GROUP BY status, productLine 
ORDER BY importo_totale; 

/*senza year mi mette tutti i singoli giorni quanto ho venduto*/
SELECT YEAR(Orders.orderDate), MONTH(Orders.orderDate), SUM(quantityOrdered*priceEach) AS TOTALE_VENDUTO
FROM Orders
JOIN OrderDetails ON Orders.orderNumber = OrderDetails.orderNumber
WHERE MONTH(Orders.orderDate) IN (2, 3)
GROUP BY YEAR(Orders.orderDate), MONTH(Orders.orderDate)
HAVING TOTALE_VENDUTO > 20000
ORDER BY YEAR(Orders.orderDate);
/*esiste pure month*/

SELECT*
FROM OrderDetails
WHERE orderNumber=(
    /*selezione dove orderNumber è il valore + piccolo*/
    SELECT MIN(OrderNumber)
    FROM orderdetails
)
ORDER BY OrderNumber