/*

NAME: Florence
DATE: 08/2017 Description: Please run your queries against the Adventureworks database
			 Please ensure that your query runs and you validated the result
*/


/*QUESTION 1  
Write a query to return the customer ID from Sales.SalesOrderHeader table
*/

SELECT CUSTOMERID
FROM SALES.SALESORDERHEADER

/*QUESTION 2 
Using your response from question 1, add a derived column called
CustCount that will count the occurrence of the customer ID
*/

--JP SOLUTION
SELECT CustomerID, COUNT(CustomerID) AS CustCount 
FROM Sales.SalesOrderHeader 
GROUP BY CustomerID

--OR
SELECT CustomerID, COUNT(*) AS CustCount 
FROM Sales.SalesOrderHeader 
GROUP BY CustomerID

/*QUESTION 3
Using your answer from question 2, only return the customer ID
that appears more than once.
*/

SELECT 
	CustomerID, 
	COUNT(*) AS CustCount 
FROM Sales.SalesOrderHeader 
GROUP BY CustomerID
HAVING COUNT(*) > 1

--OR 
SELECT 
	CustomerID, 
	COUNT(CustomerID) AS CustCount 
FROM Sales.SalesOrderHeader 
GROUP BY CustomerID
HAVING COUNT(CustomerID) > 1

/*QUESTION 4 
			THE DERIVED COLUMN BUT TRY TO NAME THE COLUMN FOR BETTER DESCRIPTION
			TO THE BUSINESS
Write a query to retrieve the highest tax amount from the Sales.SalesOrderHeader 
table.
*/

SELECT MAX(TAXAMT)
FROM SALES.SALESORDERHEADER

/*QUESTION 5 
Write a query that will return the latest ship date from the
Sales.SalesOrderHeader table.
*/

SELECT MAX(SHIPDATE)
FROM SALES.SALESORDERHEADER

/*QUESTION 6 
Using your answer from question 5, add the customer ID that
have those ship date.
*/

SELECT MAX(SHIPDATE), CUSTOMERID
FROM SALES.SALESORDERHEADER
GROUP BY CUSTOMERID

/*QUESTION 7 
Write a query that will extr act the first two characters from the 
Purchase Order Number on the Sales.SalesOrderHeader table.
Example for a Purchase Order Number or PO18386167654 return PO.
*/

SELECT 
      PurchaseOrderNumber, 
	  SUBSTRING(PurchaseOrderNumber,1,2) AS First2 
FROM Sales.SalesOrderHeader 


/*QUESTION 8 
Write a query that will display the order Date, Due date, ship data, online order flag,
account number, customer ID, and tax amount from the Sales.SalesOrderHeader table.
*/

SELECT ORDERDATE, DUEDATE, SHIPDATE, ONLINEORDERFLAG,
ACCOUNTNUMBER, CUSTOMERID, TAXAMT
FROM SALES.SALESORDERHEADER


/*QUESTION 9
Due to confusion on the way the online order flag was reported,
you have been asked to modify the result from question 8.
Add a derived column called OrderStatus, and this column should
contain the following information.
If the online order flag is 0 display "In-Store" and if the 
online order flag is 1 display "Online."
*/

SELECT
	ACCOUNTNUMBER, 
	CUSTOMERID, 
	TAXAMT,
	ONLINEORDERFLAG,
	CASE
		WHEN ONLINEORDERFLAG = 0 THEN 'IN-STORE'
		WHEN ONLINEORDERFLAG = 1 THEN 'ONLINE'
	END AS DERIVEDORDERSTATUS
FROM SALES.SALESORDERHEADER



/*QUESTION 10 
The maximum Line total from the 
[Sales].[SalesOrderDetail]
*/

SELECT MAX (LINETOTAL)
FROM SALES.SALESORDERDETAIL

/*QUESTION 11  
Return the job title, birthdate, gender, and vacation hours, sick leave hours.
Add a derived column called FlagCheck that meets the below condition
If the salaried Flag is 1, then Employee else contractor.
*/

SELECT 
JOBTITLE, BIRTHDATE, GENDER, VACATIONHOURS, 
SICKLEAVEHOURS, SALARIEDFLAG,
CASE 
WHEN SALARIEDFLAG = 1 THEN 'EMPLOYEE'
ELSE 'CONTRACTOR'
END AS DERIVEDFLAGCHECK
FROM HUMANRESOURCES.EMPLOYEE



/*QUESTION 12 
Using answer from question 11 create a derived column VacationCheck
 that meets the condition below:
If Marital status is M AND Vacation hours  grater than 40 and sick 
leave hours grater 
than 60 then return "Approved" else every other thing should say considered.
*/

