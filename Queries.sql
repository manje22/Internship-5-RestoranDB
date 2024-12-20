--Ispis svih jela koja imaju cijenu manju od 15 eura.
SELECT name FROM FOOD WHERE price < 15

--Ispis svih narudžbi iz 2023. godine koje imaju ukupnu vrijednost veću od 50 eura.
SELECT * FROM ORDERS O WHERE
O.DATEOFORDER BETWEEN '01.01.2023' AND '12.31.2023' AND O.TOTAL>50

--Ispis svih dostavljača s više od 100 uspješno izvršenih dostava do danas.

SELECT e.employeeid,
	e.name,
	COUNT(D.ORDERID)
FROM employee e
JOIN DELIVERIES D ON E.EMPLOYEEID = D.EMPLOYEEID
GROUP BY E.EMPLOYEEID, E.NAME
HAVING COUNT(D.ORDERID) > 100

SELECT * FROM JOB
SELECT * FROM EMPLOYEE WHERE JOBID = 2

SELECT D.ORDERID FROM DELIVERIES D
JOIN ORDERS O ON D.ORDERID = O.ORDERID
WHERE (CURRENT_DATE- O.DATEOFORDER)/365 = 4 OR (CURRENT_DATE- O.DATEOFORDER)/365 = 5

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

--Ispis broja narudžbi korisnika s prezimenom koje počinje na "M".
SELECT COUNT(O.ORDERID)
FROM ORDERS O
JOIN CUSTOMER C ON O.CUSTOMERID = C.CUSTOMERID
WHERE C.FIRSTNAME LIKE 'M%'


--Ispis prosječne ocjene za restorane u Rijeci.
SELECT FLOOR(AVG(DR.REVIEW)), R.NAME, C.CITYID
FROM DELIVERY_REVIEW DR
JOIN ORDERS O ON DR.ORDERID = O.ORDERID
JOIN RESTAURANT R ON O.RESTAURANTID = R.RESTAURANTID
JOIN CITY C ON R.CITYID = C.CITYID
WHERE C.NAME LIKE 'Rijeka'
GROUP BY R.NAME, C.CITYID


--Ispis svih restorana koji imaju kapacitet veći od 30 stolova i nude dostavu.
SELECT NAME, CAPACITY, HAS_DELIVERY
FROM RESTAURANT
WHERE CAPACITY> 30 AND HAS_DELIVERY = TRUE



--Uklonite iz jelovnika jela koja nisu naručena u posljednje 2 godine.
DELETE
FROM FOOD F
WHERE
	NOT EXISTS(
		SELECT 1
		FROM ORDER_ITEMS OT
		JOIN ORDERS O ON OT.ORDERID = O.ORDERID
		WHERE OT.FOODID = F.FOODID
		AND (CURRENT_DATE - O.DATEOFORDER)/365 <= 2
	)

--Izbrišite loyalty kartice svih korisnika koji nisu naručili nijedno jelo u posljednjih godinu dana.


UPDATE CUSTOMER
SET HASLOYALTY = FALSE
WHERE CUSTOMERID IN(
	SELECT C.CUSTOMERID
	FROM CUSTOMER C
	WHERE
		NOT EXISTS(
			SELECT 1
			FROM ORDERS O
			WHERE O.CUSTOMERID = C.CUSTOMERID
				AND (CURRENT_DATE - O.DATEOFORDER)/365 <= 1
	)
)


SELECT * FROM ORDERS WHERE TOTAL = 1