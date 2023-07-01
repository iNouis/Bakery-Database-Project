CREATE DATABASE IF NOT EXISTS `bakery` ;

use `bakery`;

CREATE TABLE Managers (
    manager_id INT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    years_of_experience INT
);

CREATE TABLE Branches (
    branch_id INT PRIMARY KEY,
    branch_sales FLOAT
);

CREATE TABLE BranchesLocation (
    branch_Location VARCHAR(255),
    branch_id INT,
    PRIMARY KEY (branch_Location, branch_id),
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
);

CREATE TABLE ManagersOfBranches (
    manager_id INT,
    branch_id INT,
    PRIMARY KEY (manager_id, branch_id),
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id),
    FOREIGN KEY (manager_id) REFERENCES Managers(manager_id)
);

CREATE TABLE Employees (
    work_id INT PRIMARY KEY,
    employee_name VARCHAR(255),
    job_title VARCHAR(255),
    salary FLOAT,
    phone_number VARCHAR(20),
    employee_address VARCHAR(255),
    manager_id INT,
    branch_id INT,
    FOREIGN KEY (manager_id) REFERENCES Managers(manager_id),
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
);

CREATE TABLE Employee_Skills (
    work_id INT,
    skill VARCHAR(255),
    PRIMARY KEY (work_id, skill),
    FOREIGN KEY (work_id) REFERENCES Employees(work_id)
);

CREATE TABLE Customers (
    customer_id INT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    phone_number VARCHAR(20) UNIQUE,
    customer_address VARCHAR(255),
    receipt_num INT,
    PRIMARY KEY (customer_id ,first_name, last_name)
);


CREATE TABLE OrderReceipt (
    receipt_num INT,
    order_id INT,
    phone_number VARCHAR(20),
    work_id INT,
    amount_of_product INT,
    branch_id INT,
    total_price FLOAT,
    purchase_date DATE,
    payment_method VARCHAR(20),
    PRIMARY KEY (receipt_num, order_id, phone_number),
    INDEX (order_id),
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id),
    FOREIGN KEY (work_id) REFERENCES Employees(work_id),
    FOREIGN KEY (phone_number) REFERENCES Customers(phone_number)
);

CREATE TABLE Products (
	product_id INT PRIMARY KEY,
	product_name VARCHAR(255),
	product_date DATE,
	product_price FLOAT,
	product_description TEXT
);

-- Create the Includes table
CREATE TABLE Includes (
	order_id INT,
	product_id INT,
	PRIMARY KEY (order_id, product_id),
	FOREIGN KEY (order_id) REFERENCES OrderReceipt(order_id),
	FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Alter the Customers table
ALTER TABLE Customers ADD FOREIGN KEY (receipt_num) REFERENCES OrderReceipt(receipt_num);

-- Create the Serves table
CREATE TABLE Serves (
	work_id INT,
	phone_number VARCHAR(20),
	PRIMARY KEY (work_id, phone_number),
	FOREIGN KEY (work_id) REFERENCES Employees(work_id),
	FOREIGN KEY (phone_number) REFERENCES Customers(phone_number)
);


CREATE TABLE Produce (
	branch_id INT,
	product_id INT,
	PRIMARY KEY (branch_id, product_id),
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id),
	FOREIGN KEY (product_id) REFERENCES Products(product_id)
);


CREATE TABLE Places (
    phone_number VARCHAR(20),
    order_id INT,
    PRIMARY KEY(phone_number,  order_id),
    FOREIGN KEY (phone_number) REFERENCES Customers(phone_number),
    FOREIGN KEY (order_id) REFERENCES OrderReceipt(order_id)
);

CREATE TABLE Taken_by (
	order_id INT,
	work_id INT,
    PRIMARY KEY (order_id, work_id),
	FOREIGN KEY (work_id) REFERENCES Employees(work_id),
	FOREIGN KEY (order_id) REFERENCES OrderReceipt(order_id)
);

-- Insert data into the Managers table
INSERT INTO Managers (manager_id, first_name, last_name, years_of_experience)
VALUES (1, 'Ali', 'Mohammed', 10),
       (2, 'Fatima', 'Abdullah', 8),
       (3, 'Ahmed', 'Ali', 7),
       (4, 'Khadija', 'Hussein', 6),
       (5, 'Saeed', 'Abdulrahman', 5);

