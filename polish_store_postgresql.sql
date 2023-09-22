
--CSV DATA IMPORTED USING IMPORT WIZARD

--VERIFY DATA WAS IMPORTED CORRECTLY
select * from monthly_sales;

select * from daily_sales;


--VERIFY ALL 23180 RECORDS WERE IMPORTED
SELECT COUNT(*) AS "RecordCount" FROM monthly_sales;

--LOCATE UNIQUE PRODUCT VALUES FROM SALES TABLE
SELECT DISTINCT product_id_num FROM monthly_sales ORDER BY product_id_num;


-- VERIFY WE DO NOT HAVE ANY PRODUCT IDs WITH DIFFERENT PRODUCT NAMES IN THE MONTHLY SALES DATA.
-- IT SEEMS LIKE WE DO NOT HAVE ANY WRONG PRODUCT NAMES.
SELECT 
	product_id_num, COUNT(DISTINCT product_name) AS UniqueProductNames
FROM
	monthly_sales
GROUP BY 
	Product_Id_Num
HAVING COUNT(DISTINCT product_name) > 1;


-- CREATE TEMP TABLE. 
-- I SELECTED THE BASIC COLUMNS, I WILL NOT ADD COLUMNS SUCH AS AVG PURCHASE AND SALE PRICE AS THEY CHANGE CONSTANTLY.
SELECT 
	ps.Product_Id_Num,
    MAX(ps.Product_name) AS ProductName,
    MAX(ps.Product_group) AS ProductGroup
FROM
	monthly_sales AS ps
GROUP BY
	ps.Product_Id_Num
ORDER BY
	ps.Product_Id_Num;


-- CREATE TABLE OF PRODUCTS
CREATE TABLE Products AS
SELECT 
	ps.Product_Id_Num,
    MAX(ps.Product_name) AS ProductName,
    MAX(ps.Product_group) AS ProductGroup
FROM
	monthly_sales AS ps
GROUP BY
	ps.Product_Id_Num
ORDER BY
	ps.Product_Id_Num;


-- VERIFY NEW TABLE CREATION
SELECT * FROM products;


-- SET THE PRIMARY KEY FOR TABLE PRODUCTS
ALTER TABLE products 
ADD CONSTRAINT product_id_num
PRIMARY KEY(product_id_num);


-- CONFIRM PRIMARY KEY WAS SET
SELECT conname, conrelid::regclass, contype
FROM pg_catalog.pg_constraint;


-- SET FOREIGN KEY REFERENCING RELATED PRODUCT
ALTER TABLE monthly_sales
ADD CONSTRAINT product_id_num
FOREIGN KEY (product_id_num) 
REFERENCES products (product_id_num);


-- CONFIRM FOREIGN KEY WAS SET
SELECT conname, conrelid::regclass, contype
FROM pg_catalog.pg_constraint;



-- TABLE INFORMATION
SELECT column_name, data_type, is_nullable
FROM information_schema.COLUMNS
WHERE table_name = 'products';






