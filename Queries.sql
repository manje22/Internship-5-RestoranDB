--Ispis svih jela koja imaju cijenu manju od 15 eura.
SELECT name FROM FOOD WHERE price < 15

--Ispis svih narudžbi iz 2023. godine koje imaju ukupnu vrijednost veću od 50 eura.
SELECT * FROM ORDERS WHERE(
	EXTRACT(YEAR FROM dateoforder) = 2023 AND
	total > 50.00
)

--Ispis svih dostavljača s više od 100 uspješno izvršenih dostava do danas.

SELECT e.employeeid,
	e.name,
	COUNT(D.ORDERID)
FROM employee e
JOIN DELIVERIES D ON E.EMPLOYEEID = D.EMPLOYEEID
GROUP BY E.EMPLOYEEID, E.NAME

--Ispis svih kuhara koji rade u restoranima u Zagrebu.
SELECT e.name,
       c.name,
	   e.jobid
FROM employee e
JOIN city c ON e.cityid = c.cityid
WHERE c.cityid = 2 and e.jobid = 1;

--Ispis broja narudžbi za svaki restoran u Splitu tijekom 2023. godine.
SELECT count(o.orderid) as num_orders,
	r.name as restaurant_name
FROM ORDERS O
JOIN RESTAURANT R ON O.RESTAURANTID = R.RESTAURANTID
JOIN CITY C ON R.CITYID = C.CITYID
WHERE R.CITYID = 1
GROUP BY R.RESTAURANTID

--Ispis svih jela u kategoriji "Deserti" koja su naručena više od 10 puta u prosincu 2023.
SELECT F.NAME AS ITEM,
	COUNT(O.ORDERID) AS NUM_TIMES
	FROM FOOD F
JOIN ORDER_ITEMS O ON F.FOODID = O.FOODID
JOIN ORDERS D ON O.ORDERID = D.ORDERID
WHERE D.DATEOFORDER BETWEEN '2023-12-01' AND '2023-12-31' AND F.FOODCATEGORYID = 3
GROUP BY F.NAME
HAVING COUNT(O.ORDERID) > 10
