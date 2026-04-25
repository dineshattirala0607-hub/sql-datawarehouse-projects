bulk insert bronze.crm_cust_info 
from 'C:\Users\dinesh gowd\Documents\SQL Server Management Studio 22\datasets\source_crm\cust_info.csv'
with (
firstrow = 2,
fieldterminator = ',',
tablock 
) 

bulk insert bronze.crm_prd_info 
from 'C:\Users\dinesh gowd\Documents\SQL Server Management Studio 22\datasets\source_crm\prd_info.csv'
with (
firstrow = 2,
fieldterminator = ',',
tablock 
) 
bulk insert bronze.crm_sales_details 
from 'C:\Users\dinesh gowd\Documents\SQL Server Management Studio 22\datasets\source_crm\sales_details.csv'
with (
firstrow = 2,
fieldterminator = ',',
tablock 
) 
bulk insert bronze.erp_cust_az12 
from 'C:\Users\dinesh gowd\Documents\SQL Server Management Studio 22\datasets\source_erp\CUST_AZ12.csv'
with (
firstrow = 2,
fieldterminator = ',',
tablock 
) 
bulk insert bronze.erp_loc_a101 
from 'C:\Users\dinesh gowd\Documents\SQL Server Management Studio 22\datasets\source_erp\LOC_A101.csv'
with (
firstrow = 2,
fieldterminator = ',',
tablock 
) 
bulk insert bronze.erp_px_cat_g1v2 
from 'C:\Users\dinesh gowd\Documents\SQL Server Management Studio 22\datasets\source_erp\PX_CAT_G1V2.csv'
with (
firstrow = 2,
fieldterminator = ',',
tablock 
) 


