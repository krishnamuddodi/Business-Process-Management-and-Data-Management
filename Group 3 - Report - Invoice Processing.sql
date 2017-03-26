--1.	Report to show expenditures and purchase_order description for each quarter of a given year for the respective departments.

--    This reports helps in showing the amount spent across quarters.

SELECT PO_NUMBER, PO_DESC AS "PURCHASE ORDERS DESC",DEPARTMENT_NAME, QUARTER,YEAR,AMOUNT AS "EXPENDITURES"
FROM
  (SELECT PO.PO_NUMBER,PO.PO_DESC,D.DEPARTMENT_NAME,
    I.INVOICE_ID,
    TO_CHAR(I.PAID_DATE,'YYYY')AS YEAR,
    TO_CHAR(I.PAID_DATE,'Q')AS QUARTER,
    I.AMOUNT
  FROM PURCHASE_ORDER PO
  JOIN INVOICE I
  ON I.INVOICE_ID = PO.INVOICE_ID
  JOIN INVOICE_APPROVAL IA ON
  I.INVOICE_ID = IA.INVOICE_ID
  JOIN DEPT D ON
  IA.DEPARTMENT_ID = D.DEPARTMENT_ID
  )
WHERE YEAR = 2014  
GROUP BY PO_NUMBER, PO_DESC,DEPARTMENT_NAME,QUARTER,YEAR,AMOUNT
ORDER BY QUARTER;


--2.	Report to fetch the Invoice information along with the Purchase_orders details

--    This report helps in getting all the details related to Purchase Orders and Invoice Information 

SELECT S.SUPPLIER_ID,I.INVOICE_ID,I.RECEIVED_DATE,I.PAID_DATE,
TO_CHAR(I.AMOUNT,'$999,999.0')AS AMOUNT ,P.PO_NUMBER,P.PO_DESC
FROM SUPPLIER S 
JOIN INVOICE I 
ON S.SUPPLIER_ID = I.SUPPLIER_ID
JOIN PURCHASE_ORDER P 
ON I.INVOICE_ID = P.INVOICE_ID
WHERE S.SUPPLIER_ID = 'SUP001';


--3.	Report to fetch approval process status based on the invoice ID.

--    This report helps in gathering the details of which key players have approved the invoice of interest for payment thus far.  This is a quick visual of where the invoice is in the workflow as well as when it may have been paid and the total amount paid to the supplier.


SELECT A.INVOICE_ID,C.DEPARTMENT_NAME,A.IPT_APPROVAL,A.CAM_APPROVAL,A.FIN_APPROVAL,A.PD_APPROVAL,B.PAID_DATE,B.AMOUNT
FROM INVOICE_APPROVAL A JOIN INVOICE B
ON A.INVOICE_ID = B.INVOICE_ID
JOIN DEPT C ON
A.DEPARTMENT_ID = C.DEPARTMENT_ID;


--4.   Report to track number of purchase orders supplier received that can be inputted by users.

SELECT S.SUPPLIER_ID, S.SUPPLIER_NAME, COUNT(PO.SUPPLIER_ID) AS "Num of orders with suppliers"
FROM SUPPLIER S JOIN PURCHASE_ORDER PO ON
S.SUPPLIER_ID = PO.SUPPLIER_ID
WHERE S.SUPPLIER_ID = UPPER('&SUPPLIER_ID')
GROUP BY S.SUPPLIER_ID,S.SUPPLIER_NAME
ORDER BY S.SUPPLIER_ID;


--5.	Report to show purchase order related to each department.

SELECT PO.PO_NUMBER, D.DEPARTMENT_NAME
FROM DEPT D JOIN INVOICE_APPROVAL IA
ON D.DEPARTMENT_ID = IA.DEPARTMENT_ID
JOIN INVOICE I ON
IA.INVOICE_ID = I.INVOICE_ID
JOIN PURCHASE_ORDER PO ON
I.INVOICE_ID =PO.INVOICE_ID;



 



 


 

 





 


