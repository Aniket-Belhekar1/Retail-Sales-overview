--Analytical Queries--

--Total Revenue--
SELECT 
    SUM(CertifiedRevenue) AS TotalRevenue
FROM vw_Certified_Revenue;

--Year Wise Revenue--

SELECT
    YEAR(date) AS Year,
    SUM(CertifiedRevenue) AS TotalRevenue
FROM vw_certified_revenue
GROUP BY YEAR(date)
ORDER BY Year;

--Year wise Gross Profit--

SELECT
    YEAR(date) AS Year,
    SUM(GrossProfit) AS TotalProfit
FROM vw_certified_revenue
GROUP BY YEAR(date)
ORDER BY Year;

--Category wise revenue

SELECT 
    p.category,
    SUM(CertifiedRevenue) AS TotalRevenue,
    SUM(GrossProfit) AS TotalProfit
FROM vw_Certified_Revenue v
JOIN dim_Products p
ON v.ProductID = p.ProductID
GROUP BY p.category
ORDER BY TotalRevenue DESC

--Top 5 Products--

SELECT top 5
    p.ProductName,
    SUM(CertifiedRevenue) AS TotalRevenue,
    RANK() Over (ORDER BY SUM(CertifiedRevenue) DESC) AS RevenueRank
FROM vw_Certified_Revenue v
JOIN dim_Products p
ON v.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalRevenue DESC

--Monthly Revenue--

With MonthlyRevenue AS (
    SELECT
        YEAR(Date) AS YearNum,
        Month(Date) AS MonthNum,
        SUM(CertifiedRevenue) AS TotalRevenue
    FROM vw_Certified_Revenue
    GROUP BY YEAR(Date), Month(Date)
)
SELECT
    YearNum,
    MonthNum,
    TotalRevenue,
    LAG(TotalRevenue) Over (ORDER BY YearNum, MonthNum) AS PreviousMonthRevenue,
    TotalRevenue 
        - LAG(TotalRevenue) Over (ORDER BY YearNum, MonthNum) AS RevenueChange
FROM MonthlyRevenue
ORDER BY YearNum, MonthNum;
