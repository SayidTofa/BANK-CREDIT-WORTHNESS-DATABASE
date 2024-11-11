CREATE DATABASE FM_Investment_Banking;
USE FM_Investment_Banking;

 Create Table customers (customer_ID int auto_increment key,
	Customer_Name varchar (10),
    Phone_Number varchar (15),
    Email_Address varchar (30),
    Current_Account_Balance decimal (10, 2),
    Account_Type VARCHAR(10) CHECK (Account_Type IN ('current','savings')),
    Last_Deposit_Date DATE,
    Last_Loan_Collection_Date DATE,
    Credit_History VARCHAR(10) CHECK (Credit_History IN ('Good','Bad')),
    Loan_Repayment_Date DATE,
    Credit_Score  varchar (15));
    
    select * from Customers;
    
    
    CREATE TABLE Loan_Application (Loan_Application_Id int auto_increment primary key,
   Customer_Id int, FOREIGN KEY (Customer_Id)  REFERENCES Customers (Customer_Id),
    Loan_Amount decimal (10,2),
    Loan_Repayment_period varchar (10) check (Loan_Repayment_period in ('6_Months','12_Months')));
    
    select * from Loan_Application;
    
    
    
    CREATE TABLE Credit_Eligibility_Criteria (Criteria_Id int auto_increment primary key,
    Customer_Id int, Foreign Key (Customer_Id) references Customers (Customer_Id),
    Criteria_Name varchar (100),
    Credit_Score varchar (3));
    
    select * from  Credit_Eligibility_Criteria;
    
    
   CREATE TABLE Customer_Credit_Eligibility (Customer_Credit_Eligibility_Id int auto_increment  primary key,
     Customer_Id int, Foreign Key (Customer_Id) references Customers (Customer_Id),
	Criteria_Score varchar (20),  check (criteria_score in ('30_Approve','Below_30_Rejected')),
    Loan_Status varchar (20), check (Loan_Status in ('Approve','Rejected')));
    
    select * from Customer_Credit_Eligibility;
    

INSERT INTO Customer_Credit_Eligibility (Customer_Credit_Eligibility_Id, customer_id, criteria_score, loan_status)
VALUES
(1, 1,'30_Approve','Approve'),
(2, 2,'Below_30_Rejected','Rejected'),
(3, 3,'30_Approve','Approve'),
(4, 4,'30_Approve','Approve'),
(5, 5,'Below_30_Rejected','Rejected'),
(6, 6,'30_Approve','Approve'),
(7, 7,'30_Approve','Approve'),
(8, 8,'Below_30_Rejected','Rejected'),
(9, 9,'30_Approve','Approve'),
(10, 10,'30_Approve','Approve'),
(11, 11,'Below_30_Rejected','Rejected'),
(12, 12,'30_Approve','Approve'),
(13,13, '30_Approve','Approve'),
(14, 14,'Below_30_Rejected','Rejected'),
(15, 15,'30_Approve','Approve');


SELECT 
  customers.customer_name, 
  customers.current_Account_Balance, 
  customers.Credit_History, 
  customers.Credit_Score, 
  Loan_Application.Loan_Amount, 
  Loan_Application.Loan_Repayment_period
FROM customers
INNER JOIN Loan_Application 
ON customers.Loan_Application = Loan_Application.Loan_Application_id;
SELECT * 
FROM 
  customers;




CREATE VIEW customer_credit_summary AS
SELECT
customers.customer_ID,
customers.Customer_Name,
customers.Account_Type,
customers.Last_Deposit_Date,
customers.Last_Loan_Collection_Date,
customers.Credit_History,
customers.Credit_Score,
customers.Current_Account_Balance,
Credit_Eligibility_Criteria.Criteria_Name,
Customer_Credit_Eligibility.Criteria_Score,
Customer_Credit_Eligibility.Loan_Status
FROM
customers
JOIN Customer_Credit_Eligibility ON customers.customer_ID = Customer_Credit_Eligibility.customer_ID
JOIN Credit_Eligibility_Criteria ON Credit_Eligibility_Criteria.Criteria_ID = Customer_Credit_Eligibility.Criteria_ID;

SELECT * FROM customer_credit_summary;

 