-- USE DATABASE
USE polish_store;

-- VERIFY DATA IS CORRECT
SELECT * FROM daily_sales;

-- UPLOADED MONTHLY SALES FILE FROM DBEAVER
ALTER TABLE polish_store.newmonthlysalesbyproduct
RENAME TO polish_store.montly_sales_by_product;

-- VERIFY THAT ALL RECORDS WERE UPLOADED TO THE TABLE
SELECT COUNT(*) AS 'RecordCount' FROM polish_store.montly_sales_by_product;