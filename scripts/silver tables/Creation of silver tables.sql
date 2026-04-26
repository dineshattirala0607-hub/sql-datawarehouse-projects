use datawarehouse2026
create table silver.crm_cust_info 
(
 cst_id int ,
 cst_key varchar(100),
 cst_firstname varchar(100),
 cst_lastname varchar(100),
 cst_martial_status varchar(5),
 cst_gndr varchar(5),
 cst_create_date date
); 
go
use datawarehouse2026
create table silver.crm_prd_info 
(
 prd_id int ,
 prd_key varchar(100),
 prd_nm varchar(100),
 prd_cost int,
 prd_line varchar(5),
 prd_start_dt date,
 prd_end_dt date
);

go
use datawarehouse2026
create table silver.crm_sales_details 
(
 sls_ord_num varchar(100) ,
 sls_prd_key varchar(100),
 sls_cust_id int,
 sls_order_dt int,
 sls_ship_dt  int,
 sls_due_dt  int,
 sls_sales int,
 sls_quantity int,
 sls_price int
);
go
use datawarehouse2026
create table silver.erp_cust_az12 
(
 CID INT,
 BDATE DATE,
 GENDER VARCHAR(5)
);
go
use datawarehouse2026
create table silver.erp_loc_a101
(
 CID int,
 COUNTRY VARCHAR(50)
);
go
use datawarehouse2026
create table silver.erp_px_cat_g1v2
(
 ID int,
 CAT VARCHAR(50),
 SUBCAT VARCHAR(50),
 MAINTENANCE VARCHAR(20)
);