
use studentet_univ;


-- ALIAS
-- Select emri kolones AS emeri_alias from emri_tab

Select Emri_Student as Emri
from studenti;


-- nqs brenda alias duhet te perdorim hapesia atehere duhet ta vendosim ne thonjza

Select Emri_Student as 'Emri Studentit'
from studenti;

-- me shume se sa nje kolone
Select Emri_Student as 'Emri Studentit', Mbiemri_Student as Mbiemri
from studenti;

-- alias emri i tabeles
Select Emri_Student as 'Emri Studentit', Mbiemri_Student as Mbiemri
from studenti as S;

select S.Emri_Student, S.Mbiemri_Student
from studenti as S
where S.Emri_Student = 'ANA';

-- concat 
alter table studenti
add Qyteti varchar(255) default 'Chicago';

select Emri_Student, concat_ws(', ',Adresa, Qyteti) AS 'Adresa e plote'
from studenti;

select Emri_Student, concat(Adresa, ',', Qyteti) AS 'Adresa e plote'
from studenti;

-- funskioni me i mire i mundshem eshte concat_ws per te mos humbur vlera ne kete concatenate
-- concat_ws pranon vlera null dhe nuk shton 'ndaresin'
-- concat nuk pranon vlera null, rikthen serish nje null



--  Ushtrime
-- 1-Kerkoj emrat e studenteve qe jane te rregj ne Finance
SELECT Emri_Student
from studenti
where Kursi_emer = 'Finance';


-- 2- Te paraqiten te gjithe te dhenat e tabeles per ata studente qe i fillon emri me shkronjen 'A'
select Emri_Student from studenti
where Emri_Student like 'A%';


-- 3- Te paraqiten eemart e studenteve te cilet kurset mbarojne me fjalen 'ing'
select Emri_Student from studenti
where Kursi_emer like '%ing';

-- 4- Te gjithe studentet te cilet nuk u fillon emri me shkronjen  M
select Emri_Student from studenti
where Emri_Student not like 'M%';

-- 5- Dua listen e studenteve qe studiojne ne FInance ose IT

SELECT *
from studenti
where Kursi_emer IN ( 'Finance', 'IT');

SELECT *
FROM studenti
WHERE Kursi_emer = 'Finance' OR Kursi_emer= 'IT';

-- 6-Listo studnetet e moshes 21-25 vjec dhe id = 1,4,5,8

SELECT *
FROM studenti
WHERE Mosha BETWEEN 21 AND 25
AND student_id IN (1, 4, 5, 8);

-- 7-Listo te gjithe studentet qe jane ne programim dhe jane mbi 21 vjec 

SELECT *
FROM studenti
WHERE kursi_emer = 'Programming'
AND mosha > 21;

-- 8- Listo emrat e std te cilet nuk std ne programim ose jane nen 22 vjec
SELECT * 
FROM studenti 
WHERE Kursi_emer != 'Programming' 
  OR Mosha < 22;
  
SELECT * 
FROM studenti 
WHERE not (Kursi_emer = 'Programming' and Mosha >= 22);
  
-- 9- Listo emrat e std dhe id te cilet nuk adrese

SELECT *
FROM    studenti
WHERE Adresa IS NULL OR Adresa='';


-- ///////////////////////INDEX///////////////////////////////
-- Create Index eshte nje deklarate e cila perdoret per te krijuar indexe ne tabela
-- Indexet perdoren per te nxjerre te dhena nga databaza ne menyre me te shpejte. 
-- Perdoreusit nuk mund ti shikojne ato, jane vetem per te pershpjetuar kerkimin e Querit

-- sintaksa kur lejon vlera dopion ne column
-- create index index_name
-- on table _name (col1, col2...)

-- sintaksa kur nuk lejon vlera dopion ne column
-- create unique index index_name
-- on table _name (col1, col2...)

create index idx_emri
on studenti (Emri_Student);

create index idx_emri_mb
on studenti (Emri_Student, Mbiemri_Student);

alter table studenti
add Email_std varchar(200);

create unique index idx_email
on studenti (Email_std);


-- ///////////////////////AutoIncrement///////////////////////////////
-- Autoincremetn lejon nje numer unik te gjenerohte automatikisht kur nje rekord i ri shtohet ne tabele
-- Zakonisht perdoret per celsat primar qe te krijohen automatikisht si nje nr rendor dhe plotesohet sa here shtohet nje rekord i ri
-- By default autoincrement fillon em 1 dhe shtohet me 1

create table Studenti11(
	Student_Id int auto_increment,
    Emri_Student varchar (25) not null,
    Mbiemri_Student varchar (25) not null,
    Adresa varchar (255),
    Kursi_emer varchar (255) not null,
    Mosha int,
    primary key (Student_Id)
);

-- populloj kete tabele me te dhena
insert into studenti11 (Emri_Student, Mbiemri_Student, Kursi_emer)
values ('Emri123', 'Mbiemri123', 'ML');
insert into studenti11 (Emri_Student, Mbiemri_Student, Kursi_emer)
values ('Emri123', 'Mbiemri123', 'ML');

alter table studenti11
auto_increment=60;
insert into studenti11 (Emri_Student, Mbiemri_Student, Kursi_emer)
values ('Emri123', 'Mbiemri123', 'ML');

-- ///////////////////////DATES///////////////////////////////
-- Ka disa menyra se si deklarohet data
-- DATE - format YYYY-MM-DD 2023-05-19
-- DATETIME - format: YYYY-MM-DD HH:MI:SS 2023-05-19 14:52:02
-- TIMESTAMP - format: YYYY-MM-DD HH:MI:SS
-- YEAR - format YYYY or YY
-- Normalisht kete lloj te dhene e vendosim kur krijojme tabelen ne fillim

alter table studenti
add date_rregj Date;

update studenti
set date_rregj = '2024-11-06'
where student_id = 1;
update studenti
set date_rregj = '2024-11-01'
where student_id = 2;
update studenti
set date_rregj = '2024-10-16'
where student_id = 3;
update studenti
set date_rregj = '2024-10-31'
where student_id = 4;
update studenti
set date_rregj = '2024-11-03'
where student_id = 5;

select * from studenti 
where date_rregj = '2024-11-03';

select now() as TimeDNow;
select curdate() as DateNow;
select curtime() as TimeNow;

-- listen e studenteve jane rregj deri ne daten 6 ne muajin nentor
select * from studenti
where date_rregj between '2024-11-01' and '2024-11-06';

-- listen e studenteve jane rregj 10 diteshin e fundit
select * from studenti
where date_rregj > date_sub(now(), interval 25 day);

select * from studenti
where date_rregj > date_sub(now(), interval 1 week);

select year(now()) as ThisYear;

select dayofweek(now()) as ThisDay;
select dayname(now()) as ThisDay;

select unix_timestamp(now()) as TimeSec;

select sec_to_time(unix_timestamp(now())) as TimeNow;



-- ///////////////////////VIEW///////////////////////////////

-- Nje VIEW eshte nje tabele virtuale bazuar ne nje statemnt te caktuar. 
-- Ajo ka kolona dhe rreshta si tabelat qe krijojme, por mund te kete te dhenaa nga 1 ose me shume tabela.

-- create view view_name AS
-- select colm1, colm2,..
-- from table_name
-- where condition;

create view StudProg as
select Emri_Student, Mbiemri_Student, Kursi_emer
from studenti
where Kursi_Emer = 'Programming';

select * from StudProg;

create or replace view StudProg as
select Emri_Student, Kursi_emer
from studenti
where Kursi_Emer = 'Programming';

select * from StudProg;