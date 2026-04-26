/*===================================================
data quality checks
=====================================================*/

select cst_id,count(*) from silver.crm_cust_info group by cst_id having count(*) > 1 or cst_id is null

select * from silver.crm_cust_info where cst_lastname != trim(cast(cst_lastname as nvarchar))

select * from silver.crm_cust_info where cst_firstname != trim(cast(cst_firstname as nvarchar))

/*==================================================
Query for loading data into silver tables
===================================================*/
select cst_id,cst_key,
trim(cst_firstname) as first_name,
trim(cst_lastname) as last_name,
case 
when cst_gndr = upper(trim('M')) then 'Men'
when cst_gndr = upper(trim('F')) then 'Women'
else 'N/A' 
end as Gender,cst_create_date,
case 
when cst_martial_status = upper(trim('S')) then 'Single'
when cst_martial_status = upper(trim('M')) then 'Married'
else 'N/A' 
end as Martial_status,cst_create_date
from (
select *,ROW_NUMBER() over(partition by cst_id order by cst_create_Date desc ) as rn
from bronze.crm_cust_info) t 
where rn = 1

/*==============================================================================
inserting cleansed data into table
=================================================================================*/
insert into silver.crm_cust_info ([cst_id],[cst_key]
      ,[cst_firstname]
      ,[cst_lastname]
      ,[cst_martial_status]
      ,[cst_gndr]
      ,[cst_create_date])

select cst_id,cst_key,
trim(cst_firstname) as first_name,
trim(cst_lastname) as last_name,
case 
when cst_martial_status = upper(trim('S')) then 'Single'
when cst_martial_status = upper(trim('M')) then 'Married'
else 'N/A' 
end as Martial_status,
case 
when cst_gndr = upper(trim('M')) then 'Men'
when cst_gndr = upper(trim('F')) then 'Women'
else 'N/A' 
end as Gender,cst_create_date
from (
select *,ROW_NUMBER() over(partition by cst_id order by cst_create_Date desc ) as rn
from bronze.crm_cust_info) t 
where rn = 1

/*================================================================================================
inserting data into prd_info tables in silver schema
===================================================================================================*/

insert into silver.crm_prd_info ([prd_id],cat_id,[prd_key]
      ,[prd_nm]
      ,[prd_cost]
      ,[prd_line]
      ,[prd_start_dt]
      ,[prd_end_dt])

select prd_id,replace(SUBSTRING(prd_key,1,5), '-' ,'_')  as cat_id,
SUBSTRING(prd_key,7,len(prd_key)) as prd_key,
prd_nm,coalesce(prd_cost,0) as prd_cost,
case 
when upper(trim(prd_line)) = 'M' then 'Mountain'
when upper(trim(prd_line)) = 'R' then 'Road'
when upper(trim(prd_line)) = 'S' then 'Other Sale'
when upper(trim(prd_line)) = 'T' then 'Touring'
else 'N/A'
end as prd_line,
cast(prd_start_dt as date) as prd_start_dt,
DATEADD(day,-1,lead(prd_start_dt) over (partition by prd_key order by prd_start_dt)) as prd_end_dt
from bronze.crm_prd_info

/*========================================================================================================================
creating table by dropping it, if data is existed in the table
=========================================================================================================================*/
 if object_id ('silver.crm_sales_details','u') is not null
  drop table silver.crm_sales_Details;
  create table silver.crm_sales_Details
  (
  sls_ord_num varchar(100) ,
 sls_prd_key varchar(100),
 sls_cust_id int,
 sls_order_dt date,
 sls_ship_dt  date,
 sls_due_dt  date,
 sls_sales int,
 sls_quantity int,
 sls_price int,
 dwh_create_date datetime2 default getdate()
 );

 /*======================================================================================================================================
 inserting query for silver.crm_sales_details
 =======================================================================================================================================*/
 insert into silver.crm_sales_Details([sls_ord_num]
      ,[sls_prd_key]
      ,[sls_cust_id]
      ,[sls_order_dt]
      ,[sls_ship_dt]
      ,[sls_due_dt]
      ,[sls_sales]
      ,[sls_quantity]
      ,[sls_price])
SELECT
sls_ord_num, sls_prd_key,
sls_cust_id,
CASE WHEN sls_order_dt = 0 OR LEN(sls_order_dt) != 8 THEN NULL
ELSE CAST(CAST (sls_order_dt AS VARCHAR) AS DATE)
END AS sis_order_dt,

CASE WHEN sls_ship_dt =0 OR LEN(sls_ship_dt) != 8 THEN NULL
ELSE CAST (CAST (sls_ship_dt AS VARCHAR) AS DATE)
END AS sls_ship_dt,

CASE WHEN sls_due_dt = 0 OR LEN(sls_due_dt) != 8 THEN NULL
ELSE CAST(CAST (sls_due_dt AS VARCHAR) AS DATE)
END AS sls_due_dt,

CASE WHEN sls_sales IS NULL OR sls_sales <=0 OR sls_sales != sls_quantity * ABS(sls_price)
THEN sls_quantity * ABS (sls_price)
else sls_price
end as sls_sales,
sls_quantity,
case when sls_price is null or sls_price <=0
then sls_price/nullif(sls_quantity,0)
else sls_price 
end as sls_price 
from bronze.crm_sales_details

