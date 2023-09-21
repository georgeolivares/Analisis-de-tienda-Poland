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
SELECT DISTINCT polish_store.monthly_sales_by_product.Product_Id_Num FROM polish_store.monthly_sales_by_product;

SELECT polish_store.monthly_sales_by_product.Product_Id_Num, 
polish_store.monthly_sales_by_product.Product_name, polish_store.monthly_sales_by_product.Product_group
FROM polish_store.monthly_sales_by_product
WHERE polish_store.monthly_sales_by_product.Product_Id_Num
IN (SELECT DISTINCT polish_store.monthly_sales_by_product.Product_Id_Num FROM polish_store.monthly_sales_by_product);




