/*

Florence
DATE: 2019

Description: Please run your queries against the Adventureworks database
			 Please ensure that your query runs and you validated the result
*/


/* QUESTION 1 
Write a SQL query to return the name, product number, color and modified date from the 
production.product table.
*/

SELECT [NAME], PRODUCTNUMBER, COLOR, MODIFIEDDATE
FROM PRODUCTION.PRODUCT


/* QUESTION 2
Using you result from question 1, the business will like to know the unit price and the line total
of this product. Using the Sales.SalesOrderDetail please include the unit price and the line total to
the result set

*/

SELECT NAME, PP.PRODUCTID,PRODUCTNUMBER, COLOR, pp. ModifiedDate,
			 UNITPRICE, LINETOTAL
FROM SALES.SALESORDERDETAIL AS SSD
INNER JOIN PRODUCTION.PRODUCT AS PP
ON SSD. PRODUCTID = PP.PRODUCTID

/* QUESTION 3 
Write a query that will retrieve ProductID,Name,ReorderPoint, StandardCost from the products table.  
Sort the result by the ReorderPoint from lowest to highest then by  StandardCost from highest to lowest 

*/

SELECT PRODUCTID, [NAME], REORDERPOINT, STANDARDCOST
FROM PRODUCTION.PRODUCT
ORDER BY REORDERPOINT ASC,STANDARDCOST DESC

/* QUESTION 4 
 Write a query to reture all the records from the Sales.SalesOrderDetail table that has a 
 linetotal that is greater than 2100
*/

SELECT *
FROM SALES.SALESORDERDETAIL
WHERE LINETOTAL > 2100


/* QUESTION 5 
Write a query to provide a list of store names serviced  by salespersonIDs
277,280 and 286 from the Sales.store table
*/

SELECT [NAME], BusinessEntityID, SalesPersonID
FROM SALES.STORE
WHERE SALESPERSONID IN (277, 280, 286)


/* QUESTION 6 
Provide a list the productID, BusinessEntityID, AverageLeadTime and StandardPrice 
where the AverageLeadTime is greater than 20 or the StandardPrice is less than 10 

*/
SELECT PRODUCTID, BUSINESSENTITYID, AVERAGELEADTIME, STANDARDPRICE
FROM PURCHASING.PRODUCTVENDOR
WHERE AVERAGELEADTIME > 20 or STANDARDPRICE < 10

/* QUESTION 7 
Write a query that will provide the productID that is the least purchased from Sales.salesorderdetail.
HINT: Group By , SUM(), order By , TOP, TIES

*/

SELECT MIN (OrderQty), productid
FROM  SALES.SALESORDERDETAIL
group by productid



/* QUESTION 8 
Write a query to provide a list of orders that were placed between 2011 and 2012 from the Sales.SalesOrderHeader table
 Between , where, Optional function YEAR() to get the year.
 
*/
SELECT SalesOrderID, YEAR (OrderDate) orderyear, SalesOrderNumber
FROM SALES.SALESORDERHEADER
WHERE  YEAR (ORDERDATE) BETWEEN  2011 AND 2012


/* QUESTION 10 
Write a query to provide a list of customers that have placed more than 10 orders from the Sales.salesorderheader table
HINT: GROUP BY, COUNT(), HAVING and CUSTOMERID

*/

select customerid, 
	count (SalesOrderID) salescount
	from sales.salesorderheader
	group by customerid
	having count (SalesOrderID) > 10

/* QUESTION 11 
The human resource team have approached your team to generate a report of all employees and if they 
are salaried or not on the report you need to display the following:
    If employee salariedFlag is 1, then display 'Exempt' else display 'Non-Exempt' . 
	call the derived column EmployeeExemptStatus using the HumanResources.Employee
    HINT : CASE
*/
select jobtitle, salariedflag,
case
when salariedflag =1 then 'excempt'
else 'non exempt'
end as employeeexemptstatus
from HumanResources.Employee

