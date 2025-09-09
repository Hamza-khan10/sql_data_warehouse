--CHECKING FOR NULL AND DUPLICATES
SELECT prd_id,
COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id is null;

--CHECK FOR UNWANTED SPACES
SELECT prd_nm 
from silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

SELECT prd_cost 
from silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

SELECT cst_key
from silver.crm_cust_info
WHERE cst_key != TRIM(cst_key);

--Data standardization & consistency
SELECT DISTINCT prd_line
from silver.crm_prd_info;

--Data standardization & consistency
SELECT DISTINCT cst_material_status
from silver.crm_cust_info;

--CHECK FOR INVALID DATE ORDERS
SELECT * FROM silver.crm_prd_info
Where prd_end_dt < prd_start_dt

SELECT 
prd_id,
prd_key,
prd_nm,
prd_start_dt,
--prd_end_dt,
LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)-1 AS prd_end_dt_test
FROM bronze.crm_prd_info
Where prd_key IN ('AC-HE-HL-U509-R','AC-HE-HL-U509');

--CHECK FOR INVALID DATE ORDERS
SELECT 
NULLIF(sls_due_dt,0)
FROM bronze.crm_sales_details
WHERE sls_due_dt <= 0 OR LEN(sls_due_dt) != 8

--CHECK FOR INVALID DATE ORDERS
SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt

SELECT DISTINCT
sls_sales,
sls_quantity,
sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
ORDER BY sls_sales,sls_quantity,sls_price;

--Identify out of range Dates
Select
	bdate
from silver.erp_cust_az12
Where bdate < '1924-1-1' OR bdate > GETDATE()
