
/*======================================================================================
--creating a database 
Message : We creating database and schema for our data warehouse projects 
Warning : This is the intial step of creating database so it is used for just one time go
=========================================================================================*/

create database datawarehouse2026

/*==========================================================
--using created database and creating schema's for our project 
=============================================================*/

use datawarehouse2026
go
/*===========================================
--creating a bronze schema 
=================================================*/
create schema bronze
go
/*===========================================
--creating a silver schema
=================================================*/
create schema silver
go
/*===========================================
--creating a gold schema
=================================================*/
create schema gold