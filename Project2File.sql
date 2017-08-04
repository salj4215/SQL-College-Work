/*
	Project2 sql file.
	Date created: 12/10/2016
	Date revised: 12/15/2016
	Name: Salleh Jahaf
*/
use master

if DB_ID('CIS11170_P2_SJ') IS NOT NULL --if database exists, drop database
	DROP database CIS11170_P2_SJ

create database CIS11170_P2_SJ --create database
GO

use CIS11170_P2_SJ

if OBJECT_ID('Employees') is not null --if Employees table exists, drop table
	drop table Employees

create table Employees --create Employees table
(EmployeeID int not null identity Primary key,
 Job varchar(50) not null,
 Name varchar(20) not null,
 [Works for EmpID] int null,
 [Part or Full Time] char(1) not null,
 Salary varchar(15) null
)

if OBJECT_ID('StoreItems') is not null --if table exists, drop table
	drop table StoreItems

create table StoreItems --create table
(ItemID	INT	NOT NULL IDENTITY PRIMARY KEY,
 Description varchar(20) not null,
 Manufacturer varchar(30) not null,
 PurchasePrice varchar(20),
 SalePrice varchar(20),
 Owner INT not null References Employees(EmployeeID)
)

if OBJECT_ID('ItemStock') is not null  --create the rest of the tables
	drop table ItemStock

create table ItemStock
(ItemID INT not null identity Primary Key references StoreItems(ItemID),
 ItemsOnHand Int not null check (ItemsonHand >= 0),
 MfgItemNumber varchar(15) not null,
 WeeklyOrder INT not null check (WeeklyOrder >= 0)
)

if OBJECT_ID('StoreEquipment') is not null
	drop table StoreEquipment

create table StoreEquipment
(EquipmentID Int not null Identity Primary Key,
 Description varchar(20) not null,
 [InitialCost($)] decimal not null check ([InitialCost($)] >= 0) ,
 [Age(months)] int not null check ([Age(months)] >= 0) ,
 Owner int not null references Employees(EmployeeID)
)

if OBJECT_ID('EquipmentValue') is not null
	drop table EquipmentValue

create table EquipmentValue
(EquipmentID int not null Identity Primary key references StoreEquipment(EquipmentID),
 [CurrentValue($)] money not null check ([CurrentValue($)] >= 0) ,
 AnnualDepreciation decimal(10,2) not null check (AnnualDepreciation >= 0)
)


if OBJECT_ID('EmployeeInfo') is not null
	drop table EmployeeInfo

create table EmployeeInfo
(EmployeeID int not null identity Primary key references Employees(EmployeeID),
 FirstName varchar(20) not null,
 LastName varchar(30) not null,
 Address varchar(50) not null,
 City varchar(30) not null,
 Zip varchar(10) not null,
 PhoneNumber varchar(13) not null
)
go 

--insert records into created tables
Insert Employees values ('Owner','Salleh',null,'F',null)
Insert Employees values ('Shift 1 Supervisor', 'Bob',1,'F','$12.00/Hr')
Insert Employees values ('Shift 2 Supervisor', 'Mike',1,'F','$11.00/Hr')
Insert Employees values ('Worker 1', 'Mark',3,'F','$8.00/Hr')
Insert Employees values ('Worker 2', 'Annetta',2,'F','$8.00/Hr')
Insert Employees values ('Accountant', 'Andrew',1,'P','$12.00/Hr')
Insert Employees values ('Cashier', 'Will',2,'P','$7.50/Hr')
Insert Employees values ('Cashier', 'Sue',3,'P','$7.50/Hr')
Insert Employees values ('Cashier', 'Dave',2,'P','$7.50/Hr')
Insert Employees values ('Cashier', 'Shannon',3,'P','$7.50/Hr')

Insert StoreItems values ('Corn Flakes','Cisco','1.29/box','2.35/box',1)
Insert StoreItems values ('Shawarma','Bakery World','0.50/lb','1.25/lb',1)
Insert StoreItems values ('Bebsi','Soda Unlimited','0.28/liter','1.00/liter',1)
Insert StoreItems values ('Baked Beans','Bush','1.33/can','2.77/can',1)
Insert StoreItems values ('Matches','AtlasMatches','0.58/box','1.50/box',1)
Insert StoreItems values ('Bread white','Wonderbread','0.65/loaf','1.20/loaf',1)
Insert StoreItems values ('Hamburger Buns','Wonderbread','0.63/loaf','1.25/loaf',1)
Insert StoreItems values ('Hamburgers','Wolverine','0.25/lb','1.25/lb',1)
Insert StoreItems values ('Potato Chips','BetterMade','0.97/bag','1.50/bag',1)
Insert StoreItems values ('Hummus','Kawsan Market','0.75/lb','1.25/lb',1)

