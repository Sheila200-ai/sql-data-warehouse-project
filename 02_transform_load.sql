USE SalesWarehouse;

-- FINAL WAREHOUSE TABLE: clean, joined, ready for reporting
CREATE TABLE FactCustomerSales (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    CustomerName VARCHAR(100),
    CustomerCity VARCHAR(50),
    OrderAmount DECIMAL(10,2),
    OrderDate DATE,
    AmountWasMissing TINYINT,
    LoadedAt DATETIME
);

-- TRANSFORM + LOAD: clean staging data, join sources, load into final table
INSERT INTO FactCustomerSales (OrderID, CustomerID, CustomerName, CustomerCity, OrderAmount, OrderDate, AmountWasMissing, LoadedAt)
SELECT
    o.OrderID,
    o.CustomerID,
    -- Standardize customer name capitalization
    CONCAT(UPPER(LEFT(c.FullName, 1)), LOWER(SUBSTRING(c.FullName, 2))) AS CustomerName,
    -- Standardize city capitalization
    CONCAT(UPPER(LEFT(c.City, 1)), LOWER(SUBSTRING(c.City, 2))) AS CustomerCity,
    -- Handle missing order amounts - default to 0
    IFNULL(CAST(o.OrderAmount AS DECIMAL(10,2)), 0) AS OrderAmount,
    -- Convert text date to real DATE type
    STR_TO_DATE(o.OrderDateRaw, '%Y-%m-%d') AS OrderDate,
    -- Flag rows where amount was missing
    CASE WHEN o.OrderAmount IS NULL THEN 1 ELSE 0 END AS AmountWasMissing,
    -- Audit column
    NOW() AS LoadedAt
FROM RawOrders o
JOIN RawCustomers c ON o.CustomerID = c.CustomerID;

-- Verify the result
SELECT * FROM FactCustomerSales;