-- Insert data into the Branches table
INSERT INTO Branches (branch_id, branch_sales)
VALUES (1, 1000.0),
       (2, 2000.0),
       (3, 3000.0),
       (4, 4000.0),
       (5, 5000.0);

-- Insert data into the BranchesLocation table
INSERT INTO BranchesLocation (branch_Location, branch_id)
VALUES ('Riyadh', 1),
       ('Jeddah', 2),
       ('Dammam', 3),
       ('Mecca', 4),
       ('Medina', 5);

-- Insert data into the ManagersOfBranches table
INSERT INTO ManagersOfBranches (manager_id, branch_id)
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (4, 4),
       (5, 5);

-- Insert data into the Employees table
INSERT INTO Employees (work_id, employee_name, job_title, salary, phone_number, employee_address, manager_id, branch_id)
VALUES (1,'Abdulaziz','Baker',3000.0,'0501234567','Prince Mohammed bin Abdulaziz Street',1 ,1 ),
       (2,'Noura','Cashier',2500.0,'0502345678','Tahlia Street',2 ,2 ),
       (3,'Khaled','Sales Manager',4000.0,'0503456789','Prince Sultan bin Abdulaziz Street',3 ,3 ),
       (4,'Reem','Accountant',3500.0,'0504567890','Prince Faisal bin Fahd bin Abdulaziz Street',4 ,4 ),
       (5,'Sami','Receptionist',2000.0,'0505678901','Prince Mishaal bin Abdulaziz Street',5 ,5 );

-- Insert data into the Employee_Skills table
INSERT INTO Employee_Skills (work_id, skill)
VALUES (1,'Baking'),
       (1,'Cake Decorating'),
       (2,'Customer Service'),
       (2,'Cash Handling'),
	   (3,'Sales Management'),
	   (3,'Marketing'),
	   (4,'Accounting Management'),
	   (4,'Financial Reporting'),
	   (5,'Customer Reception'),
	   (5,'Answering Customer Inquiries');
       
-- Insert data into the Customers table
INSERT INTO Customers(customer_id ,first_name ,last_name ,phone_number ,customer_address )
VALUES (1 ,'Hassan' ,'Ahmed' ,'0506789012' ,'King Fahd Road' ),
       (2 ,'Raghad' ,'Khaled' ,'0507890123' ,'King Abdullah Road' ),
       (3 ,'Talal' ,'Sultan' ,'0508901234' ,'King Salman Road' ),
       (4 ,'Sarah' ,'Fahd' ,'0509012345' ,'King Khalid Road' ),
       (5 ,'Waleed' ,'Nasser' ,'0500123456' ,'King Saud Road');

-- Insert data into the Serves table
INSERT INTO Serves(work_id ,phone_number )
VALUES(1 ,'0506789012'),
      (2 ,'0507890123'),
	  (3 ,'0508901234'),
	  (4 ,'0509012345'),
	  (5 ,'0500123456');

-- Insert data into the Products table
INSERT INTO Products(product_id ,product_name ,product_date ,product_price ,product_description )
VALUES(1 ,'Chocolate Cake','2023-05-27',20.0,'A delicious chocolate cake'),
      (2 ,'Vanilla Cupcake','2023-05-27',5.0,'A tasty vanilla cupcake'),
	  (3 ,'Apple Tart','2023-05-27',15.0,'A delicious apple tart'),
	  (4 ,'Fruit Pie','2023-05-27',10.0,'A delicious fruit pie'),
	  (5 ,'Oatmeal Cookie','2023-05-27',8.0,'A delicious oatmeal cookie');

-- Insert data into the Produce table
INSERT INTO Produce(branch_id, product_id)
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (4, 4),
       (5, 5);
-- Insert data into the OrderReceipt table
INSERT INTO OrderReceipt(receipt_num ,order_id ,phone_number ,work_id ,amount_of_product ,branch_id ,total_price ,purchase_date ,payment_method )
VALUES (1, 1, '0506789012', 1, 5, 1, 100.0, '2023-05-27', 'cash'),
       (2, 2, '0507890123', 2, 10, 2, 50.0, '2023-05-27', 'credit_card'),
       (3, 3, '0508901234', 3, 15, 3, 75.0, '2023-05-27', 'cash'),
       (4, 4, '0509012345', 4, 20, 4, 100.0,'2023-05-27', 'credit_card'),
       (5, 5,'0500123456',5 ,25 ,5 ,125.0 ,'2023-05-27' ,'cash');