SELECT 
	JOBTITLE, 
	BIRTHDATE, 
	GENDER, 
	VACATIONHOURS, 
	MARITALSTATUS
	SICKLEAVEHOURS, 
	SALARIEDFLAG, 
	CASE 
		WHEN MARITALSTATUS = 'M' AND VACATIONHOURS >40 AND SICKLEAVEHOURS >60 THEN 'APPROVED'
		ELSE 'CONSIDERED'
	END AS DERIVEDVACATIONCHECK
FROM HUMANRESOURCES.EMPLOYEE

/*QUESTION 13 
Please return the top 6 currency from the [Sales].[Currency]
*/

SELECT TOP (6) CURRENCYCODE, NAME, MODIFIEDDATE
FROM SALES.CURRENCY


/* QUESTION 14 
Return the [Category],[StartDate],[EndDate],[MinQty],[MaxQty]
[Sales].[SpecialOffer] where the category is a reseller and the minimum quantity
is greater than or equal to 0 and maximum quantity is KNOWN
*/

SELECT 
	CATEGORY, 
	STARTDATE, 
	ENDDATE, 
	MINQTY, 
	MAXQTY
FROM SALES.SPECIALOFFER
WHERE CATEGORY = 'Reseller' AND MINQTY >= 0 AND MAXQTY  IS NOT NULL



/*QUESTION 15 
The monthly report for your company is due, and your manager wants
you to write a query against the [Sales].[Customer] that
returns count of the StoreID's that are less than 2.
*/

SELECT 
	COUNT(StoreID) AS StoreIDCount, 
	StoreID  
FROM Sales.Customer  
GROUP BY StoreID 
HAVING COUNT(StoreID) <2


/*QUESTION 16 
Calculate total sum of [UnitPrice] against the UnitPrice
*/

SELECT SUM (UnitPrice), UnitPrice   
FROM Sales.SalesOrderDetail 
GROUP BY UnitPrice

/*QUESTION 17 
Return the [FirstName] [MiddleName] and [LastName] from the Person.Person table
but limit your result to only employees whose middle names are UNKNOWN
*/

SELECT FIRSTNAME, LASTNAME,
MIDDLENAME
FROM PERSON.PERSON
WHERE MIDDLENAME  IS NULL
      
   
/*QUESTION 18 
Write a query to return the count of each [SalesOrderID]
from the [Sales].[SalesOrderDetail]
*/


SELECT 
	COUNT(SalesOrderID) AS CountSalesOrderID, 
	SalesOrderID  
FROM Sales.SalesOrderDetail 
GROUP BY SalesOrderID


/*QUESTION 19 
Using you answer question 18, please return
the [SalesOrderID] that is less than 2
*/

SELECT COUNT (*), SALESORDERID
FROM SALES.SALESORDERDETAIL
GROUP BY SALESORDERID
HAVING SALESORDERID < 2 
  
/*QUESTION 20 
Write a SQL query that will generate datasets that 
display the first name, last name, and a 
derived column called FirstThree that will show the first three characters of 
the first name from the person.Person table.
*/

SELECT LASTNAME, 
FIRSTNAME, 
SUBSTRING (FIRSTNAME, 1,3) AS FIRSTTHREE
FROM PERSON.PERSON

/* QUESTION 21
Write a SQL query that will generate datasets that display's the 
[JobTitle],[BirthDate],[HireDate].
Write derived columns
Write derived column name statusCheck to display the following
	If the marital status is "S" the return "single"
	if the marital status is "M", then return "Married" 
	from the humanresource.Employee
*/


SELECT *
FROM HUMANRESOURCES.EMPLOYEE

SELECT JOBTITLE, BIRTHDATE, HIREDATE, 
       MARITALSTATUS,
CASE
WHEN MARITALSTATUS = 'S' THEN 'SINGLE'
WHEN MARITALSTATUS = 'M' THEN 'MARRIED'
END AS DERIVEDCOLUMNSTATUSCHECK
FROM HUMANRESOURCES.EMPLOYEE


/*QUESTION 22 
Write a SQL query that will display the first name and last name from the 
Person.Person table
*/

SELECT FIRSTNAME, LASTNAME
FROM PERSON.PERSON

/*QUESTION 23 
Using the answer from question 22, 
add a derived column called full name. this derived column
 should hold the combination of the last name and first name
*/

SELECT FIRSTNAME, LASTNAME,
FIRSTNAME + LASTNAME AS [FULL NAME]
FROM PERSON.PERSON


