-- USE DATABASE
USE polish_store;

-- VERIFY DATA IS CORRECT
SELECT * FROM daily_sales;

-- UPLOADED MONTHLY SALES FILE FROM DBEAVER
ALTER TABLE polish_store.newmonthlysalesbyproduct
RENAME TO polish_store.monthly_sales_by_product;

-- VERIFY THAT ALL RECORDS WERE UPLOADED TO THE TABLE
SELECT COUNT(*) AS 'RecordCount' FROM polish_store.monthly_sales_by_product;

-- CREATE PRODUCTS TABLE
SELECT * FROM polish_store.monthly_sales_by_product LIMIT 10;

-- LOCATE UNIQUE PRODUCT VALUES FROM SALES TABLE
SELECT DISTINCT polish_store.monthly_sales_by_product.Product_Id_Num FROM polish_store.monthly_sales_by_product ORDER BY polish_store.monthly_sales_by_product.Product_Id_Num;


-- VERIFY WE DO NOT HAVE ANY PRODUCT IDs WITH DIFFERENT PRODUCT NAMES IN THE MONTHLY SALES DATA.
-- IT SEEMS LIKE WE DO NOT HAVE ANY WRONG PRODUCT NAMES.
SELECT 
	polish_store.monthly_sales_by_product.Product_Id_Num, COUNT(DISTINCT polish_store.monthly_sales_by_product.Product_name) AS UniqueProductNames
FROM
	polish_store.monthly_sales_by_product
GROUP BY 
	polish_store.monthly_sales_by_product.Product_Id_Num
HAVING UniqueProductNames > 1;


-- CREATE TEMP TABLE. 
-- I SELECTED THE BASIC COLUMNS, I WILL NOT ADD COLUMNS SUCH AS AVG PURCHASE AND SALE PRICE AS THEY CHANGE CONSTANTLY.

SELECT 
	ps.Product_Id_Num,
    MAX(ps.Product_name) AS ProductName,
    MAX(ps.Product_group) AS ProductGroup
FROM
	polish_store.monthly_sales_by_product AS ps
GROUP BY
	ps.Product_Id_Num
ORDER BY
	ps.Product_Id_Num;


-- CREATE TABKE OF PRODUCTS
CREATE TABLE Products AS
SELECT 
	ps.Product_Id_Num,
    MAX(ps.Product_name) AS ProductName,
    MAX(ps.Product_group) AS ProductGroup
FROM
	polish_store.monthly_sales_by_product AS ps
GROUP BY
	ps.Product_Id_Num
ORDER BY
	ps.Product_Id_Num;



-- VERIFY NEW TABLE CREATION
SELECT * FROM polish_store.products;




