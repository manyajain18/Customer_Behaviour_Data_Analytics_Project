-- Repeat Customers
SELECT CustomerID,
       COUNT(DISTINCT InvoiceNo) AS orders_count
FROM retail
GROUP BY CustomerID
HAVING orders_count > 1;



-- One Time Customers
SELECT CustomerID,
       COUNT(DISTINCT InvoiceNo) AS orders_count
FROM retail
GROUP BY CustomerID
HAVING orders_count = 1;



-- Average Order Value
SELECT AVG(order_total) AS avg_order_value
FROM (
    SELECT InvoiceNo,
           SUM(Revenue) AS order_total
    FROM retail
    GROUP BY InvoiceNo
) t;




-- Customer Segmentation
SELECT CustomerID,
       SUM(Revenue) AS total_spent,
       CASE
           WHEN SUM(Revenue) > 10000 THEN 'High Value'
           WHEN SUM(Revenue) > 5000 THEN 'Medium Value'
           ELSE 'Low Value'
       END AS customer_segment
FROM retail
GROUP BY CustomerID;






-- Top Customers Ranking
SELECT CustomerID,
       SUM(Revenue) AS total_spent,
       DENSE_RANK() OVER(
           ORDER BY SUM(Revenue) DESC
       ) AS customer_rank
FROM retail
GROUP BY CustomerID;



-- Top product per country
SELECT Country,
       Description,
       total_quantity
FROM (
    SELECT Country,
           Description,
           SUM(Quantity) AS total_quantity,
           RANK() OVER(
               PARTITION BY Country
               ORDER BY SUM(Quantity) DESC
           ) AS rnk
    FROM retail
    GROUP BY Country, Description
) t
WHERE rnk = 1;



-- Days with extremely High Sales
WITH daily_sales AS (
    SELECT DATE(InvoiceDate) AS sales_date,
           SUM(Revenue) AS total_sales
    FROM retail
    GROUP BY DATE(InvoiceDate)
)

SELECT *
FROM daily_sales
WHERE total_sales >
(
    SELECT AVG(total_sales)
    FROM daily_sales
);



-- Creating Veiw
CREATE VIEW top_customers AS
SELECT CustomerID,
       SUM(Revenue) AS total_spent
FROM retail
GROUP BY CustomerID;

SELECT *
FROM top_customers;







