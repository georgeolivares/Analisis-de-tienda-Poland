
--Data imported from monthly_sales csv using Wizard.
--CSV is the result of the previous data cleaning data.

SELECT * FROM polish_store.monthly_sales;


--Verify all 23180 records were imported. This was confirmed.

SELECT COUNT(*) FROM polish_store.monthly_sales;


--Data imported from daily_sales csv using Wizard.
--CSV is, just as the last file, the result of the previous data cleaning python process.

SELECT * FROM polish_store.daily_sales;

--Verify all 361 rows were imported. This was confirmed.

SELECT COUNT(*) FROM polish_store.daily_sales;

--Confirm both imported tables belong to the same schema "Polish Store".
--Both tables do belong to the same polish_store schema.

SELECT name, schema_id FROM sys.tables;


SELECT name, schema_id 
FROM sys.schemas s 
WHERE s.name LIKE '%polish%';


SELECT t.name AS table_name,
s.name AS schema_name
FROM sys.tables t
INNER JOIN sys.schemas s ON t.schema_id = s.schema_id;


--I will create a new 'Products' table with the unique values from the montly sales table.
--I will first verify each product id includes a single consistent product name related.
--No product IDs related to more than 1 unique product name.
SELECT Product_Id_Num, COUNT(DISTINCT Product_name) 
FROM polish_store.monthly_sales
GROUP BY Product_Id_Num
HAVING COUNT(DISTINCT Product_name) > 1;


--Use the following statement to create a products table.
SELECT Product_Id_Num,
MAX(Product_name),
MAX(Product_group)
FROM polish_store.monthly_sales
GROUP BY Product_Id_Num
ORDER BY Product_Id_Num;


--Create Products table
SELECT Product_Id_Num,
MAX(Product_name) AS product_name,
MAX(Product_group) AS product_group
INTO polish_store.products
FROM polish_store.monthly_sales
GROUP BY Product_Id_Num
ORDER BY Product_Id_Num;


--Verify data was correctly inserted into the new table

SELECT * FROM polish_store.products;


SELECT * FROM polish_store.monthly_sales


--Set primary key for products table

ALTER TABLE polish_store.products 
ADD CONSTRAINT product_id_num
PRIMARY KEY(product_id_num);


--Set foreign key for monthly sales table related to the product

ALTER TABLE polish_store.monthly_sales
ADD CONSTRAINT FK_Product_Id_Num
FOREIGN KEY (Product_Id_Num) REFERENCES polish_store.products(Product_Id_Num);














