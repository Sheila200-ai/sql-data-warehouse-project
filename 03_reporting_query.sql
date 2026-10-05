-- Total sales per customer - the kind of query a BI analyst would run on the warehouse table
SELECT
    CustomerName,
    CustomerCity,
    COUNT(OrderID) AS NumberOfOrders,
    SUM(OrderAmount) AS TotalSpent
FROM FactCustomerSales
GROUP BY CustomerName, CustomerCity
ORDER BY TotalSpent DESC;