-- Insert data into the Includes table
INSERT INTO Includes(order_id ,product_id )
VALUES(1 ,1),
      (2 ,2),
	  (3 ,3),
	  (4 ,4),
	  (5 ,5);

-- Insert data into the Places table
INSERT INTO Places(phone_number ,order_id)
VALUES('0506789012', 1),
      ('0507890123', 2),
      ('0508901234',3),
	  ('0509012345' ,4),
	  ('0500123456',5);
      
-- Insert data into the Taken_by table
INSERT INTO Taken_by (order_id, work_id)
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (4, 4),
       (5, 5);



-- Select all columns from the Employees table
SELECT *
FROM Employees;

-- Update the employee_name and salary columns in the Employees table where the work_id is equal to 1
UPDATE Employees
SET employee_name = 'Abdulaziz',  salary = '4000.0' 
WHERE work_id = 1;

-- Select all columns from the Employees table again to show changes made by previous update query
SELECT *
FROM Employees;

-- Select all columns from the Products table
SELECT *
FROM Products;

-- Update the product_name and product_price columns in the Products table where the product_id is equal to 2
UPDATE Products
SET product_name  = 'Vanilla Cupcake',  product_price = '18.0' 
WHERE product_id  = 2;

-- Select all columns from the Products table again to show changes made by previous update query
SELECT *
FROM Products;

-- Delete rows from the Serves table where the phone_number is equal to '0500123456'
DELETE FROM Serves WHERE phone_number = '0500123456';

-- Delete rows from the Serves table where the phone_number is equal to '0509012345'
DELETE FROM Serves WHERE phone_number = '0509012345';





-- Select all columns from the Managers table where the manager_id is equal to 1
SELECT *
FROM Managers
WHERE manager_id = 1;

-- Select the years_of_experience column from the Managers table where the value is between 5 and 10
SELECT years_of_experience 
FROM Managers
WHERE years_of_experience BETWEEN 5 AND 10;

-- Select the first_name column from the Managers table where the value is in the list ('Ali', 'Fatima', 'Ahmed', 'khadija', 'saeed')
SELECT first_name
FROM Managers
WHERE first_name IN ('Ali', 'Fatima', 'Ahmed', 'khadija', 'saeed');

-- Count the number of rows in the Branches table
SELECT COUNT(branch_sales)
FROM Branches;

-- Calculate the average value of the branch_sales column in the Branches table
SELECT AVG(branch_sales) 
FROM Branches;

-- Select the maximum value of the branch_sales column in the Branches table
SELECT MAX(branch_sales) 
FROM Branches;

-- Select the minimum value of the branch_sales column in the Branches table
SELECT MIN(branch_sales) 
FROM Branches;

-- Select the manager_id and sum of years_of_experience from the Managers table, group by manager_id, filter groups where sum of years_of_experience is greater than 3, and order by manager_id in ascending order
SELECT manager_id , SUM(years_of_experience) 
FROM Managers
GROUP BY manager_id HAVING SUM(years_of_experience) > 3
ORDER BY manager_id ASC;

-- Select manager_id from Managers table and count rows in Branches table related to each manager through ManagersOfBranches table, group by manager_id and order by count in descending order
SELECT M.manager_id, COUNT(B.branch_sales) AS count
FROM Managers M
JOIN ManagersOfBranches MB ON M.manager_id = MB.manager_id
JOIN Branches B ON MB.branch_id = B.branch_id
GROUP BY M.manager_id
ORDER BY count DESC;

-- Select manager_id and average salary of employees from Managers and Employees tables where manager_id is greater than 1, group by manager_id and order by average salary in descending order
SELECT M.manager_id, AVG(E.salary) AS avg_salary
FROM Managers M
JOIN Employees E ON M.manager_id = E.manager_id
WHERE M.manager_id > 1
GROUP BY M.manager_id
ORDER BY avg_salary DESC;


-- Find the names of employees who have more than one skill using a subquery
SELECT e.employee_name
FROM Employees e
WHERE (
    SELECT COUNT(es.skill)
    FROM Employee_Skills es
    WHERE es.work_id = e.work_id 
) > 1;

-- This query returns customer names and total price of their orders where the total price is greater than 50.
SELECT first_name, last_name, total_price
FROM Customers
INNER JOIN OrderReceipt
ON Customers.phone_number = OrderReceipt.phone_number
WHERE total_price > 50;