/* QUESTION 12 
After the successful report from question 11, HR now wants additional information to be added to the report.
HR will like you to add a derived column called Payout; this column should add the total sum of PTO hours each employee has.
PTO hours are the sum of the vacation hours and sick leave Hours
On the report, you need to display the following:
    If an employee's PTO hours are greater than 40 hours, display 'Excess Payout.'
	If an employee's PTO hours are greater = 40 hours, display 'Regular Payout'
	 else display 'No payout.' 
*/
select jobtitle, salariedflag, vacationhours, sickleavehours,
case
when salariedflag =1 then 'excempt'
else 'non exempt'
end as employeeexemptstatus,
case
when vacationhours + sickleavehours  <40 then 'excess payout'
when vacationhours + sickleavehours <= 40 then 'regular payout'
else 'no payout'
end as payout
from HumanResources.Employee


/* QUESTION 13 
Write a query to return a list of first name, last name and  phone numbers
Please note that all records need to have phone numbers
HINT: Person.PersonPhone and Person.Person

*/

SELECT FIRSTNAME, LASTNAME, PHONENUMBER
FROM PERSON.PersonPhone PPP
INNER JOIN PERSON.PERSON PP
ON PP.BusinessEntityID =PPP.BusinessEntityID


/* QUESTION 14 
Using the result from question 13, create a derived column called 'Full Name' 
that is made up of the Title, First Name, Middle Name, Last name and Suffix.
*/

SELECT FIRSTNAME, pp.LASTNAME, MIDDLENAME, PHONENUMBER,TITLE, pp.BusinessEntityID, SUFFIX,
CONCAT (TITLE +'  ', FIRSTNAME,'  ', + LASTNAME,'  ',+ MIDDLENAME, '  ',+ SUFFIX) FULLNAME
FROM PERSON.PersonPhone PPP
inner join PERSON.PERSON PP
ON PP.BusinessEntityID =PPP.BusinessEntityID


/* QUESTION 15 
Using the result from question 14 please the email addresses of everyone. 
All records need to have an email address
ADDITIONAL HINT: Person.EmailAddress

*/
SELECT FIRSTNAME, LASTNAME, MIDDLENAME, SUFFIX, PHONENUMBER,TITLE, EMAILADDRESS, pp.Businessentityid,
CONCAT (TITLE + '  ', FIRSTNAME,'  ', + LASTNAME,'  ',+ MIDDLENAME +'  ', SUFFIX ) FULLNAME
FROM PERSON.PersonPhone PPP
INNER JOIN PERSON.PERSON PP
ON PP.BusinessEntityID =PPP.BusinessEntityID
INNER JOIN PERSON.EmailAddress PE
ON PP.BusinessEntityID =PE.BusinessEntityID

/* QUESTION 16 
Write a SQL query that will generate data set that display 
a list of first name, last name and  phone numbers from the person and phone number table.
 All first name and last name must have a phone number
 HINT: Person.Person, Person.PersonPhone

*/

select firstname, lastname, phonenumber, pp.BusinessEntityID
from Person.Person pp
left join Person.PersonPhone ppp
on pp. BusinessEntityID = ppp.BusinessEntityID



/* QUESTION 17 
Wirte SQL Query to retrieve the FirstName, MiddleName, LastName of all the employees. 
Create a derived column called LegalName. LegalName is a combination of the FirstName,
MiddleName and LastName. If the middle name is null replace it with "NA".
HINT: Person.Person, HumanResources.Employee, ISNULL, CONCAT
*/

select firstname, isnull(middlename, 'NA') AS Midname, lastname,
concat (firstname, '  ' , middlename,'  ' , lastname) Lagalname
from person.person


/* QUESTION 18 
Write a query to retrieve the First name, last name, job title, vacation hours
and birth date. Then write a derived column called birthYear to retrieve the YEAR of birth.
HINT: HumanResources.Employee, Person.Person

*/
select Firstname, lastname, jobtitle, vacationhours, 
birthdate, year(birthdate) as Birthyear, pp.BusinessEntityID
from person.person pp
inner join HumanResources.Employee emp
on pp. BusinessEntityID = emp. BusinessEntityID


/* QUESTION 19 
Your company is in the process of rewarding it'S customers and they have asked you to generate
a query that will display the customer account number, the customer id, from the customer table
and the order date, due date and ship date from the salesorderheader table.
	1. The want you to only return the date (No time) from the order date, due date and ship date 
	2. They want you to write a derived column called DueDateExtended that will add 3 months to the due date
	3. They want you to write a derived column called ShipDateExtended that will add 7 days to the ship date
HINT: Sales.SalesOrderHeader, Sales.Customer, CAST, DATEADD, 
*/


