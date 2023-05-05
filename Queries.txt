USE LIBRARY;
#Q1: RETRIEVE ALL DETAILS OF EACH BOOK.
SELECT * 
FROM BOOK;
#Q2: LIST METHODS OF PAYMENT OF THE BOOKS.
SELECT DISTINCT METHOD_OF_PAYMENT
FROM BUY;
#Q3: RETRIEVE EACH DEPARTNENT'S NAME WHOSE NUMBER IS 110. 
SELECT name
FROM DEPARTMENT
WHERE NO = 110;
#Q4: FOR EACH CUSTOMER LIVES IN CAIRO,RETRIEVE NAME AND PHONE OF THIS CUSTOMER. 
SELECT NAME , PHONE 
FROM CUSTOMER
WHERE ADDRESS LIKE '%CAIRO%';
#Q5: LIST THE NAME AND SALARY OF ALL REGISTRARS.
SELECT E.FNAME,E.SALARY
FROM REGISTRAR R ,
EMPLOYEE E
WHERE R.ID=E.ID;
#Q6: RETRIEVE THE NAME AND NUMBER OF AUTHORS IN DEPARTMENT 5.
SELECT A.NAME,A.NO ,D.NAME
FROM AUTHOR A ,
BOOK B,
DEPARTMENT D
WHERE B.A_NO=A.NO AND
B.DEPARTMENT_NO=D.NO 
AND D.NAME='CHEMISTRY';
#Q7: RETRIEVE EACH CUSTOMER'S NAME AND THE NAME OF THE BOOK HE BOUGHT BY THE WAY OF FAWRY. 
SELECT C.NAME AS CUSTOMER_NAME, B.NAME AS BOOK_NAME 
FROM CUSTOMER C ,
BOOK B,
BUY U
WHERE U.CUSTOMER_SSN = C.SSN AND
U.BOOK_NO = B.NO AND
U.METHOD_OF_PAYMENT = 'FAWRY';
#Q8: RETRIEVE THE NAME OF EACH EMPLOYEE AND HIS/HER SON.
SELECT E.FNAME AS EMP_NAME , D.NAME AS DEPENDENT_NAME
FROM EMPLOYEE E ,
DEPENDENT D
WHERE D.E_ID = E.ID AND
D.RELATIONSHIP = 'SON';
#Q9: RETRIEVE EACH DEPARTMENT'S NAME AND ITS NUMBER OF EMPLOYEES WHITH SHOWING IN DESCENDING TYPE.
SELECT NAME , COUNT(w.id) 
FROM DEPARTMENT d, worker w
where w.d_no = d.no
GROUP BY name
ORDER BY 2 DESC;
#Q10: RETRIEVE EACH DEPARTMENT'S NAME AND THE SUM OF SALARIES OF WORKERS IN DESCENDING TYPE.
SELECT D.NAME , SUM(e.SALARY)
FROM DEPARTMENT D,
worker w ,
employee e
WHERE D.no = w.D_No and e.id = w.id
GROUP BY D.NAME
ORDER BY 2 DESC;
#Q11: LIST EACH AUTHOR'S NAME AND HIS/HER SUMMATION OF COST OF HIS/HER BOOKS.
SELECT A.NAME , SUM(B.COST)
FROM AUTHOR A,
BOOK B
WHERE B.A_NO=A.NO
GROUP BY A.NAME
ORDER BY 2 DESC;

#Q12: MAXIMUM SALARY OF EMPLOYEES.
SELECT MAX(SALARY)
FROM EMPLOYEE ;

#Q13:RETRIEVE THE fist name , salary, phone in department astronomy 
select e.FName as employee_d, e.salary as e_d, e.phone as e_d 
from worker w, employee e,department d
where  w.D_No=d.No and  e.ID=d.Mgr_id and  d.No=(select d.No 
from department d
where d.Name='astronomy');

#Q14:RETRIEVE THE fist name , salary, phone,sex who takes minimum salary 
select e.FName ,e.minit, e.salary , e.phone 
from  employee e
where e.salary=(select min(e.salary)
from employee e);

#Q15:RETRIEVE THE employee'S lname and address  who have salary greater than avarge salary of biology department order by salary and l_name  of employee
select e.LName as l_name,e.Address as emp_ad,e.Salary as emp_salary
from employee e
where e.salary>(select avg(e.Salary)
from employee e ,department d ,worker w
where e.ID=w.ID and w.D_No=d.No and d.name ='biology')
order by e.salary,e.lname;

#Q16:retrieve each employee name and his/her dependent name (if exist) arrange by fname ,lname of employee
select e.fname as emp_fname,e.lname as emp_lname ,d.name as dependent_name
from employee e left outer join dependent d on e.ID=d.E_ID
order by e.fname;

#Q17: Sum of employee salary for male and female 
select  e.sex , sum(e.salary)
from employee e 
group by e.sex;

#Q18: all date of customer who borrow book , book name and return date of this book orderd by return date
select c.name as cust_name,c.ssn as cust_ssn,c.phone as cust_phone ,c.address as cust_address,b.name as book_name,d.Return_date as Return_date_of_book
from customer c ,book b,borrow d
where d.Book_No=b.No and d.Customer_SSN=c.SSN
order by d.Return_date ;