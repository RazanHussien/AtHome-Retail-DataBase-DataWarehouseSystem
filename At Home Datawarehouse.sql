-- SQL for Data Warehouse Tables

create database AtHome_DW;
use AtHome_DW;

create table calendar_dim (
CalendarKey INT not null auto_increment,
CalFullDate DATE not null,
CalDayOfWeek CHAR(10) not null,
CalDayOfMonth INT not null,
CalMnth CHAR(10) not null,
CalQtr CHAR(2) not null,
CalYr INT not null,
primary key (CalendarKey));

create table customer_dim (
CustomerKey INT not null auto_increment,
CustID VARCHAR(5) not null,
FirstName VARCHAR(20),
LastName VARCHAR(20),
CustAddress VARCHAR(100),
Gender CHAR(1),
MembLevelName VARCHAR(20),
primary key (CustomerKey));

create table product_dim (
ProductKey INT not null auto_increment,
SKU VARCHAR(20) NOT NULL,
ProductName VARCHAR(50),
ProductPrice NUMERIC(6 , 2 ),
CatName VARCHAR(20),
primary key (ProductKey));

create table sale_dim (
SaleKey INT not null auto_increment,
TransType VARCHAR(20) not null,
PaymentMethod VARCHAR(20) NOT NULL,
primary key (SaleKey));

create table supplier_dim (
SupplierKey INT not null auto_increment,
DCID CHAR(1) not null,
DCAddress VARCHAR(100),
ContactFirstName VARCHAR(20),
ContactLastName VARCHAR(20),
ContactPhone VARCHAR(12),
primary key (SupplierKey));

create table sales_fact (
SaleDate INT not null,
CustomerKey INT not null,
ProductKey INT not null,
SaleKey INT not null,
SalesAmount NUMERIC (7,2),
UnitsSold INT,
foreign key (SaleDate) references calendar_dim(CalendarKey),
foreign key (CustomerKey) references customer_dim(CustomerKey),
foreign key (ProductKey) references product_dim(ProductKey),
foreign key (SaleKey) references sale_dim(SaleKey));

create table inventory_fact (
OrderDate INT not null,
ArrivalDate INT not null,
SupplierKey INT not null,
ProductKey INT not null,
UnitsInStock INT,
foreign key (OrderDate) references calendar_dim(CalendarKey),
foreign key (ArrivalDate) references calendar_dim(CalendarKey),
foreign key (SupplierKey) references supplier_dim(SupplierKey),
foreign key (ProductKey) references product_dim(ProductKey));

show tables;

-- SQL for Inserting into Tables

create view CombinedDates as
select CombinedDate
from (
    select TransDate as CombinedDate from at_home.Sale
    union
    select OrderDate as CombinedDate from at_home.Supply
    union
    select ArrivalDate as CombinedDate from at_home.Supply) as CombinedDates
order by CombinedDate ASC;
select * from CombinedDates;

INSERT INTO calendar_dim (CalFullDate, CalDayOfWeek, CalDayOfMonth, CalMnth, CalQtr, CalYr)
select CombinedDate as CalFullDate, dayOfWeek(CombinedDate) as CalDayOfWeek, dayOfMonth(CombinedDate) as CalDayOfMonth,
    Month(CombinedDate) as CalMnth, Quarter(CombinedDate) as CalQtr, Year(CombinedDate) as CalYr
from CombinedDates
order by CalFullDate;

INSERT INTO customer_dim (CustID, FirstName, LastName, CustAddress, Gender, MembLevelName)
select CustID, FirstName, LastName, CustAddress, Gender, LevelName as MembLevelName
from at_home.Customer, at_home.Membership
where at_home.Customer.MemberID = at_home.Membership.MembershipID;

INSERT INTO product_dim (SKU, ProductName, ProductPrice, CatName)
select SKU, ProductName, Price as ProductPrice, CatName
from at_home.Product, at_home.Category
where at_home.Product.CatID = at_home.Category.CatID;