select sc.customerid, sc.accountnumber,
cast (orderdate as date) orderdate,
cast (duedate as date) duedate, 
dateadd(month,3,cast(duedate as date)) duedateextended,
cast (shipdate as date) shipdate, 
dateadd(Day,7,cast(shipdate as date)) shipdateextended
from Sales.SalesOrderHeader ssh
Inner join  sales.Customer sc
on ssh.CustomerID =sc.CustomerID


/* QUESTION 20 
Write a SQL query to provide a list of phone numbers where the phone number type is "Home" 
HINT: Person.PersonPhone, Person.PhoneNumberType , WHERE

*/
select phonenumber, [name]
from Person.PersonPhone ppp
 join Person.PhoneNumberType ppy
on ppp.PhoneNumberTypeID =ppy.PhoneNumberTypeID
where name = 'home'


/* QUESTION 21 
The front end developer are finding it hard to using your report that you created in question 19.
They have asked that you create add a derived column called FrontEndColumn that will convert
all the first 2 letter of the account number to lower case.
HINT: LOWER, SUBSTRING, CONCAT, LEN
*/
select ss.customerid,  lower(substring(sc.accountnumber, 1,11))FrontEndColumn, 
cast (orderdate as date) orderdate,
cast (duedate as date) duedate, 
dateadd(month,3,cast(duedate as date)) duedateextended,
cast (shipdate as date) shipdate, 
dateadd(Day,7,cast(shipdate as date)) shipdateextended
from Sales.SalesOrderHeader ss
left join  sales.Customer sc
on ss.CustomerID =sc.CustomerID

/* QUESTION 22 
Your manager wants you to return vendor's account numbers but he wants you to make sure each 
vendor account number is up to 20 characters. Create a derived column called AccountStatus.
If the length of the account number is 20 and above then display 'Eligible' else 'Not Eligible'
 HINT : LEN,[Purchasing].[Vendor]

*/

select [name], len (concat (replicate (0,10),AccountNumber))AccountStatus,AccountNumber,
 case 
 when len (concat (replicate (0,10),AccountNumber)) > 20 then 'Eligible'
 else 'Not Eligible'
 end as accountstatus
 from Purchasing.Vendor



/* QUESTION 23 
You manager want you to retune the name of all the vendors
and then write him a derived column that will remove 
the following special characters 
from the Name column: periods,Commas,&,and spaces
HINT : REPLACE (NESTED),[Purchasing].[Vendor]

*/

select [Name],
Replace (replace(replace(replace(Name, ',', ''), '.', ''), '&', ''),' ', '')Derivedname
from Purchasing.Vendor


/* QUESTION 24  
Your team have been tasked to generate a unique ID for 
each customer in the system, please write a SQL query that 
will generate a unique ID based on the following fields and condition:
     :first 3 characters of the [PersonID]
	 :last two characters of the [StoreID]
	 :[TerritoryID],
	 :and the [AccountNumber]
*/

SELECT isnull(LEFT(PersonID,3),'*'  )AS FIRST3,RIGHT(STOREID,2) LAST2,AccountNumber,
CONCAT(LEFT(PersonID,3),RIGHT(STOREID,2) 
 ,TerritoryID,AccountNumber) AS  uniqueID 
from sales.customer 
WHERE PersonID IS NOT NULL AND StoreID IS NOT NULL

OR
select customerid,territoryid,accountnumber,
				   left (personid, 3) personid, 
				   right (StoreID, 2)storeid,
				   right(TerritoryID, 2) Territoryid,
				    right(AccountNumber, 2) AccountNumber
from sales.customer




/*QUESTION  25 
   Convert all Last name values to Upper Case, then convert all First 
   name values to lower case
  
*/

select upper (lastname) Lastname,
		lower(firstname) Firstname
from person.person

/*QUESTION 26 
Please return the job title, birth date, and modified date
also write a derived column called DayDiff that return the difference in DAY between the 
birthdate and modified date 
*/

select jobtitle, birthdate,
datediff (day, birthdate,modifieddate) daydiff
from HumanResources.Employee


/*QUESTION 27 
Using you answer from question 26 write a derived column called 
MonthDiff that return the 
difference in MONTH between the 
birthdate and modified date
*/

select jobtitle, birthdate,
datediff (day, birthdate,modifieddate) daydiff,
datediff (month, birthdate,modifieddate) monthdiff
from HumanResources.Employee
