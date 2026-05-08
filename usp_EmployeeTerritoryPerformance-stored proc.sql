use Northwind
go
alter procedure usp_EmployeeTerritoryPerformance as  

begin 
 declare @Region VARCHAR(50), @MinOrderCount INT
 set @Region = 'WA' 
 set @MinOrderCount = 1
 begin try 
       
with terrorc as (select top 5 e.EmployeeID as EmployeeID,

isnull(concat(e.firstname,' ',e.lastname),'unknown') as EmployeeFullName,

E.Title,

E.Region,

replace(replace(replace(replace(e.HomePhone,'(',''),')',''),',',''),' ','') as masked_phone,

COUNT(DISTINCT et.TerritoryID) AS TerritoryCount,

COUNT(DISTINCT C.customerID) AS TotalCustomersHandled,

COUNT(DISTINCT o.OrderID) as TotalOrders,

SUM((od.UnitPrice * od.Quantity) * (1 - od.Discount)) as TotalSales,

avg((od.UnitPrice * od.Quantity) * (1 - od.Discount)) as AverageOrderValue, 

case 
when COUNT(DISTINCT o.OrderID) > 100 then 'Elite Performer'
when COUNT(DISTINCT o.OrderID) between 50 and 100 then 'Strong performer'
else 'Developing'
end as PerformanceStatus,

max(o.orderdate) as LastOrderDate,

datediff(day, o.orderdate, getdate()) as DaysSinceLastOrder,

row_number() over (order by SUM((od.UnitPrice * od.Quantity) * (1 - od.Discount)) desc) as  SalesRank 

from employees e

inner join EmployeeTerritories et on

e.employeeid = et.employeeid

inner join Territories t on

et.TerritoryID = t.TerritoryID

inner join region r on

t.regionid = r.regionid

inner join orders o 

on e.employeeid = o.EmployeeID

inner join [Order Details] od

on o.orderid = od.orderid

inner join customers c on 

o.CustomerID = c.CustomerID

where e.region =  @Region and e.FirstName is not null and e.LastName is not null

group by e.employeeid,e.firstname, e.lastname,

e.title,e.region,e.HomePhone,o.orderdate

having COUNT(DISTINCT o.OrderID) > @MinOrderCount

order by SUM((od.UnitPrice * od.Quantity) * (1 - od.Discount)) desc ) 

select * from terrorc where SalesRank <=5

end try 

begin catch

print 'error message' + error_message(); 

end catch 

end


