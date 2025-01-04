CREATE DATABASE UshtrimJoin;

USE UshtrimJoin;

Create table Kursi(
	Kursi_Id int primary key,
    Emri_Kursi varchar (50),
    Vit int not null,
    Kredit int
);

CREATE table Studenti(
	Student_ID int PRIMARY KEY, 
    Emri_Student varchar(25) NOT NULL,
    Mbiemri_Student varchar(25) NOT NULL,
    Adresa varchar(255),
    Kursi_ID int NOT NULL,
    Mosha int,
    Piket_Prov int,
    -- shtojme kontrolline  moshes per vleren minimale
    check (Mosha >= 18),
    foreign key (Kursi_Id) references Kursi(Kursi_Id)
);



Insert into Kursi (Kursi_Id, Emri_Kursi, Vit, Kredit)
values(1, 'Programming', 2, 3);
Insert into Kursi (Kursi_Id, Emri_Kursi, Vit, Kredit)
values(2, 'Finance', 2, 3);
Insert into Kursi (Kursi_Id, Emri_Kursi, Vit, Kredit)
values(3, 'IT', 1, 6);
Insert into Kursi (Kursi_Id, Emri_Kursi, Vit, Kredit)
values(4, 'Math', 1, 6);
Insert into Kursi (Kursi_Id, Emri_Kursi, Vit, Kredit)
values(5, 'Computer Science', 1, 4);

set foreign_key_checks = 0;

-- mbush me vlera tabelen studenti
INSERT INTO Studenti (Student_ID, Emri_Student, Mbiemri_Student, Adresa, Kursi_ID, Mosha, Piket_Prov)
VALUES (1,'MESHIA', 'CRUZ', '82 DIRT ROAD',1, 21, 150);
INSERT INTO Studenti (Student_ID, Emri_Student, Mbiemri_Student, Adresa, Kursi_ID, Mosha, Piket_Prov)
VALUES (2, 'Wilman', 'Kala', '82 DIRT ROAD',1, 19, 155);
INSERT INTO Studenti (Student_ID, Emri_Student, Mbiemri_Student, Adresa, Kursi_ID, Mosha, Piket_Prov)
VALUES (3,'JAKE', 'LUCAS', '14 EAST SAVANNAH',1, 23, 190);
INSERT INTO Studenti (Student_ID, Emri_Student, Mbiemri_Student, Adresa, Kursi_ID, Mosha, Piket_Prov)
VALUES (4,'JASMINE', 'LEE', 'P.O. BOX 2947',2, 21, 200);
INSERT INTO Studenti (Student_ID, Emri_Student, Mbiemri_Student, Adresa, Kursi_ID, Mosha, Piket_Prov)
VALUES (5,'BECCA', 'NELSON', 'P.O. BOX 563',2, 20,170);
INSERT INTO Studenti (Student_ID, Emri_Student, Mbiemri_Student, Adresa, Kursi_ID, Mosha, Piket_Prov)
VALUES (6,'JENNIFER', 'SMITH', 'P.O. BOX 1151',2, 19, 170);
INSERT INTO Studenti (Student_ID, Emri_Student, Mbiemri_Student, Adresa, Kursi_ID, Mosha, Piket_Prov)
VALUES (7,'WILMAN ', 'KALA', '82 DIRT ROAD',2, 22, 100);
INSERT INTO Studenti (Student_ID, Emri_Student, Mbiemri_Student, Adresa, Kursi_ID, Mosha, Piket_Prov)
VALUES (8,'CARDINAL ', 'KARL', 'SKAGEN 21',3, 22, 180);
INSERT INTO Studenti (Student_ID, Emri_Student, Mbiemri_Student, Adresa, Kursi_ID, Mosha, Piket_Prov)
VALUES (9,'CARDINAL ', 'KARL', 'SKAGEN 21',3, 22, 180);
INSERT INTO Studenti (Student_ID, Emri_Student, Mbiemri_Student, Adresa, Kursi_ID, Mosha, Piket_Prov)
VALUES (10,'CARDINAL ', 'KARL', 'SKAGEN 21',9, 22, 180);


