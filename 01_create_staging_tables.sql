CREATE DATABASE SalesWarehouse;
USE SalesWarehouse;

-- SOURCE 1: raw customer data (messy, like it came from a CRM export)
CREATE TABLE RawCustomers (
    CustomerID INT,
    FullName VARCHAR(100),
    SignupDate VARCHAR(20),
    City VARCHAR(50)
);

INSERT INTO RawCustomers (CustomerID, FullName, SignupDate, City)
VALUES
(1, 'john smith', '2023-11-02', 'pretoria'),
(2, 'mary jones', '2023-12-15', 'johannesburg'),
(3, 'peter ngobeni', '2024-01-10', 'PRETORIA'),
(4, 'Sarah Khumalo', '2024-02-20', 'cape town'),
(5, 'thabo mokoena', '2024-03-05', 'pretoria');

-- SOURCE 2: raw order data (messy, like it came from an orders system)
CREATE TABLE RawOrders (
    OrderID INT,
    CustomerID INT,
    OrderAmount VARCHAR(20),
    OrderDateRaw VARCHAR(20)
);

INSERT INTO RawOrders (OrderID, CustomerID, OrderAmount, OrderDateRaw)
VALUES
(101, 1, '450.00', '2024-01-15'),
(102, 2, '1200.50', '2024-01-16'),
(103, 1, '89.99', '2024-01-20'),
(104, 3, NULL, '2024-02-01'),
(105, 4, '675.25', '2024-02-10'),
(106, 5, '320.00', '2024-02-15'),
(107, 2, '150.00', '2024-02-18');

SELECT * FROM RawCustomers;
SELECT * FROM RawOrders;

--Adding stage table scripts--