/*QUESTION 24 CORRECT, TRY MAKING THE DATASET LOOK NICE 
Using your result from question 23, your manager will like you to have a 
delimiter on the full name the delimiter should be a dash so meaning every full name should 
have a dash (-) in between the last name and first name
*/

SELECT FIRSTNAME, LASTNAME,
FIRSTNAME+ ' '+ LASTNAME AS [FULL NAME],
CONCAT (FIRSTNAME, ' -', LASTNAME) AS FULLNAMES
FROM PERSON.PERSON


/*QUESTION 25 
Write a query against SalesOrderHeader to generate a dataset that will return
the three-ship countries with the highest average freight 
*/

SELECT *
FROM SALES.SALESORDERHEADER

SELECT TOP (3) FREIGHT, AVG (FREIGHT)
FROM SALES.SALESORDERHEADER
GROUP BY FREIGHT 

/*QUESTION 26 
Your company is about to send information to employees who may be losing their vacation hours due
to the end-of-year cut of vacation hours. You have been a task to generate a dataset against 
the employee's table to display the job title, marital status, gender, vacation hours, and sick leave.
*/


SELECT JOBTITLE, MARITALSTATUS, GENDER,
VACATIONHOURS, SICKLEAVEHOURS
FROM HUMANRESOURCES.EMPLOYEE

/*QUESTION 27 
Using your dataset from Question 26, the business will like you to add a derived column called 
VacHoursCheck this column should have the below information
	1. If the vacation hours is greater than 70, display "Send Email"
	2. If the vacation hours are less than or equal to 70, display "Safe"
*/


SELECT JOBTITLE, MARITALSTATUS, GENDER, SICKLEAVEHOURS,
VACATIONHOURS, 
CASE
WHEN VACATIONHOURS > 70 THEN 'SENDEMAIL'
WHEN VACATIONHOURS <= 70 THEN 'SAFE'
END AS DERIVEDCOLUMNVACHOURSCHECK
FROM HUMANRESOURCES.EMPLOYEE



/*QUESTION 28
Using your dataset from question 27, the business will like you to add another derived column called.
MaxReached?. This column should have the following information.
	1. If the sum of the vacation hours and the sick leave hours is greater than 150, then display "Yes"
	2. If the sum of the vacation hours and the sick leave hours is less than 150 but greater than
		70 return "No"
Anything else should return NULL.  
*/


SELECT 
	JOBTITLE, 
	MARITALSTATUS, 
	GENDER, 
	SICKLEAVEHOURS,
	VACATIONHOURS, 
	CASE
		WHEN VACATIONHOURS + SICKLEAVEHOURS > 150 THEN 'YES'
		WHEN VACATIONHOURS + SICKLEAVEHOURS < 150 OR VacationHours > 70 THEN 'NO'
	ELSE NULL
END AS DERIVEDCOLUMNMAXREACHED
FROM HUMANRESOURCES.EMPLOYEE


/*QUESTION 29 
Write a query against the product table that will display the product name, the product name and color
from the production.product table.
*/

SELECT NAME, COLOR
FROM PRODUCTION.PRODUCT

/*QUESTION 30 
Your manager just reviewed your report on question 14, and he is concerned about the NULL values he saw on the
color column. You have been a task to write a derived column called AddColorInfo. The AddColorInfo column should
replace all the NULL's on the color column to read "unknown" so it will be easy to present to the business.
*/

SELECT NAME, COLOR,
CASE
WHEN COLOR IS NULL THEN 'UNKNOWN'
ELSE COLOR
END AS ADDCOLORINFO
FROM PRODUCTION.PRODUCT





/*QUESTION 31 
Write a query against the SalesOrderDetail that will return duplicate product ID
*/

SELECT COUNT(PRODUCTID), PRODUCTID
FROM SALES.SALESORDERDETAIL
GROUP BY PRODUCTID
HAVING COUNT(PRODUCTID) > 1

/*QUESTION 32 
Write a query against the Employee table to display the job title, birth date, and marital status.
Also, add a derived column called FirstWord. This column should hold the first word of the job title.
For example, when the job title is "Chief Executive Officer," we should see "Chief",
		when the job title is "Vice President of Engineering," we should see "Vice," and when the
		the job title is "Engineering Manager" we should see "Engineering" etc
NOTE: We have not learned this skill set in this class, but that will be cool if you can break it.
		it is not a CASE statement problem but try your best
*/
	
SELECT JobTitle, BirthDate, MaritalStatus, 
       CHARINDEX(' ', JobTitle),
	   SUBSTRING(JobTitle,1, CHARINDEX(' ', JobTitle)) AS FirstWord
FROM HumanResources.Employee 
