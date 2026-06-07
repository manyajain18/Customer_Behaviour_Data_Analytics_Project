-- Monthly Revenue Trend
SELECT Month,
       SUM(Revenue) AS monthly_revenue
FROM retail
GROUP BY Month
ORDER BY Month;

-- Yearly Revenue Trend
SELECT Year,
       SUM(Revenue) AS yearly_revenue
FROM retail
GROUP BY Year
ORDER BY Year;


-- Monthly Growth Revenue
SELECT Month,
       revenue,
       LAG(revenue)
       OVER(ORDER BY Month) AS previous_month,
       ROUND(
           (
             revenue -
             LAG(revenue)
             OVER(ORDER BY Month)
           )
           /
           LAG(revenue)
           OVER(ORDER BY Month)
           * 100,
           2
       ) AS growth_percent
FROM (
    SELECT Month,
           SUM(Revenue) AS revenue
    FROM retail
    GROUP BY Month
) t;




-- Running Total Revenue
SELECT InvoiceDate,
       daily_revenue,
       SUM(daily_revenue)
       OVER(ORDER BY InvoiceDate)
       AS running_total
FROM (
    SELECT DATE(InvoiceDate) AS InvoiceDate,
           SUM(Revenue) AS daily_revenue
    FROM retail
    GROUP BY DATE(InvoiceDate)
) t;