-- Inner Join: kthen te gjitha te dhenat qe kane vlera te perbashketa ne te dyja tabelat
-- Krijo nje query e cila paraqet te gjithe studentet sipas kurseve te regjistruara
select studenti.Student_ID, studenti.Emri_Student, k.Emri_Kursi, k.Kredit
from kursi as k
inner join studenti on studenti.Kursi_id = k.Kursi_id;

-- LEFT JOIN i cili kthen te gjitha rekorder e tabeles se majte, dhe rekordet e tables se djathte
-- nqs ka vlere te njejta, qe pepruthen nga kjo tabele
-- kursi tabela e majte dhe studenti tabela e djathte

select studenti.Student_ID, studenti.Emri_Student, k.Emri_Kursi, k.Kredit
from kursi as k
left join studenti on studenti.Kursi_id = k.Kursi_id;


-- RIGHT JOIN kthen te gjitha rekordet e tabeles se djathte (studenti), 
-- edhe pse nuk ka match me tabelen e majte qe eshte kursi

select studenti.Student_ID, studenti.Emri_Student, k.Emri_Kursi, k.Kredit
from kursi as k
right join studenti on studenti.Kursi_id = k.Kursi_id;


-- cross join: nxjerr kombinimet e te dyja tabelave

select studenti.Student_ID, studenti.Emri_Student, k.Emri_Kursi, k.Kredit
from kursi as k
cross join studenti;

-- self join qe eshte nje join i rregullt por qe tabela eshte e lidhur me veten  e vet
-- sintaxa
-- select columns_name
-- from tabl1 t1, table1 t2
-- where condition;
select studenti.Student_ID, studenti.Emri_Student, k.Emri_Kursi, k.Kredit
from kursi as k, studenti
where studenti.Kursi_id = k.Kursi_id;


-- 1- Paraqit emrat e studenteve te renditur sipas rendit alfabetik, kurset ku jane rregj, dhe mosha mbi 21 vjec

select s.Emri_Student, s.Mosha, kursi.Emri_Kursi
from studenti as s
inner join kursi on s.Kursi_Id = kursi.Kursi_Id
where s.mosha>21
order by s.Emri_Student;


-- 2- Listojme te gjithe studentet (emer, mbiemer) te cilet jane rregj ne Finance dhe kane mare me shume se 150 pike
select s.Emri_Student, s.Mbiemri_Student, kursi.Emri_Kursi, s.Piket_Prov
from studenti as s
inner join kursi on s.Kursi_Id = kursi.Kursi_Id
where s.Piket_Prov>150 and kursi.Emri_Kursi='Finance';

-- 3 - Listojme te gjitha kurset me studentet perkates qe kane kaluar ne keto kurse( me shume se 150 pike)
select kursi.Emri_Kursi, s.Emri_Student,s.Piket_Prov
from studenti as s
left join kursi on s.Kursi_Id = kursi.Kursi_Id
where s.Piket_Prov>150;


-- 4- Listojme te gjithe studentet kalues te vitit te 2, dhe emrin e kursit
select  s.Emri_Student, kursi.Emri_Kursi,Kursi.Vit
from studenti as s
left join kursi on s.Kursi_Id = kursi.Kursi_Id
where s.Piket_Prov>150 and kursi.Vit = 2;

-- 5 Shkruaj nje query qe gjen emrat e studenteve qe kane marre maximumin dhe minimumin e pikeve te marra ne provim
select Emri_Student, Piket_Prov
from studenti
where piket_prov = (select min(piket_prov) from studenti)
or piket_prov = (select max(piket_prov) from studenti);



-- 7- gjej studentet kalues ne IT nepermjet ku kalues mbi 150 dhe jane viti i pare

select  s.Emri_Student, kursi.Emri_Kursi,s.piket_prov,kursi.Vit
from studenti as s
left join kursi on s.Kursi_Id = kursi.Kursi_Id
where s.Piket_Prov>150 and kursi.Vit = 1 and kursi.Emri_Kursi='IT';