INSERT INTO sale_dim (TransType, PaymentMethod)
select TransType, PaymentMethod
from at_home.Sale
group by TransType, PaymentMethod;

INSERT INTO supplier_dim (DCID, DCAddress, ContactFirstName, ContactLastName, ContactPhone)
select *
from at_home.DistributionCenter;

create view SalesPreFact as
select TransDate, customer.CustID, TransType, PaymentMethod, product.SKU, sum(assoc.quantity) as UnitsSold, (product.Price * sum(assoc.quantity)) as SalesAmount
from at_home.Sale as sale, at_home.Customer as customer, at_home.Product as product, at_home.Associated as assoc
where sale.TransNumber = assoc.TransNumber and
    sale.CustID = customer.CustID and
	product.SKU = assoc.SKU
group by TransDate, customer.CustID, TransType, PaymentMethod, product.SKU;

create view SalesAlmostFact as
select CalendarKey as SaleDate, CustomerKey, SaleKey, ProductKey, sum(UnitsSold) as UnitsSold, sum(SalesAmount) as SalesAmount
from calendar_dim, customer_dim, sale_dim, product_dim, SalesPreFact as SP
where calendar_dim.CalFullDate = SP.TransDate and
    customer_dim.CustID = SP.CustID and
	concat(sale_dim.TransType, sale_dim.PaymentMethod) = concat(SP.TransType, SP.PaymentMethod) and
	product_dim.SKU = SP.SKU
group by SaleDate, CustomerKey, SaleKey, ProductKey;

INSERT INTO sales_fact (SaleDate, CustomerKey, SaleKey, ProductKey, UnitsSold, SalesAmount)
select*
from SalesAlmostFact;

create view InvPreFact as
select OrderDate, ArrivalDate, DC.DCID, product.SKU, sum(supply.quantity) as UnitsInStock
from at_home.Supply as supply, at_home.Product as product, at_home.DistributionCenter as DC
where DC.DCID = supply.DCID and
    product.SKU = supply.SKU
group by OrderDate, ArrivalDate, DC.DCID, product.SKU;

INSERT INTO inventory_fact (OrderDate, ArrivalDate, SupplierKey, ProductKey, UnitsInStock)
select c1.CalendarKey as OrderDate, c2.CalendarKey as ArrivalDate, SupplierKey, ProductKey, UnitsInStock
from calendar_dim as c1, calendar_dim as c2, supplier_dim, product_dim, InvPreFact as IP
where c1.CalFullDate = IP.OrderDate and
    c2.CalFullDate = IP.ArrivalDate and
	supplier_dim.DCID = IP.DCID and
	product_dim.SKU = IP.SKU
group by c1.CalendarKey, c2.CalendarKey, SupplierKey, ProductKey;

select * from calendar_dim;
select * from customer_dim;
select * from sale_dim;
select * from product_dim;
select * from supplier_dim;
select * from sales_fact;
select * from inventory_fact;



-- SQL for Analytical Queries

-- Query 1: Stock on Hand

select ProductName, (sum(UnitsInStock) - sum(UnitsSold)) as UnitsOnHand
from product_dim as pd, inventory_fact as inv, sales_fact as sf
where pd.ProductKey = inv.ProductKey and
    pd.ProductKey = sf.ProductKey
group by ProductName
order by UnitsOnHand asc;

-- Query 2: average sales in dollars by customer gender

select Gender, CalDayOfWeek as DayOfWeek, avg(SalesAmount) as 'Average Sales'
from customer_dim, sales_fact, calendar_dim
where customer_dim.CustomerKey = sales_fact.CustomerKey and
    sales_fact.SaleDate = calendar_dim.CalendarKey
group by Gender, CalDayOfWeek
order by CalDayOfWeek asc;

-- Query 3: average orders by product and distribution center

select DCID, ProductName, avg(UnitsInStock) as UnitsOrdered
from supplier_dim, product_dim, inventory_fact
where product_dim.ProductKey = inventory_fact.ProductKey and
    supplier_dim.SupplierKey = inventory_fact.SupplierKey
group by DCID, ProductName;

