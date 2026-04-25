/*============================================================================================
-- Created stored procedure to perform Full load  for bronze layer (Truncate and load ) 
==============================================================================================*/

create or alter procedure bronze.raw_load as
begin
truncate table bronze.crm_cust_info 
bulk insert bronze.crm_cust_info 
from 'C:\Users\dinesh gowd\Documents\SQL Server Management Studio 22\datasets\source_crm\cust_info.csv'
with (
firstrow = 2,
fieldterminator = ',',
tablock 
);
truncate table bronze.crm_prd_info
bulk insert bronze.crm_prd_info 
from 'C:\Users\dinesh gowd\Documents\SQL Server Management Studio 22\datasets\source_crm\prd_info.csv'
with (
firstrow = 2,
fieldterminator = ',',
tablock 
) 
truncate table bronze.crm_sales_details
bulk insert bronze.crm_sales_details 
from 'C:\Users\dinesh gowd\Documents\SQL Server Management Studio 22\datasets\source_crm\sales_details.csv'
with (
firstrow = 2,
fieldterminator = ',',
tablock 
);
truncate table bronze.erp_cust_az12
bulk insert bronze.erp_cust_az12 
from 'C:\Users\dinesh gowd\Documents\SQL Server Management Studio 22\datasets\source_erp\CUST_AZ12.csv'
with (
firstrow = 2,
fieldterminator = ',',
tablock 
);
truncate table bronze.erp_loc_a101
bulk insert bronze.erp_loc_a101 
from 'C:\Users\dinesh gowd\Documents\SQL Server Management Studio 22\datasets\source_erp\LOC_A101.csv'
with (
firstrow = 2,
fieldterminator = ',',
tablock 
);
truncate table bronze.erp_px_cat_g1v2
bulk insert bronze.erp_px_cat_g1v2 
from 'C:\Users\dinesh gowd\Documents\SQL Server Management Studio 22\datasets\source_erp\PX_CAT_G1V2.csv'
with (
firstrow = 2,
fieldterminator = ',',
tablock 
);
end

/*============================================================
-- to check the data populating correct or not. Safe check
===============================================================*/

select count(*) from bronze.crm_cust_info
select count(*) from bronze.crm_prd_info
select count(*) from bronze.crm_sales_details
select count(*) from bronze.erp_cust_az12
select count(*) from bronze.erp_loc_a101
select count(*) from bronze.erp_px_cat_g1v2
