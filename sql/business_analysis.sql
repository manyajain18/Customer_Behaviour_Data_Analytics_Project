use customer_behaviour;

-- Total Revenue
SELECT SUM(Revenue) AS total_revenue
FROM retail;

-- Total Orders
SELECT COUNT(DISTINCT InvoiceNo) AS total_orders
FROM retail;

-- Total Customers
SELECT COUNT(DISTINCT CustomerID) AS total_customers
FROM retail;

-- Total Countries
SELECT COUNT(DISTINCT Country) AS total_countries
FROM retail;



-- Revenue by Country
SELECT Country,
       ROUND(SUM(Revenue),2) AS revenue
FROM retail
GROUP BY Country
ORDER BY revenue DESC;


-- Top Customers
SELECT CustomerID,
       SUM(Revenue) AS total_spent
FROM retail
GROUP BY CustomerID
ORDER BY total_spent DESC
LIMIT 10;


-- Top Products Analysis
SELECT Description,
       SUM(Quantity) AS total_quantity_sold,
       ROUND(SUM(Revenue),2) AS total_revenue
FROM retail
GROUP BY Description
ORDER BY total_revenue DESC
LIMIT 10;






