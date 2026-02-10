--Clean Models--

CREATE TABLE dim_Customers (
    CustomerID NVARCHAR(50) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    FullName AS (FirstName + ' ' + LastName),
    Gender NVARCHAR(20),
    BirthDate DATE,
    City NVARCHAR(50),
    JoinDate DATE
);

CREATE TABLE dim_Products (
    ProductID NVARCHAR(50) PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    Category NVARCHAR(50),
    SubCategory NVARCHAR(50),
    UnitPrice DECIMAL(10,2) CHECK (UnitPrice >= 0),
    CostPrice DECIMAL(10,2) CHECK (CostPrice >= 0)
);

CREATE TABLE dim_Stores (
    StoreID NVARCHAR(50) PRIMARY KEY,
    StoreName NVARCHAR(100) NOT NULL,
    City NVARCHAR(50),
    Region NVARCHAR(50)
);

CREATE TABLE fact_Transactions (
    TransactionID NVARCHAR(50) PRIMARY KEY,
    Date DATE NOT NULL,
    CustomerID NVARCHAR(50) NOT NULL,
    ProductID NVARCHAR(50) NOT NULL,
    StoreID NVARCHAR(50) NOT NULL,
    Quantity INT CHECK (Quantity > 0),
    Discount DECIMAL(5,2) CHECK (Discount >= 0 AND Discount <= 1),
    PaymentMethod NVARCHAR(50),

    FOREIGN KEY (CustomerID) REFERENCES dim_Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES dim_Products(ProductID),
    FOREIGN KEY (StoreID) REFERENCES dim_Stores(StoreID)
);


INSERT INTO dim_Customers
SELECT DISTINCT *
FROM stg_Customers;

INSERT INTO dim_Products
SELECT DISTINCT *
FROM stg_Products;

INSERT INTO dim_Stores
SELECT DISTINCT *
FROM stg_Stores;

INSERT INTO fact_Transactions
SELECT *
FROM stg_Transactions;

--Certified_View--

CREATE OR ALTER VIEW vw_Certified_Revenue AS
SELECT
    t.TransactionID,
    t.Date,
    t.CustomerID,
    t.ProductID,
    t.StoreID,
    t.Quantity,
    p.UnitPrice,
    p.CostPrice,
    t.Discount,

    -- Net Revenue (after discount)
    (t.Quantity * p.UnitPrice * (1 - t.Discount)) AS CertifiedRevenue,

    -- Gross Profit
    ((t.Quantity * p.UnitPrice * (1 - t.Discount)) 
        - (t.Quantity * p.CostPrice)) AS GrossProfit

FROM fact_Transactions t
JOIN dim_Products p 
    ON t.ProductID = p.ProductID;


SELECT *
FROM vw_Certified_Revenue;