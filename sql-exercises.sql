/*1. Write a query to return all category names with their descriptions from the Categories table.*/
select CategoryName, Description from Categories
/*2. Write a query to return the contact name, customer id, company name and city name of all Customers in London*/
select ContactName, CustomerID, CompanyName, City from Customers where City = 'London'
/*3. Write a query to return all available columns in the Suppliers tables for the marketing managers and sales representatives that have a FAX number*/
select * from Suppliers where (ContactTitle = 'Marketing Manager' or ContactTitle = 'Sales Representative') and Fax is not null
/*4. Write a query to return a list of customer id's from the Orders table with required dates between Jan 1, 1997 and Dec 31, 1997 and with freight under 100 units.*/
select CustomerID from Orders where RequiredDate between '1997-01-01' and '1997-12-31' and Freight < 100
/*5. Write a query to return a list of company names and contact names of all customers from Mexico, Sweden and Germany.*/
select CompanyName, ContactName from Customers where Country = 'Mexico' or Country = 'Sweden' or Country = 'Germany'
/*6. Write a query to return a count of the number of discontinued products in the Products table.*/
select count(Discontinued) from Products where Discontinued = 1
/*7. Write a query to return a list of category names and descriptions of all categories beginning with 'Co' from the Categories table.*/
select CategoryName, Description from Categories where CategoryName like 'Co%'
/*8. Write a query to return all the company names, city, country and postal code from the Suppliers table with the word 'rue' in their address. The list should ordered alphabetically by company name.*/
select CompanyName, City, Country, PostalCode from Suppliers where Address like '%rue%' order by CompanyName
/*9. Write a query to return the product id and the quantity ordered for each product labelled as 'Quantity Purchased' in the Order Details table ordered by the Quantity Purchased in descending order.*/
select ProductID, Quantity AS 'Quantity Purchased' from [Order Details] order by -Quantity
/*10. Write a query to return the company name, address, city, postal code and country of all customers with orders that shipped using Speedy Express, along with the date that the order was made.*/
/*select CompanyName, Address, City, PostalCode, Country from Customers where */
select c.CompanyName, c.Address, c.City, c.PostalCode, c.Country, o.OrderDate
from Customers c
inner join Orders o
on o.CustomerID=c.CustomerID
where ShipVia = 1 order by OrderDate
/*11. Write a query to return a list of Suppliers containing company name, contact name, contact title and region description.*/
select Suppliers.CompanyName, Suppliers.ContactName, Suppliers.ContactTitle, Suppliers.Region
from Suppliers
/*12. Write a query to return all product names from the Products table that are condiments.*/
select ProductName from Products where CategoryID = 2
/*13. Write a query to return a list of customer names who have no orders in the Orders table.*/
select ContactName
from Customers
where Customers.CustomerID
not in (select CustomerID from Orders)
/*14. Write a query to add a shipper named 'Amazon' to the Shippers table using SQL.*/
insert into Shippers(CompanyName)
values('Amazon')
select * from Shippers
/*15. Write a query to change the company name from 'Amazon' to 'Amazon Prime Shipping' in the Shippers table using SQL.*/
update Shippers
set CompanyName='Amazon Prime Shipping'
where CompanyName='Amazon';
/*16. Write a query to return a complete list of company names from the Shippers table. Include freight totals rounded to the nearest whole number for each shipper from the Orders table for those shippers with orders.*/
select Orders.ShipName, convert(int,round(sum(Orders.Freight), 0))
as 'Freight Totals'
from Shippers
inner join Orders
on Orders.ShipVia = Shippers.ShipperID
group by Orders.ShipName
/*17. Write a query to return all employee first and last names from the Employees table
by combining the 2 columns aliased as 'DisplayName'. The combined format should be
'LastName, FirstName'.*/
SELECT LastName + ', ' + FirstName 
as 'DisplayName' 
FROM Employees
/*18. Write a query to add yourself to the Customers table with an order for 'Grandma's
Boysenberry Spread=product ID of 6'.*/
insert into Customers(ContactName, CustomerID, CompanyName, ContactTitle, Address,
City, Region, PostalCode, Country, Phone, Fax)
values('Alex McElroy', 'ALEMC', 'Unsure', 'Hmmm', 'Somewhere', 'InAPlace', 'West',
92111, 'USA', 000-000-0000, 111-111-1111)

insert into Orders(EmployeeID, CustomerID, OrderDate, RequiredDate, ShippedDate,
ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
values(10, (select CustomerID from Customers where ContactName = 'Alex McElroy'), '2016-12-01', '2016-12-02', '2016-12-01', 
3, 9500, 'El Spectacular', '100 Boisonberry Lane', 'San Diego', NULL, 92111, 'USA')

insert into [Order Details](OrderID, ProductID, UnitPrice, Quantity, Discount)
values((select OrderID from Orders where OrderDate = '2016-12-01' and Freight = 9500), 6, 20.00, 900, .99)
/*19. Write a query to remove yourself and your order from the database.*/
delete from [Order Details]
where OrderDate = '2016-12-01' and Freight = 9500

delete from Orders
where CustomerID = 'ALEMC'

delete from Customers
where CustomerID = 'ALEMC'
/*20. Write a query to return a list of products from the Products table along with the
total units in stock for each product. Include only products with TotalUnits greater
than 100.*/
select ProductName, UnitsInStock
from Products
where UnitsInStock > 100