Insert ItemStock values (50,'10050',13)
Insert ItemStock values (50,'17651',13)
Insert ItemStock values (50,'28457',13)
Insert ItemStock values (50,'91245',13)
Insert ItemStock values (50,'87452',13)
Insert ItemStock values (50,'54321',10)
Insert ItemStock values (50,'54801',10)
Insert ItemStock values (50,'21547',10)
Insert ItemStock values (50,'12574',10)
Insert ItemStock values (50,'28754',10)

Insert StoreEquipment values ('Refrigerator',500,12,1)
Insert StoreEquipment values ('Refrigerator',500,12,1)
Insert StoreEquipment values ('Cash register',200,12,1)
Insert StoreEquipment values ('Cash register',150,6,1)
Insert StoreEquipment values ('Shelving unit',1000,12,1)
Insert StoreEquipment values ('Alarm system',2500,12,1)

Insert EquipmentValue values (400,0.2)
Insert EquipmentValue values (400,0.2)
Insert EquipmentValue values (160,0.2)
Insert EquipmentValue values (135,0.2)
Insert EquipmentValue values (800,0.2)
Insert EquipmentValue values (2000,0.2)

Insert EmployeeInfo values ('Salleh','Jahaf','123 Main St', 'Cedar', '99123','555-555-1234')
Insert EmployeeInfo values ('Bob','Smith','111 First St', 'Cedar', '99123','555-555-2345')
Insert EmployeeInfo values ('Mike','Martin','123 Main St', 'Cedar', '99123','555-555-1234')
Insert EmployeeInfo values ('Mark','Wall','123 Main St', 'Cedar', '99123','555-555-1234')
Insert EmployeeInfo values ('Annetta','Johnson','123 Main St', 'Cedar', '99123','555-555-1234')
Insert EmployeeInfo values ('Andrew','Buchanon','123 Main St', 'Cedar', '99123','555-555-1234')
Insert EmployeeInfo values ('Will','Jackson','123 Main St', 'Cedar', '99123','555-555-1234')
Insert EmployeeInfo values ('Sue','Brown','123 Main St', 'Cedar', '99123','555-555-1234')
Insert EmployeeInfo values ('Dave','White','123 Main St', 'Cedar', '99123','555-555-1234')
Insert EmployeeInfo values ('Shannon','Green','123 Main St', 'Cedar', '99123','555-555-1234')

--create stored procedure StockValue
if OBJECT_ID('spStockValue') is not null
	drop proc spStockValue
go

Create proc spStockValue
	@MfgName varchar(20) = '%' --takes in a parameter of manufacturer's name
as
Select Description, convert(decimal(10,2),left(PurchasePrice, charindex('/',PurchasePrice,0)-1)) * I.ItemsOnHand StockValue --StockValue column calculates total value of stock based on @MfgName and seperates by description
from StoreItems S
Join ItemStock I
on S.ItemID = I.ItemID
where Manufacturer like @MfgName

go

if OBJECT_ID('Payroll') is not null
	drop view Payroll

go

create view Payroll --Payroll view
as
Select E.Name, Em.Name as Supervisor,
case
when E.[Part or Full Time] = 'F' then convert(decimal(10,2),substring(E.Salary,2,CHARINDEX('/',E.Salary)-2)) * 40 * 52 --calculates yearly salary for Full time employees
when E.[Part or Full Time] = 'P' then convert(decimal(10,2),substring(E.Salary,2,CHARINDEX('/',E.Salary)-2)) * 20 * 52 --calculates yearly salary for part time employees
end YearlyPay
from Employees E join Employees Em --joins table to itself.
on E.[Works for EmpID] = Em.EmployeeID --joins on these two columns. each EmpID in Works for EmpID column is matched to the employee id of the supervisors and owner and prints their name

go

if OBJECT_ID('AssetInventory') is not null
	drop view AssetInventory

go

create view AssetInventory --AssetInventory view
as
Select Description, [CurrentValue($)],DatePart(year,Dateadd(year, 1/AnnualDepreciation, getDate())) as TotalDepreciationInYear
from EquipmentValue E join StoreEquipment S                      --1/AnnualDepreciation will calculate amount of years assets will completely depreciate in value. 20% every year will take 5 years.
on E.EquipmentID = S.EquipmentID

go

--Create trigger that catches insert statements for worker's pay. Supervisor pay must be entered as a yearly sum, non-supervisors as an hourly amount
Create TRIGGER Employees_INSERT
on Employees
After Insert
as
If Exists (Select * from inserted
			Where (job like '%Supervisor' and Salary not like '%/Year') or (Job not like '%Supervisor' and Salary like '%/Year'))
	begin
		;
		Throw 50001, 'Supervisor pay must be entered as a yearly sum ($#####/Year) and non-Supervisor pay must be entered as an hourly amount',1
		rollback tran
	end;