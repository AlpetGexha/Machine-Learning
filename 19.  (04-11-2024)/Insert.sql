create database Studentet_Univ;
use Studentet_Univ;

create table Studenti(
	Student_Id int PRIMARY KEY,
    Emri_Student varchar (25) not null,
    Mbiemri_Student varchar (25) not null,
    Adresa varchar (255),
    Kursi_emer varchar (255) not null,
    Mosha int    
);

-- CHECK / drop fshihet si constraint me siper
alter table Studenti
add check (mosha>=18); 

alter table studenti
add constraint chk_emer_mb check(Emri_Student!='' and Mbiemri_Student!='');

-- Popullimi i tabeles me vlera per cdo rresht dhe kolone, nepermjet inster into

Insert into Studenti (Student_ID, Emri_Student, Mbiemri_Student, Adresa, Kursi_emer, Mosha)
values (1,'MESHIA', 'CRUZ', '82 DIRT ROAD','Programming', 21);
INSERT INTO Studenti (Student_ID, Emri_Student, Mbiemri_Student, Adresa, Kursi_emer, Mosha)
VALUES (3,'JAKE', 'LUCAS', '14 EAST SAVANNAH','Programming', 23);
INSERT INTO Studenti (Student_ID, Emri_Student, Mbiemri_Student, Adresa, Kursi_emer, Mosha)
VALUES (4,'JASMINE', 'LEE', 'P.O. BOX 2947','Finance', 21);
INSERT INTO Studenti (Student_ID, Emri_Student, Mbiemri_Student, Adresa, Kursi_emer, Mosha)
VALUES (5,'BECCA', 'NELSON', 'P.O. BOX 563','Finance', 20);
INSERT INTO Studenti (Student_ID, Emri_Student, Mbiemri_Student, Adresa, Kursi_emer, Mosha)
VALUES (6,'JENNIFER', 'SMITH', 'P.O. BOX 1151','Finance', 19);
INSERT INTO Studenti (Student_ID, Emri_Student, Mbiemri_Student, Adresa, Kursi_emer, Mosha)
VALUES (2,'ANA', 'CRUZ', '','Programming', 21);
INSERT INTO Studenti (Student_ID, Emri_Student, Mbiemri_Student, Kursi_emer, Mosha)
VALUES (7,'Ana', 'CRUZ','Programming', 27);
INSERT INTO Studenti (Student_ID, Emri_Student, Mbiemri_Student, Kursi_emer)
VALUES (8,'Ana', 'CRUZ','Programming');
INSERT INTO Studenti (Student_ID, Emri_Student, Mbiemri_Student, Adresa, Kursi_emer, Mosha)
VALUES (9,'BECCA', 'NELSON', 'P.O. BOX 563','Finance', 26);
INSERT INTO Studenti (Student_ID, Emri_Student, Mbiemri_Student, Adresa, Kursi_emer, Mosha)
VALUES (10,'BECCA', 'NELSON', '','Finance', 18);

-- SELECT
-- select emeri_kolones
-- from emri_tabeles

SELECT * 
FROM studenti;

SELECT Emri_Student, Mosha
FROM studenti;

-- SELECT WHERE
SELECT Emri_Student, Kursi_emer
from studenti
where Kursi_emer = 'Finance';

SELECT Emri_Student, Mbiemri_Student
from studenti
where Kursi_emer = 'Finance';

SELECT Student_Id,Emri_Student, Mosha, Kursi_emer
from studenti
where Kursi_emer = 'Finance' and Mosha <=21;


SELECT Student_Id,Emri_Student, Mosha, Kursi_emer
from studenti
where not(Kursi_emer = 'Finance' and Mosha <=21);

-- Kursi_emer != 'Finance' or Mosha >21

-- order by
SELECT Emri_Student, Mbiemri_Student
from studenti
where Kursi_emer = 'Finance'
order by Emri_Student;

-- math funct
-- count/max/min/avg/sum
select distinct(Kursi_emer)
from studenti;

select count(distinct(Kursi_emer)) as NrKursesh
from studenti;

select max(Mosha) as MoshaMax, min(Mosha) as MoshaMin, avg(Mosha) as MoshaMest
from studenti;

select sum(Mosha) as ShumaMosha
from studenti;

SELECT Emri_Student, Kursi_emer
from studenti
where Kursi_emer = 'Finance'
limit 3;

-- LIKE
select * from studenti
where Emri_Student like 'J%';

select * from studenti
where Emri_Student like '%a';


select * from studenti
where Emri_Student like 'J%e';

select * from studenti
where Emri_Student like 'J_______';

select * from studenti
where Emri_Student not like '%a';

-- IN
Insert into Studenti (Student_ID, Emri_Student, Mbiemri_Student, Adresa, Kursi_emer, Mosha)
values (11,'Freda', 'Dyrkaj', '','Machine Learning', 34);

Insert into Studenti (Student_ID, Emri_Student, Mbiemri_Student, Adresa, Kursi_emer, Mosha)
values (12,'Freda11', 'Dyrkaj', '','Machine Learning', 23);

select Emri_Student, Kursi_emer
from studenti
where Kursi_emer in ('Machine Learning', 'Finance');

-- between
select Emri_Student, Mosha
from studenti
where mosha between 19 and 21;

select Emri_Student, Mosha, Kursi_emer
from studenti
where mosha between 19 and 21
and Kursi_emer in ('Machine Learning', 'Finance');

-- NULL
select * from studenti
where adresa is null;

select * from studenti
where adresa is not null;

-- concat
select Emri_student, Mbiemri_Student, concat(Emri_student, ' ', Mbiemri_Student) as 'Emri i plote'
from studenti;

-- update/drop/delete/truncate
update studenti
set Adresa='Tirane'
where Student_Id = 11;

delete from studenti
where Student_Id = 5;

alter table studenti
drop column Adresa;

truncate table studenti;

drop table studenti;

