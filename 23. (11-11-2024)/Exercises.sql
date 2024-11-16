USE CostmOrder;
set sql_safe_updates = 0;
SET FOREIGN_KEY_CHECKS=0;

/****************************************************************/
/* Join                                      */
/****************************************************************/

-- 1- Listojme te gjithe suppliers me produktet e tyre
select s.CompanyName, p.ProductName
from supplier as s
inner join product as p on s.Id=p.SupplierId;

-- 2 - Order details and costumer details for eatch order
select o.OrderNumber, o.TotalAmount, c.FirstName, c.Phone
from ordder as o
inner join customer as c on o.CustomerId= c.Id
order by o.TotalAmount desc;

-- 3- oders me produktet, quantity dhe price
select o.OrderNumber, p.ProductName, oi.UnitPrice, oi.Quantity,o.TotalAmount
from ordder as o
inner join orderitem as oi on o.Id = oi.OrderId
inner join product as p on oi.ProductId = p.Id
order by o.OrderNumber;

/****************************************************************/
/* FUNKSIONET AGREGUESE                                         */
/****************************************************************/
-- 4- Statistic description table
select min(UnitPrice) as MinPrice, max(UnitPrice) as MaxPrice, avg(UnitPrice) as AvgPrice,min(Quantity) as MinQ, max(Quantity) as MaxQ
from orderitem;

/****************************************************************/
/* GROUP BY /Having                                                    */
/****************************************************************/
-- 5- Numri i klienetev sipas qyeteteve, nr>1 klient
select City, count(id) as NrKlient
from customer
group by city
having NrKlient > 1
order by NrKlient;

-- 6- Grupoj klientet sipas porosive dhe emrt e tyre

select c.FirstName, count(o.ID) as NrKlient
from ordder as o
inner join Customer as c on c.Id= o.CustomerId
group by c.Id
having NrKlient>1
order by NrKlient desc;

/****************************************************************/
/* EXISTS OPERATORI                                             */
/****************************************************************/

-- 7- Cila kompani ka bere ulje
select s.CompanyName, s.id
from supplier as s
where exists (select p.ProductName
				from product as p
                where s.Id=p.SupplierId and IsDiscontinued=1);
                
/****************************************************************/
/* CONTROL FLOW FUNCTION                                        */
/****************************************************************/
#IF()
#IFNULL()
#NULLIF()
#CASE

-- 8-Klasifiko price < 50, >=50

select ProductName, UnitPrice,
if (UnitPrice> 50, '>50', '<=50') as PriceClasf
from product
order by PriceClasf ;

-- 9- Zv fax=null me nr e telefonit
select CompanyName, Phone, Fax,
ifnull(Fax,Phone) as FaxPlote
from supplier;

-- 10- Krijoj nje kolone pa qyetetin london
select city,
nullif(City, 'London') as CityNoLond
from supplier;

-- 11- Ndaj unit proice low, medium, high
select ProductName, UnitPrice,
case 
			when UnitPrice<=25.00 then 'Low'
            when (UnitPrice >25.00 and UnitPrice<=50.00) then 'Medium'
            else 'High'
end as ClasUnitPrice
from product
order by UnitPrice;