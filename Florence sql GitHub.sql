USE PollynzConsults
GO


--FLORENCE 


--Business question 1: 

--As a group home manager, I would like to get the total number of employees' first names, 
--middle names, and last names of employees who work the night shift.  


select firstname, middlename,lastname,[name]
from hr.employee He
inner join hr.shift hs
on he.shiftid =hs. shiftid
where name like 'night'



--Business question 2: 

--As the admin manager, like a data set, is generated, that will display the first name, 
--middle name, last name, date of birth, job title, vacation hours, address line 1, 
--city, state, and zip code of all employees. This information is needed for an upcoming quarterly audit. 


select firstname, middlename, lastname, birthdate
		, jobtitle, vacationhours, addressline1
		, city, [state], zipcode
from hr.employee


--Business question 3: 

--The admin manager would like to thank you for the outstanding work that you did in question 2. However, 
--he wants you to create a derived column called full address, and this column should be a combination of the 
--address line 1, city, state, and zip code. They need this column because it is hard 
--for them to understand the address if they are spread out on different columns.  


select firstname, middlename, lastname, birthdate
		, jobtitle, vacationhours,
concat		(addressline1
		, city, [state], zipcode) "Full Address"
from hr.employee


--Business question 4:

--As a finance manager, I would like to get records of patients' first name, last name, gender, SSN, and date of birth
--whose sum of inpatients and outpatients charges is greater than two thousand dollars. 
--This is an urgent need because of benchmarking projects that are going on internally. 



select patientfirstname, patientlastname, gender, SSN
		,cast (dateofbirth as date) birthdate
		, inpatientcharges + outpatientcharges AS Sumpatientcharges
from clients.patients cp
Join clients.patientcharges cpt
on cp.chargedid =cpt.chargedid
where inpatientcharges + outpatientcharges  > '2000' 



---Business question 5: 
--The manager is delighted with question 4; she wants you to add additional information to the records.
--The manager will like you to add the medical condition (Name) and the drug name.
--This information is needed to keep track of the patients. 

select patientfirstname, patientlastname, gender, SSN
		,cast (dateofbirth as date) birthdate
		, inpatientcharges + outpatientcharges "Sumpatientcharges"
from clients.patients cp
Join clients.patientcharges cpt
on cp.chargedid =cpt.chargedid
join clients.MedicalCondition cmc
on cp.diagonosisid = cmc.DiagonosisID
join clients.Medication cm
on cmc.DiagonosisID = cm.DiagonosisId
where inpatientcharges + outpatientcharges  > '2000' 


--Business question 6:

--As a group home manager, there have been reports of incidents at the group home, 
--and I would like to get the first name, last name, gender, and name of incident reports of every
--patient who has had reports recorded against them. 


select cp.patientfirstname, cp.patientlastname, cp.gender,hr.[name]
from clients.patients cp
left join hr.incidentreports hr
on cp.reportid = hr.reportid
where [name] is not null

--Business question 7:

--The report from question 6 is appreciated, but I would like you to add the first name, 
---last name, and email address of the employees who were on duty the day the incident occurred.  


select cp.patientfirstname, cp.patientlastname, cp.gender
,hr.name, firstname, lastname, emailaddress, ShiftID
from clients.patients cp
left join hr.incidentreports hr
on cp.reportid = hr.reportid
join hr.employee He
on cp.employeeid = he.employeeid
where [name] is not null


---Business question 8: CORRECT

--There has been a significant HIPPA violation on the report you submitted in question 4; 
--the manager would like you to rewrite the report to produce records with only the last 
--four digits of the SSN displayed while you mask the rest before the last four with an asterisk (*). 

select patientfirstname, patientlastname, gender
	,Right(SSN,4) last4,len(SSN) ssnlen,
	concat(Replicate( '*',7),Right(SSN,4))[masked],
	cast (dateofbirth as date) birthdate
		, inpatientcharges + outpatientcharges [Sumpatientcharges]
from clients.patients cp
Join clients.patientcharges cpt
on cp.chargedid =cpt.chargedid
where  (inpatientcharges+ outpatientcharges) > '2000' 

------OR

select patientfirstname, patientlastname, gender, replicate ('*',7)Replic, right(ssn, 4)last4,
	concat (replicate ('*',7),right(ssn, 4)) Derived
		,cast (dateofbirth as date) birthdate
		, inpatientcharges + outpatientcharges AS Sumpatientcharges
from clients.patients cp
Join clients.patientcharges cpt
on cp.chargedid =cpt.chargedid
where inpatientcharges + outpatientcharges  > '2000' 


--Business question 9:

--As a group home manager, I would like to create a unique ID for all 
--the patients in the facility. I want the ID to be a combination of 
--the first three letters of the patient's first name, 
--the last three letters of the patient's first name, and the 
--last three digits of their social security number.  

select left(patientfirstname, 3)First3, 
	    right(patientfirstname, 3) last3, right(SSN,3) Last3ssn,
		concat(left(patientfirstname, 3)
		,right(patientfirstname, 3),right(SSN,3)) UniqueId
FROM clients.Patients


--Business question 10:

--The group home is preparing to award their employees 
---for their dedication in working for the company.
--As a manager, I would like the employee's first name, 
--last name, gender, but the gender should display mal  e if M and female
--is F, and marital status. I want a column called "Award Date" 
--to keep track of the years that the employee was hired. 
--This is important as we prepare for their retirement package.  


select firstname, lastname, gender, maritalstatus, cast (hiredate as date) Awarddate,
case
when gender = 'M' then 'Male'
when gender = 'F' then 'Female' 
End AS 'Award Date'
from hr.employee

--OR


select firstname, lastname, gender, maritalstatus,
cast (hiredate as date) Awarddate,
case
when gender = 'M' then 'Male'
when gender = 'F' then 'Female' 
when Maritalstatus = 'M' then 'Married'
when Maritalstatus = 'S' then 'Single'
End AS 'Award Date'
from hr.employee



 


